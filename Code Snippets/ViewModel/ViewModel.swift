//
//  ViewModel.swift
//  Code Snippets
//
//  Created by Markus Wirtz on 15.10.24.
//

import Foundation
import Firebase
import FirebaseAuth
import GoogleSignIn

class AppViewModel: ObservableObject {
    init() {
        checkLogin()
    }
    
    @Published private(set) var snippets: [Snippets] = [
        Snippets(name: "CodeSnippet 1", category: "Other", code: "<This is a code example for Other!!!>"),
        Snippets(name: "CodeSnippet 2", category: "Functions", code: "<This is a code exapmle for Functions!!!>"),
        Snippets(name: "CodeSnippet 3", category: "Methods", code: "<This is a Code example for Methods!!!>")]
    @Published private(set) var categories: [String] = [
        "Functions","Methods","Other"
    ]
    @Published var isRegistered: Bool = false
    @Published var passwordAlert: Bool = false
    @Published var emailAlert: Bool = false
    @Published var registerDisabled: Bool = true
    @Published var loginDisabled: Bool = true
    @Published var errorMessage: String?
    
    //--------------------------------------------------------------------------------------------------------------
    
    
    // Authentification -----------------------------------------------
    
    @Published private(set) var user: User?
    private let auth = Auth.auth()
    
    var isAuthenticated: Bool {
        self.user != nil
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
            self.user = result.user
        }
    }
    
    func register(email: String, password: String) {
        auth.createUser(withEmail: email, password: password) { result, error in
            if let error = error?.localizedDescription {
                print("Error registering: \(error.description)")
                self.emailAlert.toggle()
                return
            }
            
            guard let result else { return }
            print("User created: \(result.user)")
            self.user = result.user
            self.isRegistered.toggle()
        }
    }
    
    func signInAnonymously() {
        auth.signInAnonymously { result, error in
            if let error {
                print("Error signing in anonymously: \(error)")
                return
            }
            
            guard let result else { return }
            print("User signed in anonymously: \(result.user)")
            self.user = result.user
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
            self.user = currentUser
        }
    }
    
    // Snippet --------------------------------------------------------
    
    func addSnippet(newSnippet snippet: Snippets) {
        self.snippets.append(snippet)
        print("New Snippet: \(snippet)")
    }
    
    // Category -------------------------------------------------------
    
    func addCategory(newCategory category: String) {
        self.categories.append(category)
        print("New Category: \(category)")
    }
    
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
}

