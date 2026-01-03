//
//  Login.swift
//  RandomUsers
//
//  Created by Adam Cseke on 2025. 12. 28..
//

import Foundation

// MARK: - Login
struct Login: Decodable {
    let uuid, username, password, salt: String
    let md5, sha1, sha256: String
}
