//
//  Model.swift
//  Code Snippets
//
//  Created by Markus Wirtz on 15.10.24.
//

import Foundation
import FirebaseFirestore

enum languages: String, CaseIterable {
    case SwiftUi = "SwiftUI"
    case JavaScript = "Kotlin"
    case Python = "Python"
    case Java   = "JavaScript"
}

struct Snippets: Codable, Identifiable {
    
    @DocumentID var id: String?
    
    let name: String
    let category: String
    let language: String
    let code: String
    
}


