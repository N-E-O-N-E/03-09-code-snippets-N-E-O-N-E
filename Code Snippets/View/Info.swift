//
//  Info.swift
//  Code Snippets
//
//  Created by Markus Wirtz on 17.10.24.
//

import SwiftUI

struct Info: View {
    var body: some View {
        ZStack {
            Image("code1")
            VStack {
                Text("<CODE> SNIPPETS")
                    .font(.title).bold().fontDesign(.monospaced)
                Spacer()
                Text("</Version V1.02 >")
                    .font(.headline).bold().fontDesign(.monospaced)
            }.frame(height: 350)
        }
    }
}

#Preview {
    Info()
}
