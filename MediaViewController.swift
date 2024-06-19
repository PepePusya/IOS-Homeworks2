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
        "Track 1",
        "Track 2",
        "Track 3",
        "Track 4",
        "Track 5"
    ]

    private let trackURLs: [URL] = {
        var urls = [URL]()
        for i in 1...5 {
            if let url = Bundle.main.url(forResource: "Track \(i)", withExtension: "mp3") {
                urls.append(url)
            } else {
                print("Track \(i) not found")
            }
        }
        return urls
    }()

    private lazy var trackLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()

    private lazy var playPauseButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Play", for: .normal)
        button.addTarget(self, action: #selector(playPauseButtonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var stopButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Stop", for: .normal)
        button.addTarget(self, action: #selector(stopButtonPressed), for: .touchUpInside)
        return button
    }()

    private lazy var nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Next", for: .normal)
        button.addTarget(self, action: #selector(nextButtonPressed), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        loadTrack(index: 0)
    }

    private func setupUI() {
        view.addSubview(trackLabel)
        view.addSubview(playPauseButton)
        view.addSubview(stopButton)
        view.addSubview(nextButton)
        
        trackLabel.translatesAutoresizingMaskIntoConstraints = false
        playPauseButton.translatesAutoresizingMaskIntoConstraints = false
        stopButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            trackLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            trackLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            
            playPauseButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            playPauseButton.topAnchor.constraint(equalTo: trackLabel.bottomAnchor, constant: 20),
            
            stopButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stopButton.topAnchor.constraint(equalTo: playPauseButton.bottomAnchor, constant: 20),
            
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

    @objc private func playPauseButtonTapped() {
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
        currentTrackIndex = (currentTrackIndex + 1) % trackURLs.count
        loadTrack(index: currentTrackIndex)
        if isPlaying {
            player?.play()
        }
    }
}
