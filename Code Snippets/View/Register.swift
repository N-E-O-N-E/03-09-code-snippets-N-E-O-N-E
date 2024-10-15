//
//  LogReg.swift
//  Code Snippets
//
//  Created by Markus Wirtz on 15.10.24.
//

import SwiftUI

struct Register: View {
    @EnvironmentObject var appViewModel: AppViewModel
    
    @State var email: String = ""
    @State var emailConfirm: String = ""
    @State var password: String = ""
    @State var passwordConfirm: String = ""
    @State var registerDisabled: Bool = true
    @State var isRegistered: Bool = false
    @State var passwordAlert: Bool = false
    
    func checkRegisterDisabled() {
        if !email.isEmpty && !password.isEmpty && email == emailConfirm && password == passwordConfirm {
            registerDisabled = false
        } else {
            registerDisabled = true
        }
    }
    
    var body: some View {
        
        VStack {
            
            Text("Authentification\n").font(.title).bold()
            
            Text("Register").font(.title2).bold()
            
            TextField("email", text: $email)
                .textFieldStyle(.roundedBorder).textInputAutocapitalization(.never)
                .onChange(of: email) { oldValue, newValue in
                    checkRegisterDisabled()
                }
            TextField("emailConfirm", text: $emailConfirm)
                .textFieldStyle(.roundedBorder).textInputAutocapitalization(.never)
                .onChange(of: emailConfirm) { oldValue, newValue in
                    checkRegisterDisabled()
                }
            SecureField("password", text: $password)
                .textFieldStyle(.roundedBorder).textInputAutocapitalization(.never)
                .onChange(of: password) { oldValue, newValue in
                    checkRegisterDisabled()
                }
            SecureField("passwordConfirm", text: $passwordConfirm)
                .textFieldStyle(.roundedBorder).textInputAutocapitalization(.never)
                .onChange(of: passwordConfirm) { oldValue, newValue in
                    checkRegisterDisabled()
                }
            
            Button("Register") {
                if password.count >= 6 {
                    appViewModel.register(email: email, password: password)
                    isRegistered.toggle()
                } else {
                    passwordAlert.toggle()
                }
            }.buttonStyle(.borderedProminent).disabled(registerDisabled)
                
            
            
                .alert("Password to short!\nMinimum 6 characters", isPresented: $passwordAlert) {
                    Button("Confirm") {
                        passwordAlert.toggle()
                    }.buttonStyle(.borderedProminent)
                }
            
            
            
        }.padding(40)
        
            .navigationDestination(isPresented: $isRegistered) {
                CategoryListView()
            }
        
        Spacer()
        
    }
}

#Preview {
    Register()
        .environmentObject(AppViewModel())
}
