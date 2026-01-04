import DataKit

extension CachedUser {
    convenience init(from user: DataKit.User, isFavorite: Bool = false) {
        self.init(
            id: user.id,
            firstName: user.firstName,
            lastName: user.lastName,
            email: user.email,
            gender: user.gender,
            phone: user.phone,
            age: user.age,
            nationality: user.nationality,
            birthday: user.birthday,
            pictureMediumURL: user.pictureMediumURL,
            pictureLargeURL: user.pictureLargeURL,
            city: user.city,
            state: user.state,
            country: user.country,
            postcode: user.postcode,
            streetName: user.streetName,
            streetNumber: user.streetNumber,
            cell: user.cell,
            isFavorite: isFavorite
        )
    }

    var toUser: DataKit.User {
        DataKit.User(
            id: id,
            firstName: firstName,
            lastName: lastName,
            email: email,
            gender: gender,
            phone: phone,
            age: age,
            nationality: nationality,
            birthday: birthday,
            pictureMediumURL: pictureMediumURL,
            pictureLargeURL: pictureLargeURL,
            city: city,
            state: state,
            country: country,
            postcode: postcode,
            streetName: streetName,
            streetNumber: streetNumber,
            cell: cell
        )
    }
}

