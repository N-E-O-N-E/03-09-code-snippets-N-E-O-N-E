import SwiftUI
import FirebaseCore
import Firebase
import FirebaseAuth

@main
struct Code_SnippetsApp: App {
    @StateObject private var appViewModel = AppViewModel()
    @StateObject private var categoryViewModel = CategoriyViewModel()
    @StateObject private var snippetsViewModel = SnippetsViewModel()
    
    init() {
        FirebaseConfiguration.shared.setLoggerLevel(.min)
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            if appViewModel.isAuthenticated {
                
                TabView {
                    Tab("Info", systemImage: "info.circle.fill") {
                        NavigationStack {
                            Info()
                        }
                    }
                    Tab("Categories", systemImage: "archivebox.fill") {
                        NavigationStack {
                            CategoryListView()
                        }
                    }
                }.tint(.black)
                   
                
            } else {
                NavigationStack {
                    Login()
                }
            }
        }
        .environmentObject(self.appViewModel)
        .environmentObject(self.categoryViewModel)
        .environmentObject(self.snippetsViewModel)
    }
}
