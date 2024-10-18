//
//  SnippetListView.swift
//  Code Snippets
//
//  Created by Markus Wirtz on 15.10.24.
//

import SwiftUI

struct SnippetListView: View {
    @EnvironmentObject var categoryViewModel: CategoriyViewModel
    @EnvironmentObject var snippetsViewModel: SnippetsViewModel
    var categorieID: String = ""
    @State var snippetID: String = ""
    
    @State var isPresentedForEdit: Bool = false
    @State var isPresented: Bool = false
    
    var body: some View {
        List(snippetsViewModel.snippets) { snippet in
            
            VStack(alignment: .leading) {
                HStack {
                    Text(snippet.name)
                    Spacer()
                    Text(snippet.language)
                        .foregroundStyle(.purple)
                }
                Divider()
                Text(snippet.code)
                    .fontDesign(.monospaced)
                    .font(.callout).foregroundStyle(.red)
            }.swipeActions(edge: .leading) {
                Button() {
                    self.snippetID = snippet.id ?? ""
                    isPresentedForEdit.toggle()
                } label: {
                    Label("Edit", systemImage: "pencil")
                }
                Button(role: .destructive) {
                    self.snippetID = snippet.id ?? ""
                    snippetsViewModel.delSnippet(snippetID: snippetID, categorieID: categorieID)
                } label: {
                    Label("Delete", systemImage: "trash")
                }
            }
        }
        .navigationTitle("Snippets list")
        .toolbar {
            Button {
                isPresented.toggle()
            } label: {
                Image(systemName: "plus.app")
            }
        }
        .sheet(isPresented: $isPresented) {
            SnippetAddSheet(isPresented: $isPresented, categorieID: categorieID)
        }
        .sheet(isPresented: $isPresentedForEdit) {
            SnippetEditView(isPresented: $isPresentedForEdit, categorieID: categorieID, snippetID: snippetID)
        }
        .onAppear() {
            snippetsViewModel.fetchSnippets(categoryID: categorieID)
        }
    }
}

#Preview {
    SnippetListView()
        .environmentObject(AppViewModel())
        .environmentObject(SnippetsViewModel())
}
