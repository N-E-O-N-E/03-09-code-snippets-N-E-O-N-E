//
//  Model.swift
//  Code Snippets
//
//  Created by Markus Wirtz on 15.10.24.
//

import Foundation

struct Snippets: Codable, Identifiable {
    
    var id: String?
    
    let name: String
    let category: String
    let code: String
    
    init(id: String? = nil, name: String, category: String, code: String) {
        self.id = UUID().uuidString
        self.name = name
        self.category = category
        self.code = code
    }
    
}


