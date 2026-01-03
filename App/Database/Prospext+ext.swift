import DataKit

extension Prospect {
    convenience init(from user: User) {
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
            cell: user.cell
        )
    }

    var toUser: User {
        User(
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
