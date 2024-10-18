//
//  SnippetAddSheet.swift
//  Code Snippets
//
//  Created by Markus Wirtz on 15.10.24.
//

import SwiftUI

struct SnippetAddSheet: View {
    @EnvironmentObject var appViewModel: AppViewModel
    @EnvironmentObject var categoryViewModel: CategoriyViewModel
    @EnvironmentObject var snippetsViewModel: SnippetsViewModel
    
    @Binding var isPresented: Bool
    @State private var inputName: String = ""
    @State private var inputCodeSnippet: String = ""
    @State private var inputLanguage: String = ""
    
    var categoryID: String = ""
    
    var body: some View {
        VStack {
            Text("Add new Snippet")
                .font(.title)
            VStack(alignment:.leading) {
                TextField("Name: ", text: $inputName)
                    .textFieldStyle(.roundedBorder)
                Text("Category: \(categoryViewModel.categories.first(where: { $0.id == categoryID })?.name ?? "No Category")")
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
                    //                    let newSnippet = Snippets(name: inputName, category: category, code: inputCodeSnippet)
                    //                    appViewModel.addSnippet(newSnippet: newSnippet)
                    snippetsViewModel.addSnippet(name: inputName, category: "\(categoryViewModel.categories.first(where: { $0.id == categoryID })?.name ?? "No Category")", code: inputCodeSnippet, language: inputLanguage, categoryID: categoryID)
                    isPresented = false
                }.buttonStyle(.borderedProminent)
            }.padding(30)
        }
        .presentationDetents([.fraction(0.8)])
    }
}

#Preview {
    @Previewable @State var test = false
    SnippetAddSheet(isPresented: $test)
        .environmentObject(AppViewModel())
        .environmentObject(CategoriyViewModel())
        .environmentObject(SnippetsViewModel())
}
