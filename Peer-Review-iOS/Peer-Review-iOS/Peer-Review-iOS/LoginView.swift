//
//  LoginView.swift
//  Peer-Review-iOS
//
//  Created by Kristina Cormier on 2026-03-20.
//

import SwiftUI

struct LoginView: View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var errorMessage: String = ""
    @State private var isLoading: Bool = false
    @State private var isLoggedIn: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                
                Spacer()
                
                Text("Peer Review App")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text("Login")
                    .font(.title2)
                    .foregroundColor(.gray)
                
                // EMAIL FIELD (FIXED)
                TextField("Email", text: $email)
                    .textFieldStyle(.roundedBorder)
                    .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                
                // PASSWORD FIELD
                SecureField("Password", text: $password)
                    .textFieldStyle(.roundedBorder)
                    .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                
                // ERROR MESSAGE
                if !errorMessage.isEmpty {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                }
                
                // LOGIN BUTTON
                Button(action: {
                    Task {
                        await login()
                    }
                }) {
                    Text(isLoading ? "Logging in..." : "Login")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(isLoading ? Color.gray : Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .disabled(isLoading)
                .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                
                Spacer()
                
                // NAVIGATION
                NavigationLink(
                    destination: HomeView(),
                    isActive: $isLoggedIn
                ) {
                    EmptyView()
                }
            }
            .padding()
        }
    }
    
    // MARK: - LOGIN FUNCTION
    func login() async {
        isLoading = true
        errorMessage = ""
        
        do {
            let response = try await APIService.shared.login(
                email: email,
                password: password
            )
            
            if response.must_change_password {
                errorMessage = "Password change required"
            } else {
                isLoggedIn = true
            }
            
        } catch {
            errorMessage = "Invalid email or password"
        }
        
        isLoading = false
    }
}

#Preview {
    LoginView()
}
