## Instagram Reels Clone

An example iOS application that replicates the Instagram Reels experience using SwiftUI.

### Features

- **Reels feed**: Vertically scrollable list of short videos.
- **Video playback**: Play/pause, mute/unmute and time slider control for each reel.
- **Likes & comments**: Manage like state for reels and comments.
- **Multi-tab navigation**: Home, Reels, Search, Profile and Share tabs.

### Technologies & Techniques Used

- **Language**: Swift
- **UI Framework**: SwiftUI  
  - `@main` app entry (`InstagramReelsApp`)  
  - Multi-tab interface (`InstaContentView`, `InstaHomeView`, Reels / Search / Profile / Share views)
- **Architecture**:  
  - MVVM style separation  
  - State management with `ObservableObject` and `@Published` (`InstaReelsViewModel`, `VideoPlayerViewModel`)
- **Reactive Programming**:  
  - Combine (`AnyCancellable`, key-path publishers for observing `AVPlayerItem` status)
- **Media Playback**:  
  - AVKit / AVFoundation (`AVPlayer`, `AVPlayerItem`, `CMTime`)  
  - Periodic time observer to track current time and total duration
- **UI Helpers**:  
  - `@MainActor` to ensure UI updates on the main thread  
  - `UIScreen.main.bounds` for layout based on screen size
- **Data Model**:  
  - Strongly typed models: `Profile`, `Reel`, `Comment`, `Audio`  
  - Mock data providing sample reels and comments

### Project Structure (Overview)

- **`App/`**: Application entry (`InstagramReelsApp.swift`)
- **`ContentView/Tabs/Reels`**:  
  - `Models/` → Reel, Profile, Comment, Audio models  
  - `State/` → `InstaAppState` (Reels-related state)  
  - `ViewModel/` → `InstaReelsViewModel`, `VideoPlayerViewModel`  
  - `Views/` → `InstaReelsView`, `VideoPlayerView`, `VideoTimeSlider`, `PlaybackControlsView`, `ReelCommentsSheet`
- **`ContentView/Tabs/*`**: SwiftUI views for Home, Search, Profile, Share tabs
- **`Extensions/`**: Utility extensions (`CGFloat+Extension.swift`)
- **`Resources/Assets.xcassets`**: Colors, app icon, and profile placeholder images

### Development Environment

- **Xcode**: 26.2
- **iOS Target**: iOS 17.0+

### How to Run

- **1.** Open `InstagramReels.xcodeproj` in Xcode.  
- **2.** Select an iOS 16+ simulator or a physical device as the run destination.  
- **3.** Press `Run` (`⌘ + R`) to build and launch the app.

