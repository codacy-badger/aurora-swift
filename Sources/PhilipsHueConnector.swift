import Foundation
#if os(iOS)
import HueSDK
#endif

public final class PhilipsHueConnector: NSObject, Connectable, PHSBridgeConnectionObserver, PHSBridgeStateUpdateObserver, PHSFindNewDevicesCallback {
    public struct State: Equatable {
        public var bridge: Bridge?
        public var isSearchingForBridges: Bool = false

        public init(bridge: Bridge? = nil, isSearchingForBridges: Bool = false) {
            self.bridge = bridge
            self.isSearchingForBridges = isSearchingForBridges
        }
    }

    public struct Bridge: Equatable {
        public let ip: String
        public let id: String
        public var isAuthenticationRequired: Bool
        public var isSearchingForLights: Bool
    }

    public enum EventName: String {
        case stateUpdate = "philipsHueStateUpdate"
        case bridgeSelection = "philipsHueBridgeSelection"
        case resetBridge = "philipsHueResetBridge"
        case findLights = "philipsHueFindLights"
        case findLightsEnded = "philipsHueFindLightsEnded"
    }

    internal private(set) var state = State(bridge: nil, isSearchingForBridges: false) {
        didSet { if oldValue != state { send(state: self.state) } }
    }

    public static let type: String = "philipsHue"

    private lazy var bridgeDiscovery = PHSBridgeDiscovery()

    private var bridge: PHSBridge?

    public var onSync: ([Light]) -> Void = { _ in }
    public var onEvent: (Event) -> Void = { _ in }

    private let appName: String
    private let deviceId: String
    private let deviceName: String

    public init(appName: String, deviceName: String, deviceId: String) {
        self.appName = appName
        self.deviceName = deviceName
        self.deviceId = deviceId
        super.init()
    }

    public func connect(onSync: @escaping ([Light]) -> Void, onEvent: @escaping (Event) -> Void) {
        self.onSync = onSync
        self.onEvent = onEvent

        /// Configure SDK
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        PHSPersistence.setStorageLocation(documentsPath, andDeviceId: deviceId)
        //PHSLog.setConsoleLogLevel(.debug)

        if let lastConnectedKnownBridge = PHSKnownBridges.getAll()?.min(by: { $0.lastConnected < $1.lastConnected }) {
            let bridge = Bridge(ip: lastConnectedKnownBridge.ipAddress, id: lastConnectedKnownBridge.uniqueId, isAuthenticationRequired: false, isSearchingForLights: false)
            print("PhilipsHueConnector: Known Bridge", bridge.ip, bridge.id)
            update(bridge: bridge)
        }

        start()
    }

    private func start() {
        print("PhilipsHueConnector: Connecting")
        if let bridge = bridge {
            self.bridge?.bridgeState.add(self)
            bridge.connect()
        } else {
            startBridgeDiscovery()
        }
    }

    private func startHeartbeat() {
        print("PhilipsHueConnector: Starting Heartbeat")
        if let connection: PHSBridgeConnection = self.bridge?.bridgeConnections().first {
            connection.heartbeatManager.startHeartbeat(with: .fullConfig, interval: 10)
        }
    }

    private func startBridgeDiscovery() {
        guard state.isSearchingForBridges == false else {
            print("PhilipsHueConnector: already searching for bridges")
            return
        }
        state.isSearchingForBridges = true
        print("PhilipsHueConnector: Start bridge discovery")
        bridgeDiscovery.search { [weak self] results, _ in
            self?.state.isSearchingForBridges = false
            if let results = results, let result = results.first {
                print("PhilipsHueConnector: Bridge discovered: ", result.ip, result.uniqueId)
                let bridge = Bridge(ip: result.ip, id: result.uniqueId, isAuthenticationRequired: false, isSearchingForLights: false)
                self?.update(bridge: bridge)
                self?.start()
            } else {
                print("PhilipsHueConnector: Bridge discovered: Nothing Found")
                self?.start()
            }
        }
    }

    private func update(bridge: Bridge) {
        self.state.bridge = bridge
        self.bridge = self.buildBridge(info: bridge)
    }

    private func forgetBridge() {
        self.state.bridge = nil
        self.bridge = nil
    }

    private func buildBridge(info: Bridge) -> PHSBridge {
        // Replace app name and device name
        return PHSBridge(block: { builder in
            builder?.connectionTypes = .local
            builder?.ipAddress = info.ip
            builder?.bridgeID = info.id
            builder?.bridgeConnectionObserver = self
        }, withAppName: appName,
           withDeviceName: deviceName
        )
    }

    private func startLightsDiscovery() {
        guard state.bridge?.isSearchingForLights == false else {
            print("PhilipsHueConnector: Bridge is already searching for new lights")
            return
        }
        state.bridge?.isSearchingForLights = true
        bridge?.findNewDevices(withAllowedConnections: .local, callback: self)
    }

    public func bridge(_ bridge: PHSBridge, didFind devices: [PHSDevice], errors: [PHSError]) {
        syncLights()
    }

    public func bridge(_ bridge: PHSBridge, didFinishSearch errors: [PHSError]) {
        state.bridge?.isSearchingForLights = false
    }

    /// MARK: PHSBridgeConnectionObserver

    public func bridgeConnection(_ bridgeConnection: PHSBridgeConnection, handle connectionEvent: PHSBridgeConnectionEvent) {
        switch connectionEvent {
        /// Authentication
        case .notAuthenticated:
            print("PhilipsHueConnector: Connection Event: Not Authenticated")

        case .linkButtonNotPressed:
            print("PhilipsHueConnector: Connection Event: Link button not pressed")
            state.bridge?.isAuthenticationRequired = true

        case .authenticated:
            print("PhilipsHueConnector: Connection Event: Authenticated")
            state.bridge?.isAuthenticationRequired = false
            startHeartbeat()

        /// Connection
        case .connected:
            print("PhilipsHueConnector: Connection Event: Connected")

        case .connectionRestored:
            print("PhilipsHueConnector: Connection Event: Connection Restored")

        case .connectionLost, .disconnected, .couldNotConnect, .bridgeIdMismatch:
            print("PhilipsHueConnector: Connection Event: Unable to connect")
            forgetBridge()
            start()

        /// Remote connection
        case .loginInvalidated, .loginRequired, .noBridgeForPortalAccount, .tokenBridgeMismatch, .tokenUnknown, .tokenExpired:
            print("PhilipsHueConnector: Connection Event: Remove connection failed")

        /// Other
        case .rateLimitQuotaViolation:
            print("PhilipsHueConnector: Connection Event: Rate limit quota violation")

        case .none:
            print("PhilipsHueConnector: Connection Event: None")
        }
    }

    public func bridgeConnection(_ bridgeConnection: PHSBridgeConnection, handleErrors connectionErrors: [PHSError]) {
        print(connectionErrors)
    }

    /// MARK: PHSBridgeStateUpdateObserver
    public func bridge(_ bridge: PHSBridge, handle updateEvent: PHSBridgeStateUpdatedEvent) {
        switch updateEvent {
        case .fullConfig:
            print("HueController: Update Event: Full Config")
            syncLights()

        case .initialized:
            print("HueController: Update Event: Initialized")

        default:
            print("HueController: Update Event")
        }
    }

    private func syncLights() {
        guard let lights = bridge?.bridgeState
            .getDevicesOf(.light)?
            .compactMap({ $0 as? PHSLightPoint })
            .filter({ $0.lightType == .color || $0.lightType == .extendedColor }) else { return }

        guard let bridge = self.bridge else {
            return
        }

        onSync(
            lights.map { light in
                let lightState = Light.State(
                    hue: light.lightState.hue.floatValue / 65_535,
                    saturation: light.lightState.saturation.floatValue / 254,
                    brightness: light.lightState.brightness.floatValue / 254,
                    isPowered: light.lightState.on.boolValue
                )

                let light = Light(
                    identifier: UUID(),
                    name: light.name,
                    type: PhilipsHueConnector.type,
                    state: light.lightState.reachable.boolValue ? lightState : nil,
                    manufacturerIdentifier: light.identifier,
                    bridgeIdentifier: bridge.identifier,
                    model: light.lightInfo.modelId
                )
                return light
            }
        )
    }

    func send(state: State) {
        onEvent(
            Event(name: "philipsHueStateUpdate", type: PhilipsHueConnector.type, payload: state)
        )
    }

    public func perform(lightUpdate: Light.Update) {
        let state = PHSLightState()
        state.on = NSNumber(value: lightUpdate.state.isPowered)

        if lightUpdate.state.isPowered {
            if let hue = lightUpdate.state.hue {
                state.hue = NSNumber(value: Int(hue * 65_535))
            }

            if let saturation = lightUpdate.state.saturation {
                state.saturation = NSNumber(value: Int(saturation * 254))
            }

            if let brightness = lightUpdate.state.brightness {
                state.brightness = NSNumber(value: Int(brightness * 254))
            }
        }

        state.transitionTime = NSNumber(value: Int(lightUpdate.transitionTime * 10))

        if let lightPoint = bridge?.bridgeState.getDeviceOf(.light, withIdentifier: lightUpdate.manufacturerIdentifier) as? PHSLightPoint {
            lightPoint.update(state, allowedConnectionTypes: .local) { _, errors, _ in
                if let errors = errors {
                    print(errors)
                }
            }
        }
    }

    public func send(event: Event) {
        switch event.name {
        case EventName.resetBridge.rawValue:
            print("PhilipsHueConnector: User requested reset bridge")
            forgetBridge()
            start()

        case EventName.findLights.rawValue:
            print("PhilipsHueConnector: User requested find lights")
            startLightsDiscovery()

        /// Send state upstream
        case EventName.stateUpdate.rawValue:
            print("PhilipsHueConnector: User requested state update")
            send(state: self.state)

        default:
            break
        }
    }

    deinit {
        print("HueConnector: Deinit")
        bridgeDiscovery.stop()
    }
}
