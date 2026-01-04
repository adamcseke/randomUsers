//
//  APIResponse.swift
//  DataKit
//
//  Created by Adam Cseke on 2025. 12. 28..
//

import Foundation

// MARK: - API Response
public struct APIResponse: Decodable {
    public let results: [UserDTO]
    public let info: Info
}
