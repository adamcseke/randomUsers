//
//  ContentView.swift
//  RandomUsers
//
//  Created by Adam Cseke on 2025. 12. 26..
//

import DataKit
import SwiftUI
import SwiftData
import SDWebImageSwiftUI
import SystemNotification

struct UserListView: View {
    @EnvironmentObject private var notification: SystemNotificationContext

    @Environment(\.modelContext) var modelContext
    @Query(sort: \CachedUser.id) var cachedUsers: [CachedUser]
    @Query(filter: #Predicate<CachedUser> { $0.isFavorite == true }, sort: \CachedUser.id) var favoriteUsers: [CachedUser]

    @State private var viewModel = UserListViewModel()
    @State private var showOnlyFavoriteUsers: Bool = false

    private var displayedUsers: [User] {
        if showOnlyFavoriteUsers {
            favoriteUsers.map { $0.toUser }
        } else {
            if viewModel.isOffline {
                cachedUsers.map { $0.toUser }
            } else {
                viewModel.users
            }
        }
    }
    
    private var savedUsersSubtitleText: Text {
        let formatString = String(localized: "userList.savedUsersSubtitle")
        let formattedString = String.localizedStringWithFormat(formatString, favoriteUsers.count)
        return Text(formattedString)
    }

    private var usersStateSwitchNotificationContent: some View {
        SystemNotificationMessage(
            text: showOnlyFavoriteUsers ? "userList.notification.allUsers.title" : "userList.notification.favoriteUsers.title"
        )
        .systemNotificationMessageStyle(.success)
    }
    
    private var offlineNotificationContent: some View {
        SystemNotificationMessage(
            title: "userList.notification.offlineMode.title",
            text: "userList.notification.offlineMode.message"
        )
        .systemNotificationMessageStyle(.warning)
    }
    
    private var onlineNotificationContent: some View {
        SystemNotificationMessage(
            title: "userList.notification.onlineMode.title",
            text: "userList.notification.onlineMode.message"
        )
        .systemNotificationMessageStyle(.success)
    }

    var body: some View {
        List {
            ForEach(displayedUsers) { user in
                UserRow(user: user)
                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                        Button(role: .destructive) {
                            if let cachedUser = cachedUsers.first(where: { $0.id == user.id }) {
                                cachedUser.isFavorite = false
                            }
                        }
                    }
                    .swipeActions(edge: .leading, allowsFullSwipe: true) {
                        Button(role: .confirm) {
                            if let cachedUser = cachedUsers.first(where: { $0.id == user.id }) {
                                cachedUser.isFavorite = true
                            } else {
                                let newUser = CachedUser(from: user, isFavorite: true)
                                modelContext.insert(newUser)
                            }
                        } label: {
                            Text(Localization.addToFavorites)
                        }
                        .tint(Color.green)
                    }
                    .onAppear {
                        if !viewModel.isOffline {
                            viewModel.loadNextIfNeeded(listItem: user)
                        }
                    }
            }
            if viewModel.isLoading {
                ProgressView()
                    .listRowBackground(Color.clear)
                    .tint(Color.black)
                    .progressViewStyle(.circular)
            }
        }
        .accessibilityIdentifier(Identifiers.listIdentifier)
        .refreshable {
            if !viewModel.isOffline {
                viewModel.fetchUsers()
            }
        }
        .onAppear {
            if !viewModel.isOffline {
                viewModel.fetchUsers()
            }
        }
        .onChange(of: viewModel.users) { oldValue, newValue in
            cacheUsers(newValue)
        }
        .navigationTitle(Localization.title)
        .navigationSubtitle(savedUsersSubtitleText)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Menu {
                    Button(action: {
                        showOnlyFavoriteUsers.toggle()
                    }, label: {
                        Label(showOnlyFavoriteUsers ? Localization.showAllUsers : Localization.showOnlySavedUsers, systemImage: "filter")
                    })
                    .accessibilityIdentifier(Identifiers.moreButtonIdentifier)
                } label: {
                    Image(systemName: "ellipsis.circle")
                }
            }
            ToolbarItem(placement: .topBarLeading) {
                Group {
                    if viewModel.isLoading || viewModel.isPgainationLoading {
                        ProgressView()
                            .tint(Color.primaryOrange)
                            .progressViewStyle(.circular)
                    } else {
                        EmptyView()
                    }
                }
            }
        }
        .onChange(of: showOnlyFavoriteUsers) { oldValue, newValue in
            notification.present {
                usersStateSwitchNotificationContent
            }
        }
        .onChange(of: viewModel.isOffline) { oldValue, newValue in
            if newValue {
                notification.present {
                    offlineNotificationContent
                }
            } else if oldValue {
                notification.present {
                    onlineNotificationContent
                }
            }
        }
    }
}

extension UserListView {
    private func cacheUsers(_ users: [User]) {
        for user in users {
            if cachedUsers.first(where: { $0.id == user.id }) == nil {
                let cachedUser = CachedUser(from: user, isFavorite: false)
                modelContext.insert(cachedUser)
            }
        }
    }
    
    private enum Localization {
        static let title = String(localized: "userList.title")
        static let addToFavorites = String(localized: "userList.addToFavorites")
        static let savedUsersSubtitle = String(localized: "userList.savedUsersSubtitle")
        static let showAllUsers = String(localized: "Show all users")
        static let showOnlySavedUsers = String(localized: "Show only saved users")
    }

    private enum Identifiers {
        static let listIdentifier = "user-list"
        static let moreButtonIdentifier = "users-list-more"
    }
}

#Preview {
    NavigationStack {
        UserListView()
    }
    .modelContainer(for: CachedUser.self)
}
