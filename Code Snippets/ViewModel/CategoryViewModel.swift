//
//  CategoryViewModel.swift
//  Code Snippets
//
//  Created by Markus Wirtz on 16.10.24.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore


class CategoriyViewModel: ObservableObject {

    
    @Published private(set) var categories: [Categories]?
    private let auth = Auth.auth()
    
    init(categories: [Categories]? = nil) {
        self.categories = categories
    }
    
    func addCategory(name: String) {
        let stringID = UUID().uuidString
        guard let userID = auth.currentUser?.uid else {return }
        let firebaseCategory = Categories(id: stringID, name: name)
        
        do {
            try FirebaseManager.shared.database.collection("users").document(userID).collection("categories").document(stringID).setData(from: firebaseCategory)
            fetchCategories()
        } catch {
            print("Saving categorie to Firestore failed \(error)")
        }
    }
    
    func fetchCategories() {
        guard let userID = auth.currentUser?.uid else {return }
        FirebaseManager.shared.database.collection("users").document(userID).collection("categories").getDocuments() { categories, error in
            if let error {
                print("Fetching categories failed \(error)")
                return
            }
            
            guard let categories = categories?.documents else { return }
            
            self.categories = categories.compactMap { categorie in
                try? categorie.data(as: Categories.self)
            }
        }
    }
    
    
    
}
