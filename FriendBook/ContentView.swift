//
//  ContentView.swift
//  FriendBook
//
//  Created by User23198271 on 7/23/20.
//  Copyright © 2020 Bryan. All rights reserved.
//

import SwiftUI

struct Result: Codable {
    
    var id: String
    var isActive: Bool
    var name: String
    var age: Int
    var company: String
    var email: String
    var address: String
    var about: String
    var friends = [Friends]()
}

struct Friends: Codable {
    var id: String
    var name: String
}

struct ContentView: View {
//    @State var results = [Result]()
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Users.entity(), sortDescriptors: []) var users: FetchedResults<Users>
    
    var body: some View {
        NavigationView {
            List(users, id: \.self) { item in
                NavigationLink(destination: DetailView(item: item)) {
                    VStack(alignment: .leading) {
                        Text(item.name ?? "Unknown Name")
                            .font(.headline)
                        if item.isActive {
                            Text("🟢 Online")
                        } else {
                            Text("🔴 Away")
                    }
                }
            }
        }
        .onAppear(perform: getData)
        .navigationBarTitle("FriendBook")
    }
}
    
// THIS IS WHERE MY API CALL BEGINS
func getData() {
    guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
        print("Invalid URL")
        return
    }
    let request = URLRequest(url: url)
    URLSession.shared.dataTask(with: request) { data, response, error in
        if let data = data {
            if let decodedResponse = try? JSONDecoder().decode([Result].self, from: data) {
                // we have good data – go back to the main thread
                DispatchQueue.main.async {
                    // update our UI
//                    self.results = decodedResponse
                    
                    for response in decodedResponse {
                        let newUser = Users(context: self.moc)
                        newUser.id = response.id
                        newUser.isActive = response.isActive
                        newUser.name = response.name
                        newUser.age = Int16(response.age)
                        newUser.company = response.company
                        newUser.email = response.email
                        newUser.address = response.address
                        newUser.about = response.about
                    
                    for friend in response.friends {
                        let newFriendList = FriendsOfUsers(context: self.moc)
                        newFriendList.id = friend.id
                        newFriendList.name = friend.name
                        newFriendList.parent = response.name
                        }
                        
                        try? self.moc.save()
                    }
                }

                // everything is good, so we can exit
                return
        // if we're still here it means there was a problem
                }
            }
        print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
        }.resume()
    }
}


// To do: How will I distiguish between which friends belong to which users when reading the data from core data?
// Need to change to read data from Core Data rather than structs (see ONLY error in content view - on line 37)
