//
//  DetailView.swift
//  FriendBook
//
//  Created by User23198271 on 7/25/20.
//  Copyright © 2020 Bryan. All rights reserved.
//

import SwiftUI

struct DetailView: View {
    let item: Users
    @FetchRequest(entity: FriendsOfUsers.entity(), sortDescriptors: []) var friends: FetchedResults<FriendsOfUsers>
    
    func GetFriendList() -> Array<String> {
        var friendList = [String]()
        for friend in friends {
            if friend.parent == item.name {
                if friendList.contains(friend.name ?? "whatever") {
                    // This seems dumb but...
                } else {
                friendList.append(friend.name ?? "nobody")
                }
            }
        }
        return friendList
    }
    
    var body: some View {
            VStack {
                    VStack(alignment: .leading) {
                        Text("Who am I?").font(.headline)
                        Text("My name is " + (item.name ?? "a mystery"))
                        Text("I am " + String(item.age))
                        Text("I work for " + (item.company ?? "Dr. Evil"))
                    }
                    .padding(10)
                    VStack(alignment: .leading) {
                        Text("About Me").font(.headline)
                        Text(item.about ?? "I am silent like the night")
                    }
                .layoutPriority(1)
                .padding(.bottom, 10)
                    VStack(alignment: .leading) {
                        Text("Contact Details").font(.headline)
                        Text("Email: " + (item.email ?? "you'll never find me!"))
                        Text("Address: " + (item.address ?? "Neverrrrrr"))
                    }
                .padding(.bottom, 10)
                        Text("My Friends").font(.headline)
                        List {
                        ForEach(GetFriendList(), id:\.self) { friend in
                            NavigationLink(destination: SecondDetailView(friend: friend)) {
                                Text(friend)
                        }
                    }
                }
            }.navigationBarTitle("Profile", displayMode: .inline)
    }
}



