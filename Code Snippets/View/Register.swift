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
    
    var body: some View {
        VStack {
            Text("Authentification\n").font(.title).bold()
            Text("Register").font(.title2).bold()
            TextField("email", text: $email)
                .textFieldStyle(.roundedBorder).textInputAutocapitalization(.never)
                .onChange(of: email) { oldValue, newValue in
                    appViewModel.checkRegisterDisabled(email: email, password: password, emailConfirm: emailConfirm, passwordConfirm: passwordConfirm)}
            TextField("emailConfirm", text: $emailConfirm)
                .textFieldStyle(.roundedBorder).textInputAutocapitalization(.never)
                .onChange(of: emailConfirm) { oldValue, newValue in
                    appViewModel.checkRegisterDisabled(email: email, password: password, emailConfirm: emailConfirm, passwordConfirm: passwordConfirm)}
            SecureField("password", text: $password)
                .textFieldStyle(.roundedBorder).textInputAutocapitalization(.never)
                .onChange(of: password) { oldValue, newValue in
                    appViewModel.checkRegisterDisabled(email: email, password: password, emailConfirm: emailConfirm, passwordConfirm: passwordConfirm)}
            SecureField("passwordConfirm", text: $passwordConfirm)
                .textFieldStyle(.roundedBorder).textInputAutocapitalization(.never)
                .onChange(of: passwordConfirm) { oldValue, newValue in
                    appViewModel.checkRegisterDisabled(email: email, password: password, emailConfirm: emailConfirm, passwordConfirm: passwordConfirm)}
            
            Button("Register") {
                if appViewModel.passwortLength(email: email, password: password) {
                    appViewModel.register(email: email, password: password)
                } else {
                    appViewModel.passwordAlert.toggle()
                }
                
            }.buttonStyle(.borderedProminent).disabled(appViewModel.registerDisabled)
                .alert("E-Mail already exists!", isPresented: $appViewModel.emailAlert) {
                    Button("Confirm") {
                        appViewModel.emailAlert.toggle()
                    }.buttonStyle(.borderedProminent)
                }
                .alert("Password to short!\nMinimum 6 characters", isPresented: $appViewModel.passwordAlert) {
                    Button("Confirm") {
                        appViewModel.passwordAlert.toggle()
                    }.buttonStyle(.borderedProminent)
                }
            
        }.padding(40)
            .navigationDestination(isPresented: $appViewModel.isRegistered) {
                CategoryListView()
            }
        Spacer()
    }
}

#Preview {
    Register()
        .environmentObject(AppViewModel())
}
