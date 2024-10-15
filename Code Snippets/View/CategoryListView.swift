//
//  CategoryView.swift
//  Code Snippets
//
//  Created by Markus Wirtz on 15.10.24.
//

import SwiftUI

struct CategoryListView: View {
    
    @EnvironmentObject var appViewModel: AppViewModel
    @State var isPresented: Bool = false
    
    var body: some View {
            List(appViewModel.categories, id: \.self) { category in
                NavigationLink("\(category.description)") {
                    SnippetListView(category: category.description)
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
    }
}

#Preview {
    CategoryListView()
        .environmentObject(AppViewModel())
}
