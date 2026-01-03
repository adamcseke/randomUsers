//
//  UserDetailView.swift
//  RandomUsers
//
//  Created by Adam Cseke on 2026. 01. 02..
//

import DataKit
import SDWebImageSwiftUI
import SwiftUI

struct UserDetailView: View {
    var user: User

    var body: some View {
        ScrollView {
            WebImage(url: URL(string: user.pictureMediumURL)) { image in
                   image.resizable()
               } placeholder: {
                   ProgressView()
                       .tint(Color.black)
                       .progressViewStyle(.circular)
               }
               .transition(.fade(duration: 0.5))
               .scaledToFit()
               .frame(width: 44, height: 44, alignment: .center)
            VStack {
                Divider()
                Text(Localization.contact)
                    .font(.headline)

                Text(user.email)
                Text(user.cell)
            }

            VStack {
                Divider()
                Text(Localization.details)
                    .font(.headline)

                Text(String(user.age))
                Text(user.formattedBirthday)
                Text(user.fullAddress)
            }
            .padding(.horizontal)
        }
        .navigationTitle(user.fullName)
        .navigationBarTitleDisplayMode(.inline)
    }
}

extension UserDetailView {
    private enum Localization {
        static let contact = String(localized: "userDetail.contact")
        static let details = String(localized: "userDetail.details")
    }
}

#Preview {
    NavigationStack {
        UserDetailView(user: User.mockUser)
    }
}
