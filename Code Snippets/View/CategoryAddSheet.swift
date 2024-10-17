//
//  CategoryAddSheet.swift
//  Code Snippets
//
//  Created by Markus Wirtz on 15.10.24.
//

import SwiftUI

struct CategoryAddSheet: View {
    
    @EnvironmentObject var appViewModel: AppViewModel
    @EnvironmentObject var categoryViewModel: CategoriyViewModel
    @EnvironmentObject var snippetsViewModel: SnippetsViewModel
    
    @State private var input: String = ""
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack {
            Text("Add new Category")
                .font(.title)

            HStack {
                TextField("new category", text: $input)
                    .textFieldStyle(.roundedBorder)
                
                Button("Add") {
                    categoryViewModel.addCategory(name: input)
                    isPresented = false
                }.buttonStyle(.borderedProminent)
                
            }.padding(30)
        }
        .presentationDetents([.fraction(0.2)])
    }
}

#Preview {
    @Previewable @State var test = false
    CategoryAddSheet(isPresented: $test)
        .environmentObject(AppViewModel())
        .environmentObject(CategoriyViewModel())
        .environmentObject(SnippetsViewModel())
}
