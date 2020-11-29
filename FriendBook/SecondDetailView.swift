//
//  SecondDetailView.swift
//  FriendBook
//
//  Created by User23198271 on 7/25/20.
//  Copyright © 2020 Bryan. All rights reserved.
//

import SwiftUI

struct SecondDetailView: View {
    @FetchRequest(entity: Users.entity(), sortDescriptors: []) var users: FetchedResults<Users>
    let friend: String

    func getDetails() -> String {
        for user in users {
            if user.name == friend {
                return user.about ?? "No data"
            }
        }
        return ""
    }

    var body: some View {
        VStack {
        Text(friend)
        Text(getDetails())
        }
    }
}


