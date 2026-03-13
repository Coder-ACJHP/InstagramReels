//
//  InstaReelsViewModel.swift
//  SwiftUIChallange
//
//  Created by Coder ACJHP on 6.03.2026.
//

import Foundation
import SwiftUI
import Combine

@MainActor
class InstaReelsViewModel: ObservableObject {
    
    @Published var reels: [Reel] = []
    @Published var isLoading: Bool = false
    @Published var currentReel: Reel? = nil
    let screenSize = UIScreen.main.bounds.size
    
    private var playerViewModels: [UUID: VideoPlayerViewModel] = [:]
    
    var currentPlayerVM: VideoPlayerViewModel? {
        guard let id = currentReel?.id else { return nil }
        return playerViewModels[id]
    }
    
    func getOrCreatePlayerVM(for reel: Reel) -> VideoPlayerViewModel {
        if let existing = playerViewModels[reel.id] { return existing }
        let vm = VideoPlayerViewModel()
        playerViewModels[reel.id] = vm
        return vm
    }
    
    init () {
        let initialReels: [Reel] = [
            Reel(
                owner: Profile(
                    username: "coder_acjhp",
                    displayName: "Coder ACJHP",
                    email: "hexa.octabin@gmail.com",
                    profileImage: URL(string: "https://picsum.photos/id/1/200/200")
                ),
                thumbnailImage: URL(string: "https://picsum.photos/id/10/1080/1920"),
                videoURL: URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"),
                caption: "iPhone pil gücünü 3'e katla 🔋⚡️",
                tag: "tips",
                comments: [
                    Comment(
                        owner: Profile(
                            username: "coder_acjhp",
                            displayName: "danila_qard1",
                            email: "hexa.octabin@gmail.com",
                            profileImage: URL(string: "https://picsum.photos/id/4/200/200")
                        ),
                        text: "iPod plus Nokia combined together.",
                        createdAt: Date(),
                        likeCount: Int.random(in: 0...1000)
                    ),
                    Comment(
                        owner: Profile(
                            username: "coder_acjhp",
                            displayName: "danila_qard1",
                            email: "hexa.octabin@gmail.com",
                            profileImage: URL(string: "https://picsum.photos/id/5/200/200")
                        ),
                        text: "when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries",
                        createdAt: Date(),
                        likeCount: Int.random(in: 0...1000)
                    ),
                    Comment(
                        owner: Profile(
                            username: "coder_acjhp",
                            displayName: "prajwal_20",
                            email: "hexa.octabin@gmail.com",
                            profileImage: URL(string: "https://picsum.photos/id/6/200/200")
                        ),
                        text: "Brand name and whats the price?",
                        createdAt: Date(),
                        likeCount: Int.random(in: 0...1000)
                    )
                ],
                audio: Audio(title: "Original Audio", artistName: "coder_acjhp", coverImage: ""),
                likeCount: Int.random(in: 100...50000),
                commentCount: Int.random(in: 10...5000),
                repostCount: Int.random(in: 5...3000),
                shareCount: Int.random(in: 10...8000)
            ),
            Reel(
                owner: Profile(
                    username: "travel_diary",
                    displayName: "Travel Diary",
                    email: "travel@example.com",
                    profileImage: URL(string: "https://picsum.photos/id/2/200/200")
                ),
                thumbnailImage: URL(string: "https://picsum.photos/id/15/1080/1920"),
                videoURL: URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4"),
                caption: "Kapadokya'da gün batımı, bu manzaraya doyum olmuyor 🌅",
                tag: "cappadocia",
                audio: Audio(title: "Blinding Lights", artistName: "The Weeknd", coverImage: ""),
                likeCount: Int.random(in: 100...50000),
                commentCount: Int.random(in: 10...5000),
                repostCount: Int.random(in: 5...3000),
                shareCount: Int.random(in: 10...8000)
            ),
            Reel(
                owner: Profile(
                    username: "fitness_pro",
                    displayName: "Fitness Pro",
                    email: "fit@example.com",
                    profileImage: URL(string: "https://picsum.photos/id/3/200/200")
                ),
                thumbnailImage: URL(string: "https://picsum.photos/id/20/1080/1920"),
                videoURL: URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4"),
                caption: "30 günde karın kası challenge, hazır mısınız? 💪🔥",
                tag: "fitness",
                audio: Audio(title: "Eye of the Tiger", artistName: "Survivor", coverImage: ""),
                likeCount: Int.random(in: 100...50000),
                commentCount: Int.random(in: 10...5000),
                repostCount: Int.random(in: 5...3000),
                shareCount: Int.random(in: 10...8000)
            ),
            Reel(
                owner: Profile(
                    username: "chef_kitchen",
                    displayName: "Chef's Kitchen",
                    email: "chef@example.com",
                    profileImage: URL(string: "https://picsum.photos/id/4/200/200")
                ),
                thumbnailImage: URL(string: "https://picsum.photos/id/25/1080/1920"),
                videoURL: URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4"),
                caption: "5 dakikada İtalyan makarna tarifi 🍝👨‍🍳",
                tag: "food",
                audio: Audio(title: "That's Amore", artistName: "Dean Martin", coverImage: ""),
                likeCount: Int.random(in: 100...50000),
                commentCount: Int.random(in: 10...5000),
                repostCount: Int.random(in: 5...3000),
                shareCount: Int.random(in: 10...8000)
            ),
            Reel(
                owner: Profile(
                    username: "code_with_me",
                    displayName: "Code With Me",
                    email: "code@example.com",
                    profileImage: URL(string: "https://picsum.photos/id/5/200/200")
                ),
                thumbnailImage: URL(string: "https://picsum.photos/id/30/1080/1920"),
                videoURL: URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4"),
                caption: "SwiftUI ile Instagram klonu yapıyoruz 🚀📱",
                tag: "coding",
                audio: Audio(title: "Lose Yourself", artistName: "Eminem", coverImage: ""),
                likeCount: Int.random(in: 100...50000),
                commentCount: Int.random(in: 10...5000),
                repostCount: Int.random(in: 5...3000),
                shareCount: Int.random(in: 10...8000)
            ),
            Reel(
                owner: Profile(
                    username: "nature_vibes",
                    displayName: "Nature Vibes",
                    email: "nature@example.com",
                    profileImage: URL(string: "https://picsum.photos/id/6/200/200")
                ),
                thumbnailImage: URL(string: "https://picsum.photos/id/35/1080/1920"),
                videoURL: URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4"),
                caption: "Doğanın sesi, huzurun adresi 🌿🏔️",
                tag: "nature",
                audio: Audio(title: "River Flows in You", artistName: "Yiruma", coverImage: ""),
                likeCount: Int.random(in: 100...50000),
                commentCount: Int.random(in: 10...5000),
                repostCount: Int.random(in: 5...3000),
                shareCount: Int.random(in: 10...8000)
            ),
            Reel(
                owner: Profile(
                    username: "car_world",
                    displayName: "Car World",
                    email: "cars@example.com",
                    profileImage: URL(string: "https://picsum.photos/id/7/200/200")
                ),
                thumbnailImage: URL(string: "https://picsum.photos/id/40/1080/1920"),
                videoURL: URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerMeltdowns.mp4"),
                caption: "Bu sesin yanından geçilmez 🏎️💨",
                tag: "supercar",
                audio: Audio(title: "Gas Gas Gas", artistName: "Manuel", coverImage: ""),
                likeCount: Int.random(in: 100...50000),
                commentCount: Int.random(in: 10...5000),
                repostCount: Int.random(in: 5...3000),
                shareCount: Int.random(in: 10...8000)
            ),
            Reel(
                owner: Profile(
                    username: "music_daily",
                    displayName: "Music Daily",
                    email: "music@example.com",
                    profileImage: URL(string: "https://picsum.photos/id/8/200/200")
                ),
                thumbnailImage: URL(string: "https://picsum.photos/id/45/1080/1920"),
                videoURL: URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/Sintel.mp4"),
                caption: "Bu şarkıyı duymayan kalmamıştır 🎵🎶",
                tag: "trending",
                audio: Audio(title: "Flowers", artistName: "Miley Cyrus", coverImage: ""),
                likeCount: Int.random(in: 100...50000),
                commentCount: Int.random(in: 10...5000),
                repostCount: Int.random(in: 5...3000),
                shareCount: Int.random(in: 10...8000)
            ),
            Reel(
                owner: Profile(
                    username: "pet_lovers",
                    displayName: "Pet Lovers",
                    email: "pets@example.com",
                    profileImage: URL(string: "https://picsum.photos/id/9/200/200")
                ),
                thumbnailImage: URL(string: "https://picsum.photos/id/50/1080/1920"),
                videoURL: URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/SubaruOutbackOnStreetAndDirt.mp4"),
                caption: "Bu tatlılığa dayanamayacaksınız 🐶❤️",
                tag: "cute",
                audio: Audio(title: "Happy", artistName: "Pharrell Williams", coverImage: ""),
                likeCount: Int.random(in: 100...50000),
                commentCount: Int.random(in: 10...5000),
                repostCount: Int.random(in: 5...3000),
                shareCount: Int.random(in: 10...8000)
            ),
            Reel(
                owner: Profile(
                    username: "design_hub",
                    displayName: "Design Hub",
                    email: "design@example.com",
                    profileImage: URL(string: "https://picsum.photos/id/11/200/200")
                ),
                thumbnailImage: URL(string: "https://picsum.photos/id/55/1080/1920"),
                videoURL: URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/TearsOfSteel.mp4"),
                caption: "Minimalist tasarım ipuçları ✏️🎨",
                tag: "design",
                audio: Audio(title: "Cradles", artistName: "Sub Urban", coverImage: ""),
                likeCount: Int.random(in: 100...50000),
                commentCount: Int.random(in: 10...5000),
                repostCount: Int.random(in: 5...3000),
                shareCount: Int.random(in: 10...8000)
            )
        ]
        
        _reels = Published(wrappedValue: initialReels)
        _currentReel = Published(wrappedValue: initialReels.first!)
    }
    
    func updateCurrentReel(byId id: UUID?) {
        guard let id, let reel = reels.first(where: { $0.id == id }) else { return }
        currentReel = reel
    }
    
    func addComment(to reelId: UUID, text: String, profile: Profile) {
        if let index = reels.firstIndex(where: { $0.id == reelId }) {
            let newComment = Comment(owner: profile, text: text, isLiked: false)
            reels[index].comments.append(newComment)
            updateCurrentReel(byId: reelId)
        }
    }
    
    func toggleReelLike(reelId: UUID) {
        if let reelIndex = reels.firstIndex(where: { $0.id == reelId }) {
            reels[reelIndex].isLiked.toggle()
            updateCurrentReel(byId: reelId)
        }
    }
    
    func toggleCommentLike(reelId: UUID, commentId: UUID) {
        if let reelIndex = reels.firstIndex(where: { $0.id == reelId }),
           let commentIndex = reels[reelIndex].comments.firstIndex(where: { $0.id == commentId }) {
            reels[reelIndex].comments[commentIndex].isLiked.toggle()
            updateCurrentReel(byId: reelId)
        }
    }
}
