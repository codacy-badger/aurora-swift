#if os(iOS)
import Foundation
import HomeKit

public final class HomeKitConnector: NSObject, HMHomeManagerDelegate, HMHomeDelegate, HMAccessoryDelegate, Connectable {
    public enum EventName: String {
        case stateUpdate = "homeKitStateUpdate"
        case startDeviceDiscovery = "homeKitStartDeviceDiscovery"
        case homeSelection = "homeKitHomeSelection"
    }

    public struct State: Equatable {
        public var home: String?
        public var homeSelection: [String]

        public init(home: String? = nil, homeSelection: [String] = []) {
            self.home = home
            self.homeSelection = homeSelection
        }

        public static func == (lhs: State, rhs: State) -> Bool {
            return lhs.home == rhs.home && lhs.homeSelection == rhs.homeSelection
        }
    }

    public static let type = "homeKit"

    private var state = State() {
        didSet {
            if oldValue != state {
                send(state)
            }
        }
    }

    private let homeManager = HMHomeManager()

    public var onSync: ([Light]) -> Void = { _ in }
    public var onEvent: (Event) -> Void = { _ in }

    private var home: HMHome? {
        didSet {
            home?.delegate = self
            home?.accessories.forEach { $0.delegate = self }
            sync()
        }
    }

    override public init() {
        super.init()
        homeManager.delegate = self
    }

    public func connect(onSync: @escaping ([Light]) -> Void, onEvent: @escaping (Event) -> Void) {
        self.onSync = onSync
        self.onEvent = onEvent
        send(state)
        print("HomeKit Connector: Init")
        loop()
    }

    private func loop() {
        print("HomeKit Connector: Timed sync")
        sync()
        DispatchQueue.main.asyncAfter(deadline: .now() + 7.0) { [weak self] in
            self?.loop()
        }
    }

    private func send(_ state: State) {
        onEvent(
            Event(name: EventName.stateUpdate.rawValue, type: HomeKitConnector.type, payload: state)
        )
    }

    private func sync() {
        guard let home = home else {
            return
        }

        onSync(
            home.lights.compactMap { accessory in
                guard let lightService = accessory.lightService else { return nil }

                let lightState = Light.State(
                    hue: lightService.characteristics.first { $0.characteristicType == HMCharacteristicTypeHue }?.value as? Float ?? 0.0,
                    saturation: lightService.characteristics.first { $0.characteristicType == HMCharacteristicTypeSaturation }?.value as? Float ?? 1.0,
                    brightness: lightService.characteristics.first { $0.characteristicType == HMCharacteristicTypeBrightness }?.value as? Float ?? 1.0,
                    isPowered: lightService.characteristics.first { $0.characteristicType == HMCharacteristicTypePowerState }?.value as? Bool ?? true
                )

                let light = Light(
                    identifier: UUID(),
                    name: accessory.name,
                    type: HomeKitConnector.type,
                    state: accessory.isReachable ? lightState : nil,
                    manufacturerIdentifier: accessory.uniqueIdentifier.uuidString,
                    model: nil
                )
                return light
            }
        )

//        onSync(
//            home.allColorfulLightServices.map { service in
//                let lightState = Light.State(
//                    hue: service.characteristics.first { $0.characteristicType == HMCharacteristicTypeHue }?.value as? Float ?? 0.0,
//                    saturation: service.characteristics.first { $0.characteristicType == HMCharacteristicTypeSaturation }?.value as? Float ?? 1.0,
//                    brightness: service.characteristics.first { $0.characteristicType == HMCharacteristicTypeBrightness }?.value as? Float ?? 1.0,
//                    isPowered: service.characteristics.first { $0.characteristicType == HMCharacteristicTypePowerState }?.value as? Bool ?? true
//                )
//
//                let light = Light(
//                    identifier: UUID(),
//                    name: service.name,
//                    type: HomeKitConnector.type,
//                    state: service.accessory?.isReachable ?? false ? lightState : nil,
//                    manufacturerIdentifier: service.name,
//                    model: service.characteristics.first { $0.characteristicType == HMCharacteristicTypeModel }?.value as? String
//                )
//                return light
//            }
//        )
    }

    public func perform(lightUpdate: Light.Update) {
        guard
            let manufacturerIdentifier = UUID(uuidString: lightUpdate.manufacturerIdentifier),
            let accessory = home?.lights.first(where: { $0.uniqueIdentifier == manufacturerIdentifier }) else { return }

        accessory.lightServices.forEach { lightService in
            lightService.characteristics.forEach { characteristic in
                if characteristic.characteristicType == HMCharacteristicTypePowerState {
                    characteristic.writeValue( lightUpdate.state.isPowered, completionHandler: errorHandler)
                } else if
                    characteristic.characteristicType == HMCharacteristicTypeBrightness,
                    let brightness = lightUpdate.state.brightness {
                    let value = characteristic.relativeValue(brightness)
                    characteristic.writeValue(value, completionHandler: errorHandler)
                } else if
                    characteristic.characteristicType == HMCharacteristicTypeHue,
                    let hue = lightUpdate.state.hue {
                    let value = characteristic.relativeValue(hue, maximum: 360.0)
                    characteristic.writeValue(value, completionHandler: errorHandler)
                } else if
                    characteristic.characteristicType == HMCharacteristicTypeSaturation,
                    let saturation = lightUpdate.state.saturation {
                    let value = characteristic.relativeValue(saturation)
                    characteristic.writeValue(value, completionHandler: errorHandler)
                }
            }
        }
    }

    func errorHandler(error: Error?) {
        if let error = error {
            print(error)
        }
    }

    public func send(event: Event) {
        switch event.name {
        /// Process Device Discovery
        case EventName.startDeviceDiscovery.rawValue:
            print("HomeKit: Add Accessories")

            if let home = home {
                home.addAndSetupAccessories(completionHandler: { _ in })
            } else {
                print("HomeKit: No active homes")
            }
        /// Process Home Selection Event
        case EventName.homeSelection.rawValue:
            guard let homeName = event.payload as? String else {
                return
            }
            let newSelectedHome = homeManager.homes.first(where: { $0.name == homeName })
            home = newSelectedHome
            state.home = newSelectedHome?.name
        /// Send state upstream
        case EventName.stateUpdate.rawValue:
            print("HomeKit Connector: User requested state update")
            send(state)

        default:
            break
        }
    }

    // MARK: HomeManager Delegate

    public func homeManagerDidUpdateHomes(_ manager: HMHomeManager) {
        print("Did Update Homes")
        print(manager.homes)

        if let primaryHome = manager.primaryHome {
            self.home = primaryHome

            state = State(home: home?.name, homeSelection: manager.homes.map { $0.name })
        } else {
            print("HomeKit Connector: Creating a default Home")
            manager.addHome(withName: "Home") { home, error in
                if home != nil {
                    self.homeManagerDidUpdateHomes(manager)
                } else {
                    print(error ?? "no error")
                }
            }
        }
    }

    public func homeManagerDidUpdatePrimaryHome(_ manager: HMHomeManager) {
        print("Did Update Primary home")
    }

    public func homeManager(_ manager: HMHomeManager, didAdd home: HMHome) {
        state.homeSelection = manager.homes.map { $0.name }
    }

    public func homeManager(_ manager: HMHomeManager, didRemove home: HMHome) {
        state.homeSelection = manager.homes.map { $0.name }
    }

    // MARK: HMHomeDelegate

    public func home(_ home: HMHome, didAdd accessory: HMAccessory) {
        print("Did Add Accessory")
        sync()
    }

    public func home(_ home: HMHome, didEncounterError error: Error, for accessory: HMAccessory) {
        sync()
    }

    public func home(_ home: HMHome, didUnblockAccessory accessory: HMAccessory) {
        sync()
    }

    // MARK: Accessory Delegate

    public func accessoryDidUpdateName(_ accessory: HMAccessory) {
        sync()
    }

    public func accessoryDidUpdateReachability(_ accessory: HMAccessory) {
        print("HomeKit Connector: Did Update Reachability", accessory.name)
        sync()
    }

    public func accessory(_ accessory: HMAccessory, didUpdateNameFor service: HMService) {
        sync()
    }

    public func accessory(_ accessory: HMAccessory, service: HMService, didUpdateValueFor characteristic: HMCharacteristic) {}

    deinit {
        print("HomeKit connector deallocated")
    }
}

extension HMService {
    var isLight: Bool {
        return self.serviceType == HMServiceTypeLightbulb
    }

    var isColorfulLight: Bool {
        return
            self.serviceType == HMServiceTypeLightbulb &&
                self.characteristics.contains { $0.characteristicType == HMCharacteristicTypeHue }
    }
}

extension HMAccessory {
    var isLight: Bool {
        return isBridged ? services.contains { $0.serviceType == HMServiceTypeLightbulb } : category.categoryType == HMAccessoryCategoryTypeLightbulb
    }

    var lightService: HMService? {
        return self.services.first { $0.isLight }
    }

    var lightServices: [HMService] {
        return self.services.filter { $0.isLight }
    }
}

extension HMHome {
    var lights: [HMAccessory] {
        return accessories.filter { $0.isLight }
    }

    /// All the services within all the accessories within the home.
    var allServices: [HMService] {
        return accessories.reduce([]) { accumulator, accessory -> [HMService] in
            accumulator + accessory.services.filter { !accumulator.contains($0) }
        }
    }

    var allColorfulLightServices: [HMService] {
        return allServices.filter { $0.isColorfulLight }
    }

    func bridgeSerial(for device: HMAccessory?) -> String? {
        guard let device = device else {
            return nil
        }
        if !device.isBridged {
            return nil
        }
        for bridge in self.accessories {
            if let
                identifiers = bridge.uniqueIdentifiersForBridgedAccessories,
                identifiers.contains(device.uniqueIdentifier) {
                    return bridge.services.first { $0.serviceType == HMServiceTypeAccessoryInformation }?
                        .characteristics.first {
                            $0.characteristicType == HMCharacteristicTypeSerialNumber
                        }?.value as? String
            }
        }
        return nil
    }
}

extension HMCharacteristic {
    func relativeValue(_ value: Float, minimum: Float = 0.0, maximum: Float = 100.0, step: Float = 1.0) -> Float {
        let max = self.metadata?.maximumValue as? Float ?? maximum
        let min = self.metadata?.minimumValue as? Float ?? minimum

        let relativeValue = round(((max - min) + min) * value)

        return relativeValue
    }
}
#endif
