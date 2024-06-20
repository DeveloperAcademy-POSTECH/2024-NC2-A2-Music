# 2024-NC2-A2-Music
## 🎥 Youtube Link
(추후 만들어진 유튜브 링크 추가)

## 💡 About Music

**MusicKit** [🔗](https://developer.apple.com/documentation/musickit/)
> Apple Music과의 통합을 지원하는 프레임워크

- **Apple Music 통합:** Apple Music의 곡, 앨범, 재생 목록 검색 및 재생
- **사용자 라이브러리 접근:** 사용자의 개인 음악 라이브러리에 있는 음악 검색 및 재생
- **큐 관리:** 큐에 재생 목록 추가 및 관리
- **플레이어 컨트롤:** 음악 재생 / 일시 정지 / 다음 곡 ・ 이전 곡 등 다양한 플레이어 컨트롤 기능 제공

**Apple Music API** [🔗](https://developer.apple.com/documentation/applemusicapi)
> Apple Music 컨텐츠를 검색하고 곡, 앨범, 아티스트 등에 대한 메타데이터를 가져올 수 있는 API
> 
- **콘텐츠 검색:** Apple Music 라이브러리에서 곡, 앨범, 아티스트 등 검색
- **메타데이터 접근:** 특정 곡, 앨범, 아티스트에 대한 메타데이터 가져오기
- **사용자 활동:** 사용자의 현재 재생 중인 음악이나 최근 들은 음악 목록 가져오기
- **사용자 플레이리스트 관리:** 사용자 플레이리스트 생성 / 수정 / 삭제

**ShazamKit** [🔗](https://developer.apple.com/documentation/ShazamKit)
> Shazam의 음악 인식 기능을 애플리케이션에 통합할 수 있는 프레임워크

- **음악 인식:** 주변에서 재생되는 음악을 인식하고 해당 곡의 정보 가져오기
- **맞춤형 카탈로그:** 개발자는 자신의 음악 카탈로그를 ShazamKit에 추가하여 해당 카탈로그 내에서 음악 인식 가능
- **오프라인 인식:** 네트워크 연결이 없는 상태에서도 음악 인식을 지원하며 연결이 복원되면 인식된 음악 정보를 가져옴
- **메타데이터 제공:** 인식된 음악에 대한 다양한 메타데이터(예: 아티스트, 앨범, 곡 제목 등) 제공
  
</br>

## 🎯 What we focus on?
**MusicKit 🎵**

---

- ~~ShazamKit~~
- ~~Apple Music API~~
- **MusicKit**에 집중
    - MusicKit에서 사용할 수 있는 기능을 나열하고 그 중에서 pick 해보자 ✔️
 
구독없이도 애플뮤직 라디오를 들을 수 있다는 사실 발견!

💬 구독없이 즐길 수 있는 애플뮤직 라디오 기능에 초점을 맞춘 프로젝트를 진행해보자 !  
💬 라디오를 재생하려면 플레이어 기능도 사용해야겠지 ?

Radio 기능과 Player 기능에 집중해보자 !

</br>

## 💼 Use Case
> 구독없이 즐길 수 있는 애플뮤직 라디오 기능을 더욱 몰입감있게 즐길 수 있도록 해주자!

</br>

## 🖼️ Prototype
<img width="600" alt="OnAirPrototype" src="https://github.com/DeveloperAcademy-POSTECH/2024-NC2-A2-Music/assets/87077859/7cf80dd7-e1a5-4f0f-9b84-234a30473b69">

<img width="600" src="https://github.com/DeveloperAcademy-POSTECH/2024-NC2-A2-Music/assets/87077859/7b3fb17d-c198-433b-8345-8f6f45809934">

</br>
</br>


## 🛠️ About Code

### 1. 미디어 및 Apple Music 접근 권한 요청
```swift
import MusicKit

@State var musicAuthorizationStatus: MusicAuthorization.Status = .notDetermined

func fetchMusicAuthorizationStatus() {
    switch musicAuthorizationStatus {
    case .notDetermined:
        Task {
            let musicAuthorizationStatus = await MusicAuthorization.request()
            await update(with: musicAuthorizationStatus)
        }
    default:
        fatalError("Error :: \(musicAuthorizationStatus).")
    }
}

@MainActor
private func update(with musicAuthorizationStatus: MusicAuthorization.Status) {
    withAnimation {
        self.musicAuthorizationStatus = musicAuthorizationStatus
    }
}
```

</br>

### 2. 애플 뮤직 미디어 재생 (SystemMusicPlayer 사용)
```swift
import MusicKit

private let player = SystemMusicPlayer.shared

private var isPlaying: Bool {
    return (playerState.playbackStatus == .playing)
}

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
```
