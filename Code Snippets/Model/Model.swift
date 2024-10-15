//
//  Model.swift
//  Code Snippets
//
//  Created by Markus Wirtz on 15.10.24.
//

import Foundation

struct Snippets: Identifiable {
    
    var id: UUID = UUID()
    
    let name: String
    let category: String
    let code: String
    
    
}
