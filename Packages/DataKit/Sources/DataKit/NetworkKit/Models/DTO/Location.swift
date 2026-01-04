//
//  Location.swift
//  DataKit
//
//  Created by Adam Cseke on 2025. 12. 28..
//

import Foundation

// MARK: - Location
public struct Location: Decodable {
    public let street: Street
    public let city, state, country, postcode: String
    public let coordinates: Coordinates
    public let timezone: Timezone
    
    public enum CodingKeys: String, CodingKey {
        case street, city, state, country, postcode, coordinates, timezone
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        street = try container.decode(Street.self, forKey: .street)
        city = try container.decode(String.self, forKey: .city)
        state = try container.decode(String.self, forKey: .state)
        country = try container.decode(String.self, forKey: .country)
        coordinates = try container.decode(Coordinates.self, forKey: .coordinates)
        timezone = try container.decode(Timezone.self, forKey: .timezone)
        
        // Try Int first, then String
        if let intValue = try? container.decode(Int.self, forKey: .postcode) {
            postcode = String(intValue)
        } else {
            postcode = try container.decode(String.self, forKey: .postcode)
        }
    }
}
