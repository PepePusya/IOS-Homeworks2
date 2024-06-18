//
//  MediaViewController.swift
//  Navigation
//
//  Created by Anna Zaytseva on 2024/06/19.
import UIKit
import AVFoundation

class MediaViewController: UIViewController {
    
    private var player: AVPlayer?
    private var playerItem: AVPlayerItem?
    private var isPlaying = false
    private var currentTrackIndex = 0
    
    private let trackNames = [
        "Макс Корж - Малиновый закат",
        "03 Last of us",
        "Klaas feat. Emmie Lee - Heroes 2021",
        "Miyagi & Эндшпиль - Fire Man",
        "Track 5"
    ]
    
    private let trackURLs: [URL] = {
        var urls = [URL]()
        for i in 1...5 {
            if let url = Bundle.main.url(forResource: "track\(i)", withExtension: "mp3") {
                urls.append(url)
            }
        }
        return urls
    }()
    
    private lazy var playPauseButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Play", for: .normal)
        button.addTarget(self, action: #selector(playPauseButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var stopButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Stop", for: .normal)
        button.addTarget(self, action: #selector(stopButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var trackLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = trackNames[currentTrackIndex]
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadTrack(index: currentTrackIndex)
    }
    
    private func setupUI() {
        view.addSubview(playPauseButton)
        view.addSubview(stopButton)
        view.addSubview(trackLabel)
        
        playPauseButton.translatesAutoresizingMaskIntoConstraints = false
        stopButton.translatesAutoresizingMaskIntoConstraints = false
        trackLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            playPauseButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            playPauseButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            stopButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stopButton.topAnchor.constraint(equalTo: playPauseButton.bottomAnchor, constant: 20),
            
            trackLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            trackLabel.bottomAnchor.constraint(equalTo: playPauseButton.topAnchor, constant: -20)
        ])
        
        let nextButton = UIButton(type: .system)
        nextButton.setTitle("Next", for: .normal)
        nextButton.addTarget(self, action: #selector(nextButtonPressed), for: .touchUpInside)
        view.addSubview(nextButton)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.topAnchor.constraint(equalTo: stopButton.bottomAnchor, constant: 20)
        ])
    }
    
    private func loadTrack(index: Int) {
        guard index >= 0 && index < trackURLs.count else { return }
        let url = trackURLs[index]
        playerItem = AVPlayerItem(url: url)
        player = AVPlayer(playerItem: playerItem)
        trackLabel.text = trackNames[index]
    }
    
    @objc private func playPauseButtonPressed() {
        guard let player = player else { return }
        
        if isPlaying {
            player.pause()
            playPauseButton.setTitle("Play", for: .normal)
        } else {
            player.play()
            playPauseButton.setTitle("Pause", for: .normal)
        }
        isPlaying.toggle()
    }
    
    @objc private func stopButtonPressed() {
        guard let player = player else { return }
        player.pause()
        player.seek(to: CMTime.zero)
        playPauseButton.setTitle("Play", for: .normal)
        isPlaying = false
    }
    
    @objc private func nextButtonPressed() {
        guard !trackURLs.isEmpty else { return } 

        currentTrackIndex = (currentTrackIndex + 1) % trackURLs.count
        loadTrack(index: currentTrackIndex)
        if isPlaying {
            player?.play()
        }
    }
}
