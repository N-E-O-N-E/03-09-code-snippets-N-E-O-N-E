//
//  Categories.swift
//  Code Snippets
//
//  Created by Markus Wirtz on 16.10.24.
//

import Foundation
import FirebaseFirestore

struct Categories: Codable, Identifiable {
    
    @DocumentID var id: String?

    let name: String

}
