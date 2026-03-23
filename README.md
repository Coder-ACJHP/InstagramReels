## Instagram Reels Clone

An example iOS application that replicates the Instagram Reels experience using SwiftUI.

### Why This Project Exists

- Demonstrate how to build a short-form video feed experience on iOS using a clear, learnable architecture.
- Provide a practical reference for combining SwiftUI, AVKit, and Combine in one app.
- Explore interaction-heavy UI behaviors (scroll-driven feed, playback controls, comments, like state) with maintainable code.
- Serve as a foundation for extending into production-like features such as API integration, caching, and analytics.

### Trade-off Analysis

- **SwiftUI over UIKit**: Faster iteration and cleaner declarative UI, but less granular control for some complex video interactions compared to UIKit.
- **MVVM simplicity vs strict Clean layering**: Easier onboarding and lower boilerplate, but some domain/data concerns may need further separation as the app grows.
- **In-memory mock data vs backend persistence**: Speeds up development and demos, but does not represent real network latency, offline sync, or data consistency challenges.
- **One `VideoPlayerViewModel` per reel**: Better playback/state isolation, but higher memory footprint when feed size scales.
- **Local state management (`@Published`) vs global store**: Straightforward for current scope, but coordination across many features can become harder without centralized state patterns.

### Metrics (Measurement Results)

Current project status:

- **Automated test coverage**: Not yet established (no committed XCTest/XCUITest suite in this repository snapshot).
- **Performance benchmark suite**: Not yet established (no committed Instruments trace baselines).
- **Build and run target**: App is configured for iOS simulator/device execution in Xcode 26.2.

Recommended baseline metrics to add and track:

- **Cold launch time**: Measure with Instruments (Time Profiler) on a fixed simulator/device profile.
- **Reel first-frame time**: Time from reel visibility to first rendered video frame.
- **Scroll smoothness**: FPS and dropped frame rate during rapid reel feed navigation.
- **Memory usage**: Peak and steady-state memory while browsing N reels continuously.
- **Playback reliability**: Video start success rate and rebuffer/failed-playback frequency.

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

