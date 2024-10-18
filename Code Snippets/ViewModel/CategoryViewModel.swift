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
    @Published private(set) var categories: [Categories] = []
    
    private let auth = Auth.auth()
    
    func addCategory(name: String) {
        guard let userID = auth.currentUser?.uid else {return }
        let firebaseCategory = Categories(name: name)
        
        do {
            try FirebaseManager.shared.database.collection("users").document(userID).collection("categories").document().setData(from: firebaseCategory)
            fetchCategories()
        } catch {
            print("Saving categorie to Firestore failed \(error)")
        }
    }
    
    func fetchCategories() {
        guard let userID = auth.currentUser?.uid else {return }
        FirebaseManager.shared.database.collection("users").document(userID).collection("categories").addSnapshotListener { categories, error in
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
    
    func editCategorie(id: String, name: String) {
        guard let userID = auth.currentUser?.uid else { return }
        FirebaseManager.shared.database.collection("users").document(userID).collection("categories").document(id).updateData(["name": name])
        
    }
    
    func delCategorie(id: String) {
        guard let userID = auth.currentUser?.uid else { return }
        guard let categorieID = categories.first(where: { $0.id == id })?.id else { return }
        FirebaseManager.shared.database.collection("users").document(userID).collection("categories").document(categorieID).delete()
    }
    
    
    
}
