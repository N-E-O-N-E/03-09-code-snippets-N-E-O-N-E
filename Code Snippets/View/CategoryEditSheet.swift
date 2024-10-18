//
//  CategoryEditSheet.swift
//  Code Snippets
//
//  Created by Markus Wirtz on 18.10.24.
//

import SwiftUI

struct CategoryEditSheet: View {
    @EnvironmentObject var appViewModel: AppViewModel
    @EnvironmentObject var categoryViewModel: CategoriyViewModel
    
    @State private var input: String = ""
    @Binding var isPresentedForEdit: Bool
    @Binding var categoryID: String
    
    var body: some View {
        VStack {
            Text("Edit category")
                .font(.title)

            HStack {
                TextField(categoryViewModel.categories.first(where: { $0.id == categoryID })!.name, text: $input)
                    .textFieldStyle(.roundedBorder)
                
                Button("Edit") {
                    categoryViewModel.editCategorie(id: categoryID, name: input)
                    isPresentedForEdit = false
                }.buttonStyle(.borderedProminent)
                
            }.padding(30)
        }
        .presentationDetents([.fraction(0.2)])
    }
}

#Preview {
    CategoryEditSheet(isPresentedForEdit: .constant(true), categoryID: .constant(""))
        .environmentObject(AppViewModel())
        .environmentObject(CategoriyViewModel())
}
