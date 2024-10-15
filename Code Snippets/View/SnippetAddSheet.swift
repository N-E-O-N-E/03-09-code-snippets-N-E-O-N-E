//
//  SnippetAddSheet.swift
//  Code Snippets
//
//  Created by Markus Wirtz on 15.10.24.
//

import SwiftUI

struct SnippetAddSheet: View {
    @EnvironmentObject var appViewModel: AppViewModel
    @Binding var isPresented: Bool
    @State private var inputName: String = ""
    var category = ""
    @State private var inputCodeSnippet: String = ""
    
    var body: some View {
        VStack {
            Text("Add new Snippet")
                .font(.title)
            VStack(alignment:.leading) {
                TextField("Name: ", text: $inputName)
                    .textFieldStyle(.roundedBorder)
                Text("Category: \(category.description)")
                    .font(.callout)
                    .padding(10)
                Divider()
                Text("CodeSnippet ").font(.callout)
                    .padding(10)
                TextEditor(text: $inputCodeSnippet)
                    .frame(height: 300)
                    .textFieldStyle(.roundedBorder)
                    .multilineTextAlignment(.leading)
                    .border(.gray)
                Button("Save Snippet") {
                    // add snippet in list
                    let newSnippet = Snippets(name: inputName, category: category, code: inputCodeSnippet)
                    appViewModel.addSnippet(newSnippet: newSnippet)
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
}
