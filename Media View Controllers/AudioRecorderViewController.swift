import UIKit
import AVFoundation

final class AudioRecorderViewController: UIViewController {
    
    private var audioRecorder: AVAudioRecorder?
    private var audioPlayer: AVAudioPlayer?
    private var isRecording = false
    private var isPlaying = false
    
    private lazy var recordButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Start Recording", for: .normal)
        button.addTarget(self, action: #selector(recordAudio), for: .touchUpInside)
        return button
    }()
    
    private lazy var playButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Play Recording", for: .normal)
        button.addTarget(self, action: #selector(playAudio), for: .touchUpInside)
        button.isEnabled = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        setupAudioSession()
        requestMicrophoneAccess()
    }
    
    private func setupUI() {
        let stackView = UIStackView(arrangedSubviews: [recordButton, playButton])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func requestMicrophoneAccess() {
        AVAudioSession.sharedInstance().requestRecordPermission { [weak self] granted in
            DispatchQueue.main.async {
                if granted {
                    print("Microphone access granted")
                } else {
                    print("Microphone access denied")
                    self?.recordButton.isEnabled = false
                    self?.playButton.isEnabled = false
                }
            }
        }
    }
    
    @objc private func recordAudio() {
        if isRecording {
            audioRecorder?.stop()
            isRecording = false
            recordButton.setTitle("Start Recording", for: .normal)
            playButton.isEnabled = true
        } else {
            startRecording()
        }
    }
    
    @objc private func playAudio() {
        if isPlaying {
            audioPlayer?.stop()
            isPlaying = false
            playButton.setTitle("Play Recording", for: .normal)
        } else {
            startPlayback()
        }
    }
    
    private func startRecording() {
        let audioFilename = getDocumentsDirectory().appendingPathComponent("recording.m4a")
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 44100,
            AVNumberOfChannelsKey: 2,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        do {
            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
            audioRecorder?.delegate = self
            audioRecorder?.record()
            
            isRecording = true
            recordButton.setTitle("Stop Recording", for: .normal)
            playButton.isEnabled = false
        } catch {
            finishRecording(success: false)
        }
    }
    
    private func finishRecording(success: Bool) {
        audioRecorder?.stop()
        audioRecorder = nil
        
        if success {
            playButton.isEnabled = true
        } else {
            playButton.isEnabled = false
            // Handle the error (e.g., show an alert)
        }
        
        isRecording = false
        recordButton.setTitle("Start Recording", for: .normal)
    }
    
    private func startPlayback() {
        let audioFilename = getDocumentsDirectory().appendingPathComponent("recording.m4a")
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: audioFilename)
            audioPlayer?.delegate = self
            audioPlayer?.play()
            
            isPlaying = true
            playButton.setTitle("Stop Playback", for: .normal)
        } catch {
            // Handle playback error (e.g., show an alert)
        }
    }
    
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}

private func setupAudioSession() {
    do {
        try AVAudioSession.sharedInstance().setCategory(.playAndRecord, mode: .default, options: [.defaultToSpeaker, .allowBluetooth])
        try AVAudioSession.sharedInstance().setActive(true)
    } catch {
        print("Failed to set up audio session:", error)
    }
}

extension AudioRecorderViewController: AVAudioRecorderDelegate, AVAudioPlayerDelegate {
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        finishRecording(success: flag)
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        isPlaying = false
        playButton.setTitle("Play Recording", for: .normal)
    }
}
