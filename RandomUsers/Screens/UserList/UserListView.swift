//
//  ContentView.swift
//  RandomUsers
//
//  Created by Adam Cseke on 2025. 12. 26..
//

import SwiftUI
import SwiftData
import SDWebImageSwiftUI

struct UserListView: View {
    @State private var viewModel = UserListViewModel()
    @State private var showSavedUsersOnly: Bool = false

    @Environment(\.modelContext) var modelContext
    @Query(sort: \Prospect.id) var prospects: [Prospect]

    var body: some View {
        List {
            ForEach(showSavedUsersOnly ? prospects.map { $0.toUser } : viewModel.users) { user in
                HStack {
                    NavigationLink {
                        UserDetailView(user: user)
                    } label: {
                        WebImage(url: URL(string: user.pictureMediumURL)) { image in
                               image.resizable()
                           } placeholder: {
                               ProgressView()
                                   .tint(Color.black)
                                   .progressViewStyle(.circular)
                           }
                           .transition(.fade(duration: 0.5))
                           .scaledToFit()
                           .frame(width: 44, height: 44, alignment: .center)
                        Text(user.fullName)
                    }
                    .listStyle(.plain)

                    Button("", systemImage: prospects.contains(where: { $0.id == user.id }) ? "heart.fill" : "heart") {
                        if let existingProspect = prospects.first(where: { $0.id == user.id }) {
                            modelContext.delete(existingProspect)
                        } else {
                            let prospect = Prospect(from: user)
                            modelContext.insert(prospect)
                        }
                    }
                    .buttonStyle(.plain)
                }
                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                    Button(role: .destructive) {
                        if let existingProspect = prospects.first(where: { $0.id == user.id }) {
                            modelContext.delete(existingProspect)
                        }
                    }
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
        .refreshable {
            viewModel.fetchUsers()
        }
        .onAppear {
            viewModel.fetchUsers()
        }
        .navigationTitle(Localization.title)
        .navigationSubtitle(Text("\(prospects.count) Saved users"))
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Menu {
                    Button(action: {
                        showSavedUsersOnly.toggle()
                    }, label: {
                        Label(showSavedUsersOnly ? "Show all users" : "Show only saved users", systemImage: "filter")
                    })
                    .accessibilityIdentifier(Identifiers.moreButton)
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
    }

    private enum Identifiers {
        static let list = "user-list"
        static let moreButton = "users-list-more"
    }
}

#Preview {
    NavigationStack {
        UserListView()
    }
    .modelContainer(for: Prospect.self)
}
