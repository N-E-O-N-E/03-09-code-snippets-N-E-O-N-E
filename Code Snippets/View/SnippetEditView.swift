//
//  SnippetEditView.swift
//  Code Snippets
//
//  Created by Markus Wirtz on 18.10.24.
//

import SwiftUI

struct SnippetEditView: View {
    @EnvironmentObject var categoryViewModel: CategoriyViewModel
    @EnvironmentObject var snippetsViewModel: SnippetsViewModel
    @Binding var isPresented: Bool
    
    @State private var inputName: String = ""
    @State private var inputCodeSnippet: String = ""
    @State private var inputLanguage: String = ""
    
    var categorieID: String = ""
    var snippetID: String = ""

    var body: some View {
       
        VStack {
            Text("Edit snippet")
                .font(.title)
            VStack(alignment:.leading) {
                TextField("\(snippetsViewModel.snippets.first(where: { $0.id == snippetID })?.name ?? "")", text: $inputName)
                    .textFieldStyle(.roundedBorder)
                TextEditor(text: $inputCodeSnippet)
                    .frame(height: 200)
                    .textFieldStyle(.roundedBorder)
                    .multilineTextAlignment(.leading)
                    .border(.gray)
                Button("Save") {
                    snippetsViewModel.editSnippet(snippetID: snippetID, categorie: categoryViewModel.categories.first(where: { $0.id == categorieID }), categorieID: categorieID,
                                                  name: inputName,
                                                  code: inputCodeSnippet)
                    isPresented = false
                }.buttonStyle(.borderedProminent)
            }.padding(30)
        }
        .presentationDetents([.fraction(0.9)])
        .onAppear() {
            snippetsViewModel.fetchSnippets(categoryID: categorieID)
            self.inputName = snippetsViewModel.snippets.first(where: { $0.id == snippetID })?.name ?? ""
            self.inputCodeSnippet = snippetsViewModel.snippets.first(where: { $0.id == snippetID })?.code ?? ""
        }
    }
}

#Preview {
    SnippetEditView(isPresented: .constant(true))
        .environmentObject(AppViewModel())
        .environmentObject(CategoriyViewModel())
        .environmentObject(SnippetsViewModel())
}
