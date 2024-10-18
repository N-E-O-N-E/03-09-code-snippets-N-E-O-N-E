//
//  CategoryEditSheet.swift
//  Code Snippets
//
//  Created by Markus Wirtz on 18.10.24.
//

import SwiftUI

struct CategoryEditSheet: View {
    @EnvironmentObject var categoryViewModel: CategoriyViewModel
    @Binding var isPresentedForEdit: Bool
    
    var categorieID: String = ""
    @State private var newName: String = ""
    
    var body: some View {
        VStack {
            Text("Edit category")
                .font(.title)

            HStack {
                TextField(categoryViewModel.categories.first(where: { $0.id == categorieID })?.name ?? "", text: $newName)
                    .textFieldStyle(.roundedBorder)
                
                Button("Edit") {
                    categoryViewModel.editCategorie(categorieID: categorieID, newName: newName)
                    isPresentedForEdit = false
                }.buttonStyle(.borderedProminent)
                
            }.padding(30)
        }
        .presentationDetents([.fraction(0.2)])
    }
}

#Preview {
    CategoryEditSheet(isPresentedForEdit: .constant(true))
        .environmentObject(CategoriyViewModel())
}
