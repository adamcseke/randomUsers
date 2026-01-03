//
//  APIUser.swift
//  RandomUsers
//
//  Created by Adam Cseke on 2025. 12. 28..
//

import Foundation

// MARK: - UserDTO
struct UserDTO: Decodable {
    let gender: String
    let name: Name
    let location: Location
    let email: String
    let login: Login
    let dob, registered: Dob
    let phone, cell: String
    let id: ID
    let picture: Picture
    let nat: String
}

