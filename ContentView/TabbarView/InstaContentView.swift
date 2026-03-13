//
//  InstaContentView.swift
//  SwiftUIChallange
//
//  Created by Coder ACJHP on 5.03.2026.
//

import SwiftUI

struct InstaContentView: View {
    
    enum CurrentTab: String, CaseIterable, Identifiable {
        case home
        case reels
        case share
        case search
        case profile
        
        var id: String { self.rawValue }
        var title: String { self.rawValue.capitalized }
        var iconName: String {
            switch self {
                case .home:
                    "house"
                case .reels:
                    "video"
                case .share:
                    "paperplane"
                case .search:
                    "magnifyingglass"
                case .profile:
                    "person.circle"
            }
        }
    }
    
    @State private var selectedTab: CurrentTab = .reels
    
    var body: some View {
        TabView {
            InstaHomeView()
                .tabItem {
                    Image(systemName: CurrentTab.home.iconName)
                    Text(CurrentTab.home.title)
                }
            InstaReelsView()
                .tabItem {
                    Image(systemName: CurrentTab.reels.iconName)
                    Text(CurrentTab.reels.title)
                }
            InstaShareView()
                .tabItem {
                    Image(systemName: CurrentTab.share.iconName)
                    Text(CurrentTab.share.title)
                }
            InstaSearchView()
                .tabItem {
                    Image(systemName: CurrentTab.search.iconName)
                    Text(CurrentTab.search.title)
                }
            InstaProfileView()
                .tabItem {
                    Image(systemName: CurrentTab.profile.iconName)
                    Text(CurrentTab.profile.title)
                }
        }
    }
}

#Preview {
    InstaContentView()
}
