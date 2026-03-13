//
//  VideoTimeSlider.swift
//  SwiftUIChallange
//
//  Created by Coder ACJHP on 8.03.2026.
//

import SwiftUI

struct VideoTimeSlider: View {
    
    @ObservedObject var playerVM: VideoPlayerViewModel
    @State private var isDragging: Bool = false
    @State private var dragValue: Double = 0
    
    private var progress: Double {
        guard playerVM.duration > 0 else { return 0 }
        let time = isDragging ? dragValue : playerVM.currentTime
        return time / playerVM.duration
    }
    
    var body: some View {
        GeometryReader { geometry in
            let trackWidth = geometry.size.width
            let thumbPosition = progress * trackWidth
            
            ZStack(alignment: .leading) {
                // Background track
                Capsule()
                    .fill(Color.white.opacity(0.3))
                    .frame(height: isDragging ? 6 : 3)
                
                // Filled track
                Capsule()
                    .fill(Color.white)
                    .frame(width: max(0, min(thumbPosition, trackWidth)), height: isDragging ? 6 : 3)
            }
            .frame(height: geometry.size.height)
            .contentShape(Rectangle())
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { value in
                        if !isDragging {
                            isDragging = true
                            playerVM.pause()
                        }
                        let ratio = max(0, min(value.location.x / trackWidth, 1))
                        dragValue = ratio * playerVM.duration
                    }
                    .onEnded { value in
                        let ratio = max(0, min(value.location.x / trackWidth, 1))
                        let seekTime = ratio * playerVM.duration
                        playerVM.seek(to: seekTime)
                        playerVM.play()
                        withAnimation(.easeOut(duration: 0.2)) {
                            isDragging = false
                        }
                    }
            )
            .animation(.easeInOut(duration: 0.15), value: isDragging)
        }
        .frame(height: 20)
    }
}
