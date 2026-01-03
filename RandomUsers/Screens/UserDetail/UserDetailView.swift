//
//  UserDetailView.swift
//  RandomUsers
//
//  Created by Adam Cseke on 2026. 01. 02..
//

import SwiftUI

struct UserDetailView: View {
    var user: User

    var body: some View {
        ScrollView {
            AsyncImage(url: URL(string: user.pictureMediumURL))
            VStack {
                Divider()
                Text("Contact")
                    .font(.headline)

                Text(user.email)
                Text(user.cell)
            }

            VStack {
                Divider()
                Text("Details")
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

#Preview {
    NavigationStack {
        UserDetailView(user: User.mockUser)
    }
}
