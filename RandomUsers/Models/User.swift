//
//  User.swift
//  RandomUsers
//
//  Created by Adam Cseke on 2025. 12. 28..
//

import Foundation

// MARK: - User
struct User: Identifiable, Hashable {
    let id: String
    let firstName: String
    let lastName: String
    let email: String
    let gender: String
    let phone: String
    let age: Int
    let nationality: String
    let birthday: String
    let pictureMediumURL, pictureLargeURL: String
    let city, state, country, postcode, streetName: String
    let streetNumber: Int
    let cell: String

    var fullAddress: String {
        "\(streetNumber) \(streetName), \(city), \(state), \(postcode), \(country)"
    }

    // TODO: - extract the formatter
    public var fullName: String {
        let formatter = PersonNameComponentsFormatter()
        var nameComponents = PersonNameComponents()
        nameComponents.givenName = firstName
        nameComponents.familyName = lastName

        return formatter.string(for: nameComponents) ?? firstName + lastName
    }

    // TODO: - extract the formatter
    public var formattedBirthday: String {
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]

        guard let date = isoFormatter.date(from: birthday) else { return "" }

        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "MMMM d, yyyy"
        outputFormatter.locale = Locale(identifier: "en_US")

        return outputFormatter.string(from: date)
    }
}

extension User {
    init(from dto: UserDTO) {
        self.id = dto.login.uuid
        self.firstName = dto.name.first
        self.lastName = dto.name.last
        self.email = dto.email
        self.pictureMediumURL = dto.picture.medium
        self.pictureLargeURL = dto.picture.large
        self.phone = dto.phone
        self.age = dto.dob.age
        self.birthday = dto.dob.date
        self.city = dto.location.city
        self.postcode = dto.location.postcode
        self.state = dto.location.state
        self.country = dto.location.country
        self.streetName = dto.location.street.name
        self.streetNumber = dto.location.street.number
        self.cell = dto.cell
        self.gender = dto.gender
        self.nationality = dto.nat
    }
}

extension User {
    static let mockUser: User = {
        var nameComponents = PersonNameComponents()
        nameComponents.givenName = "John"
        nameComponents.familyName = "Snow"

        let user = User(
            id: "1",
            firstName: "John",
            lastName: "Doe",
            email: "john.doe@test.com",
            gender: "Male",
            phone: "987654321",
            age: 32,
            nationality: "Budapest",
            birthday: "1992-03-08T15:13:16.688Z",
            pictureMediumURL: "https://randomuser.me/api/portraits/med/men/75.jpg",
            pictureLargeURL: "https://randomuser.me/api/portraits/men/75.jpg",
            city: "Budapest",
            state: "Pest",
            country: "Hungary",
            postcode: "1085",
            streetName: "Arany Janos utca",
            streetNumber: 23,
            cell: "123456789"
        )
        return user
    }()
}
