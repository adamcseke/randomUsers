//
//  Container.swift
//  RandomUsers
//
//  Created by Adam Cseke on 2025. 12. 29..
//

import Factory

extension Container {
    var networkManager: Factory<NetworkManagerProtocol> {
        self { @MainActor in
            NetworkManager()
        }.singleton
    }
}
