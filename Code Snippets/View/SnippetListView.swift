//
//  SnippetListView.swift
//  Code Snippets
//
//  Created by Markus Wirtz on 15.10.24.
//

import SwiftUI

struct SnippetListView: View {
    @EnvironmentObject var appViewModel: AppViewModel
    @EnvironmentObject var categoryViewModel: CategoriyViewModel
    @EnvironmentObject var snippetsViewModel: SnippetsViewModel
    var categoryID: String = ""
    
    
    @State var isPresented: Bool = false
    
    var body: some View {
        List(snippetsViewModel.snippets ?? []) { snippet in
            
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
            SnippetAddSheet(isPresented: $isPresented, categoryID: categoryID )
        }
        .onAppear() {
            snippetsViewModel.fetchSnippets(categoryID: categoryID)
        }
    }
}

#Preview {
    SnippetListView()
        .environmentObject(AppViewModel())
        .environmentObject(CategoriyViewModel())
        .environmentObject(SnippetsViewModel())
}
