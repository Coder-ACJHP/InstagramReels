//
//  ReelCommentsSheet.swift
//  SwiftUIChallange
//
//  Created by Coder ACJHP on 6.03.2026.
//

import SwiftUI

struct ReelCommentsSheet: View {
    
    let currentReel: Reel
    @ObservedObject var vm: InstaReelsViewModel
    @EnvironmentObject var appState: InstaAppState
    @State private var newCommentText: String = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                if currentReel.comments.isEmpty {
                    
                    Text("No comments yet")
                        .font(.headline)
                        .foregroundStyle(Color(.secondaryLabel))
                    
                } else {
                    ScrollView {
                        LazyVStack {
                            ForEach(currentReel.comments, id: \.id) { comment in
                                ListRowView(comment)
                            }
                        }
                    }
                    if let currentUser = appState.currentUser {
                        InputMessageView(currentUser)
                    }
                }
            }
            .navigationTitle("Comments")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    @ViewBuilder
    private func ListRowView(_ comment: Comment) -> some View {
        VStack {
            HStack {
                AsyncImage(url: comment.owner.profileImage)
                    .scaledToFill()
                    .frame(width: 50.resp, height: 50.resp)
                    .clipShape(Circle())
                    .overlay {
                        Circle()
                            .stroke(LinearGradient(gradient: Gradient(colors: [.red, .yellow]), startPoint: .top, endPoint: .bottom), lineWidth: 2.resp)
                            .foregroundStyle(Color.clear)
                    }
                
                VStack(spacing: 5.resp) {
                    Text(comment.owner.displayName)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.system(size: 13.resp, weight: .bold))
                        .foregroundStyle(Color.white)
                    Text(comment.text)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.system(size: 15.resp, weight: .medium))
                        .foregroundStyle(Color.white)
                    
                    HStack {
                        Button("Replay") {
                            
                        }
                        .foregroundStyle(Color(.secondaryLabel))
                        .font(.system(size: 14.resp, weight: .bold))
                        
                        Spacer()
                    }
                    .padding(.top, 5.resp)
                }
                
                Spacer()
                
                let isLiked = comment.isLiked
                Button {
                    vm.toggleCommentLike(reelId: currentReel.id, commentId: comment.id)
                } label: {
                    VStack {
                        Image(systemName: isLiked ? "heart.fill" : "heart")
                            .renderingMode(.template)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(10.resp)
                            .frame(width: 50.resp, height: 50.resp)
                            .foregroundStyle(isLiked ? Color(.systemPink) : .white)
                            .fontWeight(isLiked ? .bold : .regular)
                        Text("\(comment.likeCount)")
                            .foregroundStyle(Color(.white))
                            .font(Font.caption.bold())
                            .padding(.top, -5.resp)
                    }
                    
                }
            }
        }
        .padding()
    }
    
    @ViewBuilder
    private func InputMessageView(_ profile: Profile) -> some View {
        HStack(spacing: 15.resp) {
            AsyncImage(url: profile.profileImage)
                .scaledToFill()
                .frame(width: 35.resp, height: 35.resp)
                .clipShape(Circle())
                .overlay {
                    Circle()
                        .stroke(LinearGradient(gradient: Gradient(colors: [.red, .yellow]), startPoint: .top, endPoint: .bottom), lineWidth: 2.resp)
                        .foregroundStyle(Color.clear)
                }
            
            TextField(text: $newCommentText, label: {
                HStack {
                    Text("Join the converstaion...")
                        .foregroundStyle(Color.secondary)
                }
            })
            .padding(10.resp)
            .foregroundStyle(Color.secondary)
            .textInputAutocapitalization(.never)
            .clipShape(.capsule)
            .overlay(
                Capsule()
                    .stroke(Color.secondary, lineWidth: 1)
            )
            
            Button {
                guard !newCommentText.isEmpty,
                      let currentUser = appState.currentUser else { return }
                vm.addComment(to: currentReel.id, text: newCommentText, profile: currentUser)
                newCommentText = ""
            } label: {
                Image(systemName: "paperplane.fill")
                    .resizable()
                    .renderingMode(.template)
                    .scaledToFit()
                    .padding(4.resp)
                    .frame(width: 30.resp, height: 30.resp)
                    .foregroundStyle(Color.white)
            }
            .disabled(newCommentText.isEmpty)
        }
        .padding(.horizontal)
    }
}

#Preview {
    let vm = InstaReelsViewModel()
    let reel = vm.currentReel
    ReelCommentsSheet(currentReel: reel!, vm: vm)
        .environmentObject(InstaAppState())
}
