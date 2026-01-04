//
//  APIUser.swift
//  DataKit
//
//  Created by Adam Cseke on 2025. 12. 28..
//

import Foundation

// MARK: - UserDTO
public struct UserDTO: Decodable {
    public let gender: String
    public let name: Name
    public let location: Location
    public let email: String
    public let login: Login
    public let dob, registered: Dob
    public let phone, cell: String
    public let id: ID
    public let picture: Picture
    public let nat: String
}

