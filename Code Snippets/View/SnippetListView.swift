//
//  SnippetListView.swift
//  Code Snippets
//
//  Created by Markus Wirtz on 15.10.24.
//

import SwiftUI

struct SnippetListView: View {
    @EnvironmentObject var appViewModel: AppViewModel
    @State var isPresented: Bool = false
    var category: String = ""
    
    var body: some View {
        List(appViewModel.snippets.filter({ $0.category == category })) { snippet in
            VStack(alignment: .leading) {
                HStack {
                    Text(snippet.name)
                    Spacer()
                    Text(snippet.category)
                        .foregroundStyle(.orange)
                }
                Divider()
                Text(snippet.code)
                    .fontDesign(.monospaced)
                    .font(.callout).foregroundStyle(.red)
            }
        }
        .toolbar {
            Button {
                isPresented.toggle()
            } label: {
                Image(systemName: "plus.app")
            }
        }
        .sheet(isPresented: $isPresented) {
            SnippetAddSheet(isPresented: $isPresented, category: category.description)
        }
    }
}

#Preview {
    SnippetListView()
        .environmentObject(AppViewModel())
}
