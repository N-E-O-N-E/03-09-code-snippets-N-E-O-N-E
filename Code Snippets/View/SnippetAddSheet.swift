//
//  SnippetAddSheet.swift
//  Code Snippets
//
//  Created by Markus Wirtz on 15.10.24.
//

import SwiftUI

struct SnippetAddSheet: View {
    @EnvironmentObject var snippetsViewModel: SnippetsViewModel
    @EnvironmentObject var categoryViewModel: CategoriyViewModel
    @Binding var isPresented: Bool
    var categorieID: String = ""
    
    @State private var inputName: String = ""
    @State private var inputCodeSnippet: String = ""
    @State private var inputLanguage: String = ""
    
    var body: some View {
        VStack {
            Text("Add new Snippet")
                .font(.title)
            VStack(alignment:.leading) {
                TextField("Name: ", text: $inputName)
                    .textFieldStyle(.roundedBorder)
                Text("Category: \(categoryViewModel.categories.first(where: { $0.id == categorieID })?.name ?? "No Category")")
                    .font(.callout)
                    .padding(10)
                Picker("Language:", selection: $inputLanguage) {
                    ForEach(languages.allCases, id: \.self) { language in
                        Text(language.rawValue).tag(language.rawValue)
                    }
                    
                }.pickerStyle(.palette)
                    .background(Color(hue: 0.9, saturation: 0.6, brightness: 0.9))
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                    .padding(.horizontal, 10)
                Divider()
                Text("CodeSnippet ").font(.callout)
                    .padding(10)
                TextEditor(text: $inputCodeSnippet)
                    .frame(height: 200)
                    .textFieldStyle(.roundedBorder)
                    .multilineTextAlignment(.leading)
                    .border(.gray)
                Button("Save") {
                    guard let categorieName = categoryViewModel.categories.first(where: { $0.id == categorieID})?.name else { return }
                    snippetsViewModel.addSnippet(name: inputName, categoryName: categorieName, categorieID: categorieID, code: inputCodeSnippet, language: inputLanguage)
                    isPresented = false
                }.buttonStyle(.borderedProminent)
            }.padding(30)
        }
        .presentationDetents([.fraction(0.9)])
    }
}

#Preview {
    @Previewable @State var test = false
    SnippetAddSheet(isPresented: $test)
        .environmentObject(CategoriyViewModel())
        .environmentObject(SnippetsViewModel())
}
