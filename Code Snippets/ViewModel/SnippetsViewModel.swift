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
    
    @Published private(set) var snippets: [Snippets]?
    private let auth = Auth.auth()
    
    init(snippets: [Snippets]? = nil) {
        self.snippets = snippets
    }
     
    func addSnippet(name: String, category: String, code: String, categoryID: String) {
        let stringID = UUID().uuidString
        let categoryID = categoryID
        guard let userID = auth.currentUser?.uid else {return }
        let firebaseSnippet = Snippets(id: stringID, name: name, category: category, code: code)
        
        do {
            try FirebaseManager.shared.database.collection("users").document(userID).collection("categories").document(categoryID).collection("snippets").document(stringID).setData(from: firebaseSnippet)
            fetchSnippets(categoryID: categoryID)
        } catch {
            print("Saving snippet to Firestore failed \(error)")
        }
    }
    
    func fetchSnippets(categoryID: String) {
        guard let userID = auth.currentUser?.uid else {return }
            FirebaseManager.shared.database.collection("users").document(userID).collection("categories").document(categoryID).collection("snippets").getDocuments() { snippets, error in
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
    
