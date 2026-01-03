//
//  RandomUsersApp.swift
//  RandomUsers
//
//  Created by Adam Cseke on 2025. 12. 30..
//

import SwiftUI
import SwiftData

@main
struct RandomUsersApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                UserListView()
            }
        }
        .modelContainer(for: Prospect.self)
    }
}
