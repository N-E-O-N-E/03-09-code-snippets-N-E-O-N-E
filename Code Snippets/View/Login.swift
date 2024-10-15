//
//  LogReg.swift
//  Code Snippets
//
//  Created by Markus Wirtz on 15.10.24.
//

import SwiftUI

struct Login: View {
    @EnvironmentObject var appViewModel: AppViewModel
    @State var email: String = ""
    @State var password: String = ""
    @State var loginDisabled: Bool = true
    
    func checkLoginDisabled() {
            if !email.isEmpty && !password.isEmpty {
                loginDisabled = false
            } else {
                loginDisabled = true
            }
        }
    
    var body: some View {
        
        VStack {
            
            Text("Authentification\n").font(.title).bold()
            
            Text("Login").font(.title2).bold()
            
            TextField("email", text: $email)
                .textFieldStyle(.roundedBorder).textInputAutocapitalization(.never)
                .onChange(of: email) { oldValue, newValue in
                    checkLoginDisabled()
                }
            SecureField("password", text: $password)
                .textFieldStyle(.roundedBorder).textInputAutocapitalization(.never)
                .onChange(of: password) { oldValue, newValue in
                    checkLoginDisabled()
                }
            
            HStack {
                Button("Login") {
                    appViewModel.signIn(email: email, password: password)
                }.buttonStyle(.borderedProminent).disabled(loginDisabled)
                
                NavigationLink("Register", destination: {
                    Register()
                })
            }
            
            Spacer()
            
            Text("Login Anonymously").font(.title2).bold()
            
            Button("Login Anonymously") {
                appViewModel.signInAnonymously()
            }.buttonStyle(.borderedProminent).tint(.purple)
            
        }.padding(40)
            
            
        
        
        Spacer()
        
    }
}

#Preview {
    Login()
        .environmentObject(AppViewModel())
}
