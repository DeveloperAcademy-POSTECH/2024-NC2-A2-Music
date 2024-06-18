//
//  Authorization.swift
//  OnAir
//
//  Created by 김유빈 on 6/18/24.
//

import MusicKit
import SwiftUI

// MARK: - 애플뮤직 사용 권한 받기

final class Authorization: ObservableObject {
    @State var musicAuthorizationStatus: MusicAuthorization.Status = .notDetermined
    
    func readMusicAuthorizationStatus() -> MusicAuthorization.Status {
        self.fetchMusicAuthorizationStatus()
        
        return musicAuthorizationStatus
    }
    
    private func fetchMusicAuthorizationStatus() {
        switch musicAuthorizationStatus {
        case .notDetermined:
            Task {
                let musicAuthorizationStatus = await MusicAuthorization.request()
                await update(with: musicAuthorizationStatus)
            }
        default:
            fatalError("No button should be displayed for current authorization status: \(musicAuthorizationStatus).")
        }
    }
    
    /// Safely updates the `musicAuthorizationStatus` property on the main thread.
    @MainActor
    private func update(with musicAuthorizationStatus: MusicAuthorization.Status) {
        withAnimation {
            self.musicAuthorizationStatus = musicAuthorizationStatus
        }
    }    
}
