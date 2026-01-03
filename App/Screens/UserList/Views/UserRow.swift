//
//  UserRow.swift
//  RandomUsers
//
//  Created by Adam Cseke on 2026. 01. 03..
//

import DataKit
import SwiftData
import SDWebImageSwiftUI
import SwiftUI

struct UserRow: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: \Prospect.id) var prospects: [Prospect]

    @State var user: User
    
    private var heartIcon: String {
        prospects.contains(where: { $0.id == user.id }) ? "heart.fill" : "heart"
    }

    var body: some View {
        HStack {
            NavigationLink {
                UserDetailView(user: user)
            } label: {
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
                Text(user.fullName)
            }
            .listStyle(.plain)

            Button("", systemImage: heartIcon) {
                if let existingProspect = prospects.first(where: { $0.id == user.id }) {
                    modelContext.delete(existingProspect)
                } else {
                    let prospect = Prospect(from: user)
                    modelContext.insert(prospect)
                }
            }
            .buttonStyle(.plain)
        }
    }
}

#Preview {
    UserRow(user: User.mockUser)
        .modelContainer(for: Prospect.self)
}
