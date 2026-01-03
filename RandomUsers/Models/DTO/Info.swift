//
//  Info.swift
//  RandomUsers
//
//  Created by Adam Cseke on 2025. 12. 28..
//

import Foundation

// MARK: - Info
struct Info: Decodable {
    let seed: String
    let results, page: Int
    let version: String
}
