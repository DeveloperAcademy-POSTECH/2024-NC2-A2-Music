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
    
    private let player = SystemMusicPlayer.shared
    
    let authorization = Authorization()
    
    /// `true` when the player is playing.
    var isPlaying: Bool {
        return (playerState.playbackStatus == .playing)
    }
    
    var body: some View {
        ZStack {
            Color(.yellowBackground)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                Button {
                    authorization.fetchMusicAuthorizationStatus()
                } label: {
                    Text("권한 받기")
                }
                
                Button {
                    handlePlayButtonSelected()
                } label: {
                    Image("radio")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 300)
                        .padding(.top, 50)
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
