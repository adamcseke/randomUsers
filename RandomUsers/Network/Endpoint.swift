//
//  Endpoint.swift
//  RandomUsers
//
//  Created by Adam Cseke on 2025. 12. 28..
//

import Foundation

enum Endpoint {
    // MARK: - USER API
    static var baseURL: String {
#if DEV
        return "https://randomuser.me/api"
#else
        return "https://randomuser.me/api"
#endif
    }

    static func userList(page: Int = 0, results: Int = 20) throws -> URL {
        guard let url = URL(string: "\(baseURL)/?page=\(page)&results=\(results)&seed=abc") else {
            throw NetworkError.invalidURL
        }
        return url
    }
}

