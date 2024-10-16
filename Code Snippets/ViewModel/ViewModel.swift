//
//  ViewModel.swift
//  Code Snippets
//
//  Created by Markus Wirtz on 15.10.24.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore
import GoogleSignIn

class AppViewModel: ObservableObject {
    init() {
        checkLogin()
    }
    
    @Published var isRegistered: Bool = false
    @Published var passwordAlert: Bool = false
    @Published var emailAlert: Bool = false
    @Published var registerDisabled: Bool = true
    @Published var loginDisabled: Bool = true
    @Published var errorMessage: String?
    
    //--------------------------------------------------------------------------------------------------------------
    
    
    // Authentification -----------------------------------------------
    
    @Published private(set) var user: FirestoreUser?
    private let auth = Auth.auth()
    
    var isAuthenticated: Bool {
        self.user != nil
    }
    
    var isAnonym: Bool {
        auth.currentUser?.anonymous() ?? true
    }
    
    func signInWithGoogle() {
        
        
    }
    
    func signIn(email: String, password: String) {
        auth.signIn(withEmail: email, password: password) { result, error in
            if let error {
                print("Error signing in: \(error)")
                return
            }
            
            guard let result else { return }
            print("User signed in: \(result.user)")
            self.fetchFirebaseUser(id: result.user.uid)
        }
    }
    
    func register(username: String, email: String, password: String) {
        auth.createUser(withEmail: email, password: password) { result, error in
            if let error = error?.localizedDescription {
                print("Error registering: \(error.description)")
                self.emailAlert.toggle()
                return
            }
            
            guard let result else { return }
            print("User created: \(result.user)")
            
            self.createFirebaseUser(id: result.user.uid, username: username, email: email, password: password)
            self.fetchFirebaseUser(id: result.user.uid)
            self.isRegistered = true
        }
    }
    
    func signInAnonymously() {
        auth.signInAnonymously { result, error in
            if let error {
                print("Error signing in anonymously: \(error)")
                return
            }
            
            guard let result else { return }
            
            self.createFirebaseUser(id: result.user.uid, username: "anonym", email: "", password: "")
            self.fetchFirebaseUser(id: result.user.uid)
            print("User signed in anonymously: \(result.user)")
            self.isRegistered = true
        }
    }
    
    func signOut() {
        do {
            try auth.signOut()
            self.user = nil
            print("User signed out")
        } catch {
            print("Error signing out: \(error)")
        }
    }
    
    func checkLogin() {
        if let currentUser = self.auth.currentUser {
            print("Benutzer ist bereits angemeldet mit der Id: \(currentUser.uid)")
            self.fetchFirebaseUser(id: currentUser.uid)
        }
    }
    
    // Snippet --------------------------------------------------------
    
//    func addSnippet(newSnippet snippet: Snippets) {
//        self.snippets.append(snippet)
//        print("New Snippet: \(snippet)")
//    }
    
    // Category -------------------------------------------------------
    
//    func addCategory(newCategory category: String) {
//        self.categories.append(category)
//        print("New Category: \(category)")
//    }
    
    // Login ----------------------------------------------------------
    
    func checkLoginDisabled(email: String, password: String) {
        if !email.isEmpty && !password.isEmpty {
            loginDisabled = false
        } else {
            loginDisabled = true
        }
    }
    
    //Register --------------------------------------------------------
    
    func checkRegisterDisabled(email: String, password: String, emailConfirm: String, passwordConfirm: String) {
        if !email.isEmpty && !password.isEmpty && email == emailConfirm && password == passwordConfirm {
            registerDisabled = false
        } else {
            registerDisabled = true
        }
    }
    
    func passwortLength(email: String, password: String) -> Bool {
        if password.count >= 6 {
            return true
        } else {
            passwordAlert.toggle()
            return false
        }
    }
    
    
    // Firebase ---------------------------------------------------------
    
    func createFirebaseUser (id: String, username: String, email: String, password: String) {
        let firebaseUser = FirestoreUser(id: id, username: username, email: email, password: password)
        
        do {
            try FirebaseManager.shared.database.collection("users").document(id).setData(from: firebaseUser)
        } catch {
            print("Saving user to Firestore failed \(error)")
        }
    }
        
    func fetchFirebaseUser(id: String) {
        // FirebaseManager.shared.database.collection("users").document(id).addSnapshotListener { (document, error) in
        FirebaseManager.shared.database.collection("users").document(id).getDocument { (user, error) in
            if let error {
                print("Error fetching user from Firestore: \(error)")
                return
            }
            
            guard let user else { return }
            
            do{
                let fireUser = try user.data(as: FirestoreUser.self)
                self.user = fireUser
            } catch {
                print("User does not exist \(error)")
            }
        }
    }
    
  
    
}

