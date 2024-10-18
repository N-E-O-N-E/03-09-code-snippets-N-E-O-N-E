//
//  CategoryView.swift
//  Code Snippets
//
//  Created by Markus Wirtz on 15.10.24.
//

import SwiftUI

struct CategoryListView: View {
    
    @EnvironmentObject var appViewModel: AppViewModel
    @EnvironmentObject var categoryViewModel: CategoriyViewModel
    
    @State private var isPresented: Bool = false
    @State private var isPresentedForEdit: Bool = false
    
    @State private var categorieID: String = ""
    
    var body: some View {
        Text("Categories Overview").font(.title).bold()
        
        List(categoryViewModel.categories) { category in
            VStack {
                NavigationLink("\(Image(systemName: "archivebox.fill")) \(category.name)") {
                    SnippetListView(categorieID: category.id ?? "")
                    
                }.swipeActions(edge: .leading) {
                    Button() {
                        self.categorieID = category.id ?? ""
                        isPresentedForEdit.toggle()
                    } label: {
                        Label("Edit", systemImage: "pencil")
                    }
                    Button(role: .destructive) {
                        categoryViewModel.delCategorie(categorieID: category.id ?? "")
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }
                }
            }
        }
        .toolbar {
            Button {
                isPresented.toggle()
            } label: {
                Image(systemName: "plus.app")
            }
            Button {
                appViewModel.signOut()
            } label: {
                Image(systemName: "door.left.hand.open")
            }
        }
        .sheet(isPresented: $isPresented) {
            CategoryAddSheet(isPresented: $isPresented)
        }
        .sheet(isPresented: $isPresentedForEdit) {
            CategoryEditSheet(isPresentedForEdit: $isPresentedForEdit, categorieID: categorieID)
        }
        .onAppear() {
            categoryViewModel.fetchCategories()
        }
    }
}

#Preview {
    CategoryListView()
}
