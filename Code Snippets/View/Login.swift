//
//  LogReg.swift
//  Code Snippets
//
//  Created by Markus Wirtz on 15.10.24.
//

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift

struct Login: View {
    @EnvironmentObject var appViewModel: AppViewModel
    @State var email: String = ""
    @State var password: String = ""
    
    var body: some View {
        VStack {
            Text("Authentification\n").font(.title).bold()
            Image("code1").resizable().scaledToFill().frame(width: 350, height: 250).clipShape(.rect(cornerRadius: 10)).padding()
            Text("Login").font(.title2).bold()
            TextField("email", text: $email)
                .textFieldStyle(.roundedBorder).textInputAutocapitalization(.never)
                .onChange(of: email) { oldValue, newValue in
                    appViewModel.checkLoginDisabled(email: email, password: password)}
            SecureField("password", text: $password)
                .textFieldStyle(.roundedBorder).textInputAutocapitalization(.never)
                .onChange(of: password) { oldValue, newValue in
                    appViewModel.checkLoginDisabled(email: email, password: password)}
            HStack {
                Button("Login") {
                    appViewModel.signIn(email: email, password: password)
                }.buttonStyle(.borderedProminent).disabled(appViewModel.loginDisabled)
                NavigationLink("Register", destination: {
                    Register()
                })
            }
            Spacer()
            
            
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
