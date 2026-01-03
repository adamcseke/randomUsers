//
//  APIResponse.swift
//  RandomUsers
//
//  Created by Adam Cseke on 2025. 12. 28..
//

import Foundation

// MARK: - API Response
struct APIResponse: Decodable {
    let results: [UserDTO]
    let info: Info
}

