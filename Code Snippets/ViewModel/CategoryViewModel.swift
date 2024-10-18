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
    
    @Published var categories: [Categories] = []
    
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
    
    func editCategorie(categorieID: String, newName: String) {
        guard let userID = auth.currentUser?.uid else { return }
        FirebaseManager.shared.database.collection("users").document(userID).collection("categories").document(categorieID)
            .updateData(["name": newName])
    }
    
    func delCategorie(categorieID: String) {
        guard let userID = auth.currentUser?.uid else { return }
        guard let categorieID = categories.first(where: { $0.id == categorieID })?.id else { return }
        FirebaseManager.shared.database.collection("users").document(userID).collection("categories").document(categorieID)
            .delete()
    }
    
    
    
}
