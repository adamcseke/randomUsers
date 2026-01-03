//
//  UserListViewModel.swift
//  RandomUsers
//
//  Created by Adam Cseke on 2025. 12. 29..
//

import DataKit
import Factory
import Foundation

@Observable
final class UserListViewModel {

    @ObservationIgnored
    @Injected(\.networkManager) private var networkManager

    var users: [User] = []
    private var page: Int = 1
    private let results: Int = 20

    var isLoading = false

    func fetchUsers () {
        guard !isLoading else { return }
        isLoading = true
        defer {
            isLoading = false
        }

        Task {
            do {
                let result: APIResponse = try await networkManager.fetch(from: Endpoint.userList(page: page, results: results))
                let newUsers = result.results.map { User(from: $0) }
                users.append(contentsOf: newUsers)
                page += 1
            } catch {
                print("❌ Error: \(error.localizedDescription)")
            }
        }
    }

    func loadNextIfNeeded(listItem: User) {
        if users.last == listItem {
            fetchUsers()
        }
    }

}
