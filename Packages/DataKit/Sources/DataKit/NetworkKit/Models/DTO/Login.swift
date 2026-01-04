//
//  Login.swift
//  DataKit
//
//  Created by Adam Cseke on 2025. 12. 28..
//

import Foundation

// MARK: - Login
public struct Login: Decodable {
    public let uuid, username, password, salt: String
    public let md5, sha1, sha256: String
}
