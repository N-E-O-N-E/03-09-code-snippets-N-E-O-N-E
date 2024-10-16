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
    @EnvironmentObject var snippetsViewModel: SnippetsViewModel
    
    @State var isPresented: Bool = false
    
    var body: some View {
        
        Text("Categories Overview").font(.title).bold()
        
        List(categoryViewModel.categories ?? []) { category in
            NavigationLink("\(Image(systemName: "archivebox.fill")) \(category.name)") {
                SnippetListView(categoryID: category.id ?? "")
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
        .onAppear() {
            categoryViewModel.fetchCategories()
        }
    }
}

#Preview {
    CategoryListView()
        .environmentObject(AppViewModel())
        .environmentObject(CategoriyViewModel())
        .environmentObject(SnippetsViewModel())
    
}
