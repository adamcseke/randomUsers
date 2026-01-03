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

struct UserListView: View {
    @State private var viewModel = UserListViewModel()
    @State private var showSavedUsersOnly: Bool = false

    @Environment(\.modelContext) var modelContext
    @Query(sort: \Prospect.id) var prospects: [Prospect]

    private var displayedUsers: [User] {
        if showSavedUsersOnly {
            return prospects.map { $0.toUser }
        } else {
            return viewModel.users
        }
    }
    
    private var savedUsersSubtitleText: Text {
        let formatString = String(localized: "userList.savedUsersSubtitle")
        let formattedString = String.localizedStringWithFormat(formatString, prospects.count)
        return Text(formattedString)
    }

    var body: some View {
        List {
            ForEach(displayedUsers) { user in
                UserRow(user: user)
                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                        Button(role: .destructive) {
                            if let existingProspect = prospects.first(where: { $0.id == user.id }) {
                                modelContext.delete(existingProspect)
                            }
                        }
                    }
                    .swipeActions(edge: .leading, allowsFullSwipe: true) {
                        Button(role: .confirm) {
                            let prospect = Prospect(from: user)
                            modelContext.insert(prospect)
                        } label: {
                            Text(Localization.addToFavorites)
                        }
                        .tint(Color.green)
                    }
                    .onAppear {
                        viewModel.loadNextIfNeeded(listItem: user)
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
            viewModel.fetchUsers()
        }
        .onAppear {
            viewModel.fetchUsers()
        }
        .navigationTitle(Localization.title)
        .navigationSubtitle(savedUsersSubtitleText)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Menu {
                    Button(action: {
                        showSavedUsersOnly.toggle()
                    }, label: {
                        Label(showSavedUsersOnly ? Localization.showAllUsers : Localization.showOnlySavedUsers, systemImage: "filter")
                    })
                    .accessibilityIdentifier(Identifiers.moreButtonIdentifier)
                } label: {
                    Image(systemName: "ellipsis.circle")
                }
            }
        }
    }
}

extension UserListView {
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
    .modelContainer(for: Prospect.self)
}
