//
//  TestButton.swift
//  Code Snippets
//
//  Created by Markus Wirtz on 14.10.24.
//

import SwiftUI

struct CrashView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        
        Button("Crash") {
          fatalError("Crash was triggered")
        }
    }
}

#Preview {
    CrashView()
}
