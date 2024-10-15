import SwiftUI
import FirebaseCore
import Firebase
import FirebaseAuth


@main
struct Code_SnippetsApp: App {
    
    @StateObject private var appViewModel = AppViewModel()
    
    init() {
        FirebaseConfiguration.shared.setLoggerLevel(.min)
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        
        WindowGroup {
            
            if appViewModel.isAuthenticated {
                NavigationStack {
                    CategoryListView()
                }
            } else {
                NavigationStack {
                    Login()
                }
            }
        }
        .environmentObject(self.appViewModel)
    }
}
