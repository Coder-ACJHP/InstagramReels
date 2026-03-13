//
//  VideoPlayerView.swift
//  SwiftUIChallange
//
//  Created by Coder ACJHP on 5.03.2026.
//

import SwiftUI
import AVKit

// MARK: - Raw AVPlayerLayer wrapper (no built-in controls)
struct AVPlayerLayerView: UIViewRepresentable {
    let player: AVPlayer
    
    func makeUIView(context: Context) -> PlayerContainerView {
        PlayerContainerView(player: player)
    }
    
    func updateUIView(_ uiView: PlayerContainerView, context: Context) {
        uiView.playerLayer.player = player
    }
}

final class PlayerContainerView: UIView {
    let playerLayer: AVPlayerLayer
    
    init(player: AVPlayer) {
        playerLayer = AVPlayerLayer(player: player)
        super.init(frame: .zero)
        playerLayer.videoGravity = .resizeAspect
        layer.addSublayer(playerLayer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = bounds
    }
}

// MARK: - VideoPlayerView
struct VideoPlayerView: View {
    
    let reel: Reel?
    @ObservedObject var vm: VideoPlayerViewModel
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea(edges: .all)
            
            if let player = vm.player {
                AVPlayerLayerView(player: player)
                    .onAppear { vm.play() }
                
                if vm.isLoading {
                    ProgressView()
                        .tint(.white)
                }
                
            } else if let thumbURL = reel?.thumbnailImage {
                AsyncImage(url: thumbURL) { image in
                    image.resizable().aspectRatio(contentMode: .fill)
                } placeholder: {
                    ProgressView()
                }
                
            } else {
                VStack {
                    Image(systemName: "play.slash")
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                        .foregroundStyle(Color(.white))
                    
                    Text("No video available")
                        .font(Font.title3.bold())
                        .foregroundStyle(Color(.white))
                        .padding()
                }
            }
        }
        .onAppear {
            if let videoURL = reel?.videoURL {
                vm.preparePlayer(withURL: videoURL)
            }
        }
        .onDisappear {
            vm.cleanUp()
        }
    }
}

#Preview {
    let viewModel = InstaReelsViewModel()
    let playerVM = VideoPlayerViewModel()
    VideoPlayerView(reel: viewModel.currentReel, vm: playerVM)
}
