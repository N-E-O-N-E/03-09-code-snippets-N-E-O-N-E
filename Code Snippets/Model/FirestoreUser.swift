//
//  User.swift
//  Code Snippets
//
//  Created by Markus Wirtz on 16.10.24.
//

import Foundation

struct FirestoreUser: Codable, Identifiable {
    
    var id: String
    var username: String
    var email: String
    var password: String

}
