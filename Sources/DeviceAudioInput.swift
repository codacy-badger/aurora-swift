#if os(iOS) || os(macOS)
import Foundation
import AVFoundation
import CoreAudio

public class DeviceAudioInput: NSObject, AudioInputable, AVAudioRecorderDelegate, AVAudioPlayerDelegate {
    public var processor: AudioProcessor = AudioProcessor()

    private var onLevel: (Float) -> Void = { _ in }

    public var audioLevel: Float = 0.0

    var updateInputLevels: Bool = false {
        didSet {
            if oldValue != updateInputLevels {
                audioLevelsLoop()
            }
        }
    }

    var recorder: AVAudioRecorder?

    public override required init() {
        super.init()
    }

    #if os(iOS)
    public func start(onLevel: @escaping (Float) -> Void) {
        self.onLevel = onLevel
        if recorder == nil { setup() }
        updateInputLevels = true
        print("MicrophoneConnector : Start")
    }

    public func stop() {
        recorder = nil
        updateInputLevels = false
        try? AVAudioSession.sharedInstance().setActive(false)
    }

    private func setup() {

        switch AVAudioSession.sharedInstance().recordPermission {
        case AVAudioSession.RecordPermission.granted:
            print("Pemission granted")

        case AVAudioSession.RecordPermission.denied:
            print("Pemission denied")
            //showRecordPermissionsDeniedAlert()

        case AVAudioSession.RecordPermission.undetermined:
            print("Request permission here")
        }

        //URL(fileURLWithPath: "/dev/null")
        let outputURL = NSURL.fileURL(withPath: "/dev/null")

        //1. create the session
        let session = AVAudioSession.sharedInstance()

        do {
            // 2. configure the session for recording and playback
            //try session.setCategory(AVAudioSessionCategoryPlayAndRecord)
            try session.setActive(true)
            // 3. set up a high-quality recording session
            let settings = [
                AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                AVSampleRateKey: 44100,
                AVNumberOfChannelsKey: 1,
                AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
            ]
            // 4. create the audio recording, and assign ourselves as the delegate
            recorder = try AVAudioRecorder(url: outputURL, settings: settings)
            recorder?.isMeteringEnabled = true
            recorder?.delegate = self
            recorder?.record()
        } catch let error {
            print(error)
        }
    }

    #elseif os(macOS)

    public func start(onLevel: @escaping (Float) -> Void) {
        self.onLevel = onLevel

        if recorder == nil {
            if #available(OSX 10.14, *) {
                switch AVCaptureDevice.authorizationStatus(for: .audio) {
                case .authorized: // The user has previously granted access to the camera.
                    self.setup()

                case .notDetermined: // The user has not yet been asked for camera access.
                    AVCaptureDevice.requestAccess(for: .audio) { granted in
                        if granted {
                            self.setup()
                            self.updateInputLevels = true
                            return
                        }
                    }
                case .denied: // The user has previously denied access.
                    return
                case .restricted: // The user can't grant access due to restrictions.
                    return
                }
            } else {
                // Fallback on earlier versions
                self.setup()
            }
        }
        updateInputLevels = true
        print("MicrophoneConnector : Start")
    }

    public func stop() {
        recorder = nil
        updateInputLevels = false
    }

    private func setup() {

        let outputURL = NSURL.fileURL(withPath: "/dev/null")

        do {
            let settings = [
                AVFormatIDKey: Int(kAudioFormatAppleLossless),
                AVSampleRateKey: 44100,
                AVNumberOfChannelsKey: 1,
                AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
            ]

            recorder = try AVAudioRecorder(url: outputURL, settings: settings)
            recorder?.isMeteringEnabled = true
            recorder?.delegate = self
            recorder?.record()
        } catch let error {
            print(error)
            // failed to record!
        }
    }

    #endif

    func audioLevelsLoop() {

        if updateInputLevels == false {
            recorder?.stop()
            return
        }
        if recorder?.isRecording == false { recorder?.record() }

        self.processAudioLevels()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
            self.audioLevelsLoop()
        }

    }

    private func processAudioLevels() {
        recorder?.updateMeters()

        let minDecibels: Float = -160.0 // -60dB for a silent room
        let decibels = recorder?.averagePower(forChannel: 0) ?? 0
        let root: Float = 2.0
        let minAmp = powf(10.0, 0.05 * minDecibels)
        let inverseAmpRange = 1.0 / (1.0 - minAmp)
        let amp = powf(10.0, 0.05 * decibels)
        let adjAmp = (amp - minAmp) * inverseAmpRange

        let level: Float = Float(powf(adjAmp, 1.0 / root))

        if level >= 1.0 {
            audioLevel = 1.0
            return
        }

        if level < 0.0 {
            audioLevel = 0.0
            return
        }

        audioLevel = level
    }
}
#endif
