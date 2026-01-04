//
//  Container.swift
//  RandomUsers
//
//  Created by Adam Cseke on 2025. 12. 29..
//

import DataKit
import Factory
import SystemKit

extension Container {
    var networkManager: Factory<NetworkManagerProtocol> {
        self { @MainActor in
            NetworkManager()
        }.singleton
    }

    var networkMonitor: Factory<NetworkMonitorProtocol> {
        self { @MainActor in
            NetworkMonitor()
        }.singleton
    }
}
