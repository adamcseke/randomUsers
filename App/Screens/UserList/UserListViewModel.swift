//
//  UserListViewModel.swift
//  RandomUsers
//
//  Created by Adam Cseke on 2025. 12. 29..
//

import DataKit
import Factory
import Foundation
import SystemKit

@Observable
final class UserListViewModel {

    @ObservationIgnored
    @Injected(\.networkManager) private var networkManager

    @ObservationIgnored
    @Injected(\.networkMonitor) private var networkMonitor

    var users: [User] = []
    private var page: Int = 1
    private let results: Int = 20

    var isLoading = false
    var isPgainationLoading = false

    var isOffline: Bool {
        !networkMonitor.isConnected
    }

    func fetchUsers () {
        guard !isLoading else { return }
        guard !isOffline else { return }

        print("start fetching")

        isLoading = true

        Task { @MainActor in
            defer {
                isLoading = false
                isPgainationLoading = false
            }
            
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
        guard !isOffline else { return }
        guard !isPgainationLoading else { return }

        let thresholdIndex = users.index(users.endIndex, offsetBy: -5)
        if users.firstIndex(where: { $0.id == listItem.id }) == thresholdIndex {
            isPgainationLoading = true
            fetchUsers()
        }
    }
}
