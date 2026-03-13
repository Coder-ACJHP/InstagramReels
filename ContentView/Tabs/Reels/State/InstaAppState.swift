//
//  InstaAppState.swift
//  SwiftUIChallange
//
//  Created by Coder ACJHP on 7.03.2026.
//

import Foundation
import Combine

class InstaAppState: ObservableObject {
    @Published var currentUser: Profile?
    @Published var isLoggedIn: Bool = false
    
    init() {
        self.currentUser = Profile(
            username: "coder_acjhp",
            displayName: "Coder ACJHP",
            email: "hexa.octabin@gmail.com",
            profileImage: URL(string: "https://picsum.photos/id/1/200/200")
        )
        self.isLoggedIn = true
    }
    
    func updateProfile(newProfile: Profile) {
        self.currentUser = newProfile
        self.isLoggedIn = true
    }
    
    func logout() {
        self.currentUser = nil
        self.isLoggedIn = false
    }
}
