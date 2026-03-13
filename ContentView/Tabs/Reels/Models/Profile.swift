//
//  Profile.swift
//  InstagramReels
//
//  Created by Coder ACJHP on 13.03.2026.
//

import Foundation

struct Profile: Identifiable {
    let id: UUID
    let username: String
    let displayName: String
    let email: String
    let profileImage: URL?
    var isFollowing: Bool

    init(
        id: UUID = UUID(),
        username: String,
        displayName: String,
        email: String,
        profileImage: URL?,
        isFollowing: Bool = false
    ) {
        self.id = id
        self.username = username
        self.displayName = displayName
        self.email = email
        self.profileImage = profileImage
        self.isFollowing = isFollowing
    }
}

struct Audio: Identifiable {
    let id: UUID
    let title: String
    let artistName: String
    let coverImage: String

    init(
        id: UUID = UUID(),
        title: String,
        artistName: String,
        coverImage: String
    ) {
        self.id = id
        self.title = title
        self.artistName = artistName
        self.coverImage = coverImage
    }
}

struct Comment: Identifiable {
    let id: UUID
    var owner: Profile
    let text: String
    let createdAt: Date
    var isLiked: Bool
    var likeCount: Int
    
    init (
        id: UUID = UUID(),
        owner: Profile,
        text: String,
        createdAt: Date = .now,
        isLiked: Bool = false,
        likeCount: Int = 0
    ) {
        self.id = id
        self.owner = owner
        self.text = text
        self.createdAt = createdAt
        self.isLiked = isLiked
        self.likeCount = likeCount
    }
}

struct Reel: Identifiable {
    let id: UUID
    var owner: Profile
    let thumbnailImage: URL?
    let videoURL: URL?
    let caption: String
    let tag: String
    var comments: [Comment]
    let audio: Audio?
    let createdAt: Date
    var likeCount: Int
    var commentCount: Int
    var repostCount: Int
    var shareCount: Int
    var isLiked: Bool
    var isReposted: Bool
    var isBookmarked: Bool

    init(
        id: UUID = UUID(),
        owner: Profile,
        thumbnailImage: URL?,
        videoURL: URL?,
        caption: String,
        tag: String = "",
        comments: [Comment] = [],
        audio: Audio? = nil,
        createdAt: Date = .now,
        likeCount: Int = 0,
        commentCount: Int = 0,
        repostCount: Int = 0,
        shareCount: Int = 0,
        isLiked: Bool = false,
        isReposted: Bool = false,
        isBookmarked: Bool = false
    ) {
        self.id = id
        self.owner = owner
        self.thumbnailImage = thumbnailImage
        self.videoURL = videoURL
        self.caption = caption
        self.tag = tag
        self.comments = comments
        self.audio = audio
        self.createdAt = createdAt
        self.likeCount = likeCount
        self.commentCount = commentCount
        self.repostCount = repostCount
        self.shareCount = shareCount
        self.isLiked = isLiked
        self.isReposted = isReposted
        self.isBookmarked = isBookmarked
    }
}
