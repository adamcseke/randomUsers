//
//  Location.swift
//  RandomUsers
//
//  Created by Adam Cseke on 2025. 12. 28..
//

import Foundation

// MARK: - Location
struct Location: Decodable {
    let street: Street
    let city, state, country, postcode: String
    let coordinates: Coordinates
    let timezone: Timezone
    
    enum CodingKeys: String, CodingKey {
        case street, city, state, country, postcode, coordinates, timezone
    }
    
    init(from decoder: Decoder) throws {
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
