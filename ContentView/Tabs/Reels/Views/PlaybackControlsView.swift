//
//  PlaybackControlsView.swift
//  SwiftUIChallange
//
//  Created by Coder ACJHP on 8.03.2026.
//

import Foundation
import SwiftUI

// MARK: - Playback Controls (separate struct for proper @ObservedObject tracking)
struct PlaybackControlsView: View {
    
    @ObservedObject var playerVM: VideoPlayerViewModel
    var onInteraction: () -> Void
    
    var body: some View {
        VStack(spacing: 25.resp) {
            Button {
                playerVM.toggleMute()
                onInteraction()
            } label: {
                Image(systemName: playerVM.isMuted ? "speaker.slash.fill" : "speaker.wave.2.fill")
                    .font(.system(size: 22.resp))
                    .foregroundStyle(.white)
                    .frame(width: 46.resp, height: 46.resp)
                    .background(.ultraThinMaterial)
                    .clipShape(Circle())
            }
            
            Button {
                playerVM.togglePlayPause()
                onInteraction()
            } label: {
                Image(systemName: playerVM.isPlaying ? "pause.fill" : "play.fill")
                    .font(.system(size: 32.resp))
                    .foregroundStyle(.white)
                    .frame(width: 70.resp, height: 70.resp)
                    .background(.ultraThinMaterial)
                    .clipShape(Circle())
            }
        }
        .transition(.opacity)
    }
}
