//
//  Info.swift
//  DataKit
//
//  Created by Adam Cseke on 2025. 12. 28..
//

import Foundation

// MARK: - Info
public struct Info: Decodable {
    public let seed: String
    public let results, page: Int
    public let version: String
}
