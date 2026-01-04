//
//  RandomUsersApp.swift
//  RandomUsers
//
//  Created by Adam Cseke on 2025. 12. 30..
//

import SwiftUI
import SwiftData
import SystemNotification

@main
struct RandomUsersApp: App {
    @StateObject private var notification = SystemNotificationContext()

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                UserListView()
            }
            .systemNotification(notification)
        }
        .modelContainer(for: Prospect.self)
    }
}
