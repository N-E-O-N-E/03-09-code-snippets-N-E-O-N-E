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
     
    func addSnippet(name: String, categoryName: String, categorieID: String, code: String, language: String) {
        guard let userID = auth.currentUser?.uid else {return }
        let firebaseSnippet = Snippets(name: name, category: categoryName, language: language, code: code)
        
        do {
            try FirebaseManager.shared.database.collection("users").document(userID).collection("categories").document(categorieID).collection("snippets").document().setData(from: firebaseSnippet)
            fetchSnippets(categoryID: categorieID)
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
    
    func delSnippet(snippetID: String, categorieID: String) {
        guard let userID = auth.currentUser?.uid else {return }
        FirebaseManager.shared.database.collection("users").document(userID).collection("categories").document(categorieID).collection("snippets").document(snippetID).delete()
    }
    
    func editSnippet(snippetID: String, categorie: Categories?, categorieID: String, name: String, code: String) {
        guard let userID = auth.currentUser?.uid else {return }
        guard let categorieName = categorie?.name else {return }
        
        let data = ["name": name, "code": code]
        
        FirebaseManager.shared.database.collection("users").document(userID)
            .collection("categories").document(categorieID)
            .collection("snippets").document(snippetID).updateData(data) { error in
                if let error {
                    print("Error \(error)")
                    return
                }
            }
    }
    
    
}
    
