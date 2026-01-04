//
//  CachedUser.swift
//  RandomUsers
//
//  Created by Adam Cseke on 2026. 01. 02..
//

import SwiftData

@Model
class CachedUser {
    var id: String
    var firstName: String
    var lastName: String
    var email: String
    var gender: String
    var phone: String
    var age: Int
    var nationality: String
    var birthday: String
    var pictureMediumURL: String
    var pictureLargeURL: String
    var city: String
    var state: String
    var country: String
    var postcode: String
    var streetName: String
    var streetNumber: Int
    var cell: String
    var isFavorite: Bool

    init(id: String, firstName: String, lastName: String, email: String, gender: String, phone: String, age: Int, nationality: String, birthday: String, pictureMediumURL: String, pictureLargeURL: String, city: String, state: String, country: String, postcode: String, streetName: String, streetNumber: Int, cell: String, isFavorite: Bool = false) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.gender = gender
        self.phone = phone
        self.age = age
        self.nationality = nationality
        self.birthday = birthday
        self.pictureMediumURL = pictureMediumURL
        self.pictureLargeURL = pictureLargeURL
        self.city = city
        self.state = state
        self.country = country
        self.postcode = postcode
        self.streetName = streetName
        self.streetNumber = streetNumber
        self.cell = cell
        self.isFavorite = isFavorite
    }
}

