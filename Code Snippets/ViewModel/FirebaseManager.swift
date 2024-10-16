//
//  FirebaseManager.swift
//  Code Snippets
//
//  Created by Markus Wirtz on 16.10.24.
//

import FirebaseFirestore
import Foundation

class FirebaseManager {
    static let shared = FirebaseManager()
    let database = Firestore.firestore()
}
