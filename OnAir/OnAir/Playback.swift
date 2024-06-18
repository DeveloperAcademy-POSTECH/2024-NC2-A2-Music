//
//  Playback.swift
//  OnAir
//
//  Created by 김유빈 on 6/18/24.
//

import MusicKit
import SwiftUI

struct Playback: View {
    @ObservedObject private var playerState = SystemMusicPlayer.shared.state
    
    @State private var animateGradient = false
    
    private let player = SystemMusicPlayer.shared
        
    /// `true` when the player is playing.
    var isPlaying: Bool {
        return (playerState.playbackStatus == .playing)
    }
    
    private var backGradient: LinearGradient {
        LinearGradient(colors: [.backRed, .backYellow, .backPurple], startPoint: .topLeading, endPoint: .bottomTrailing)
    }
    
    var body: some View {
        ZStack {
            if isPlaying {
                backGradient
                    .edgesIgnoringSafeArea(.all)
                    .hueRotation(.degrees(animateGradient ? 45 : 0))
                    .onAppear {
                        withAnimation(.easeInOut(duration: 1).repeatForever(autoreverses: true)) {
                            animateGradient.toggle()
                        }
                    }
                
            } else {
                backGradient
                    .edgesIgnoringSafeArea(.all)
                    .hueRotation(.degrees(animateGradient ? 45 : 0))
            }
            
            VStack(spacing: 0) {
                Button {
                    handlePlayButtonSelected()
                } label: {
                    Image("radio")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 260)
                        .padding(.top, 80)
                }
            }
        }
    }
    // MARK: - 라디오 재생 (System Music Player 사용)
    
    /// The action to perform when the user taps the Play/Pause button.
    private func handlePlayButtonSelected() {
        if !isPlaying {
            Task {
                do {
                    try await player.play()
                } catch {
                    print("Failed to resume playing with error: \(error).")
                }
            }
        } else {
            player.pause()
        }
    }
}

#Preview {
    Playback()
}
