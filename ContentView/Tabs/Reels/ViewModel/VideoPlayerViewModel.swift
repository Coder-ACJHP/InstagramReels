//
//  VideoPlayerViewModel.swift
//  SwiftUIChallange
//
//  Created by Coder ACJHP on 7.03.2026.
//

import Foundation
import Combine
import AVKit

class VideoPlayerViewModel: ObservableObject {
    
    @Published var player: AVPlayer?
    @Published var isLoading: Bool = true
    @Published var isPlaying: Bool = false
    @Published var isMuted: Bool = false
    @Published var currentTime: Double = 0
    @Published var duration: Double = 0
    @Published var error: Error?
    
    private var cancellables = Set<AnyCancellable>()
    private var timeObserver: Any?
    
    func preparePlayer(withURL videoURL: URL) {
        let asset = AVAsset(url: videoURL)
        let item = AVPlayerItem(asset: asset)
        
        item.publisher(for: \.status)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] status in
                switch status {
                case .readyToPlay:
                    self?.isLoading = false
                    if let seconds = self?.player?.currentItem?.duration.seconds,
                       seconds.isFinite {
                        self?.duration = seconds
                    }
                case .failed:
                    self?.error = item.error
                default:
                    break
                }
            }
            .store(in: &cancellables)
        
        let newPlayer = AVPlayer(playerItem: item)
        self.player = newPlayer
        addPeriodicTimeObserver()
    }
    
    func play() {
        player?.play()
        isPlaying = true
    }
    
    func pause() {
        player?.pause()
        isPlaying = false
    }
    
    func togglePlayPause() {
        if isPlaying {
            pause()
        } else {
            play()
        }
    }
    
    func toggleMute() {
        guard let player else { return }
        player.isMuted.toggle()
        isMuted = player.isMuted
    }
    
    func seek(to seconds: Double) {
        let target = CMTime(seconds: seconds, preferredTimescale: 600)
        player?.seek(to: target, toleranceBefore: .zero, toleranceAfter: .zero)
    }
    
    func cleanUp() {
        if let timeObserver {
            player?.removeTimeObserver(timeObserver)
        }
        timeObserver = nil
        player?.pause()
        player = nil
        isPlaying = false
        currentTime = 0
        duration = 0
    }
    
    private func addPeriodicTimeObserver() {
        let interval = CMTime(seconds: 0.1, preferredTimescale: 600)
        timeObserver = player?.addPeriodicTimeObserver(
            forInterval: interval,
            queue: .main
        ) { [weak self] time in
            guard let self else { return }
            self.currentTime = time.seconds
            if let seconds = self.player?.currentItem?.duration.seconds,
               seconds.isFinite, self.duration != seconds {
                self.duration = seconds
            }
        }
    }
}
