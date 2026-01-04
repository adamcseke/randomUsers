//
//  UserRow.swift
//  RandomUsers
//
//  Created by Adam Cseke on 2026. 01. 03..
//

import DataKit
import SwiftData
import SDWebImageSwiftUI
import SwiftUI

struct UserRow: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: \CachedUser.id) var cachedUsers: [CachedUser]

    @State var user: User
    @State private var favoriteState: Bool = false

    private var isFavorite: Bool {
        cachedUsers.first(where: { $0.id == user.id })?.isFavorite ?? false
    }

    private var heartIcon: String {
        isFavorite ? "heart.fill" : "heart"
    }

    var body: some View {
        HStack {
            NavigationLink {
                UserDetailView(user: user)
            } label: {
                WebImage(url: URL(string: user.pictureMediumURL)) { image in
                    image.resizable()
                } placeholder: {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                }
                .clipShape(.circle)
                .transition(.fade(duration: 0.5))
                .scaledToFit()
                .frame(width: 44, height: 44, alignment: .center)
                Text(user.fullName)
            }
            .navigationLinkIndicatorVisibility(.hidden)
            .padding(.leading, 12)

            Spacer()

            Button {
                let wasFavorite = isFavorite

                if let cachedUser = cachedUsers.first(where: { $0.id == user.id }) {
                    cachedUser.isFavorite.toggle()
                } else {
                    let newUser = CachedUser(from: user, isFavorite: true)
                    modelContext.insert(newUser)
                }

                favoriteState = !wasFavorite
            } label: {
                Image(systemName: heartIcon)
                    .resizable()
                    .foregroundStyle(Color.primaryOrange)
                    .frame(width: 24, height: 24)
            }
            .padding(.trailing, 24)
            .buttonStyle(.plain)
            .sensoryFeedback(.selection, trigger: favoriteState)
        }
        .onAppear {
            favoriteState = isFavorite
        }
        .onChange(of: isFavorite) { oldValue, newValue in
            favoriteState = newValue
        }
    }
}

#Preview {
    UserRow(user: User.mockUser)
        .modelContainer(for: CachedUser.self)
}

#Preview {
    NavigationStack {
        UserListView()
    }
    .modelContainer(for: CachedUser.self)
}
