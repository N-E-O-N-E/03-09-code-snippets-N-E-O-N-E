//
//  SnippetsViewModel.swift
//  Code Snippets
//
//  Created by Markus Wirtz on 16.10.24.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore


class SnippetsViewModel: ObservableObject {
    
    @Published private(set) var snippets: [Snippets] = []
    private let auth = Auth.auth()
     
    func addSnippet(name: String, category: String, code: String, language: String, categoryID: String) {
        let categoryID = categoryID
        guard let userID = auth.currentUser?.uid else {return }
        let firebaseSnippet = Snippets(name: name, category: category, language: language, code: code)
        
        do {
            try FirebaseManager.shared.database.collection("users").document(userID).collection("categories").document(categoryID).collection("snippets").document().setData(from: firebaseSnippet)
            fetchSnippets(categoryID: categoryID)
        } catch {
            print("Saving snippet to Firestore failed \(error)")
        }
    }
    
    func fetchSnippets(categoryID: String) {
        guard let userID = auth.currentUser?.uid else {return }
        FirebaseManager.shared.database.collection("users").document(userID).collection("categories").document(categoryID).collection("snippets").addSnapshotListener { snippets, error in
            if let error {
                print("Fetching snippets failed \(error)")
                return
            }
            
            guard let snippets = snippets?.documents else { return }
            
            self.snippets = snippets.compactMap { snippet in
                try? snippet.data(as: Snippets.self)
            }
        }
    }
}
    
