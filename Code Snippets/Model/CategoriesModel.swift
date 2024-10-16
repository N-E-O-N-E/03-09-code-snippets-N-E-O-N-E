//
//  Categories.swift
//  Code Snippets
//
//  Created by Markus Wirtz on 16.10.24.
//

import Foundation

struct Categories: Codable, Identifiable {
    
    let id: String?
    let name: String
    
    init(id: String?, name: String) {
        self.id = UUID().uuidString
        self.name = name
    }
}
