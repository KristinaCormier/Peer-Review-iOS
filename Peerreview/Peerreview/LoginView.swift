import SwiftUI

struct LoginView: View {
    
    @EnvironmentObject var session: UserSession
    
    @State private var email = ""
    @State private var password = ""
    @State private var selectedRole: UserRole = .student
    
    @State private var isLoggedIn = false
    @State private var showForgot = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        
        ZStack {
            
            LinearGradient(colors: [.pink, .purple, .blue],
                           startPoint: .top,
                           endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                
                Image("oclogo3")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
                
                Text("Welcome Back")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.white)
                
              
                TextField("Email", text: $email)
                    .padding()
                    .background(Color.white.opacity(0.95))
                    .cornerRadius(12)
                    .foregroundColor(.black)
                    .font(.system(size: 18, weight: .semibold))
                    .accentColor(.black)
                    .padding(.horizontal)
                
             
                SecureField("Password", text: $password)
                    .padding()
                    .background(Color.white.opacity(0.95))
                    .cornerRadius(12)
                    .foregroundColor(.black)
                    .font(.system(size: 18, weight: .semibold))
                    .accentColor(.black)
                    .padding(.horizontal)
                
              
                HStack(spacing: 10) {
                    
                    Button("Student") {
                        selectedRole = .student
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(selectedRole == .student ? Color.orange : Color.white.opacity(0.3))
                    .foregroundColor(.white)
                    .cornerRadius(12)
                    
                    Button("Professor") {
                        selectedRole = .professor
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(selectedRole == .professor ? Color.orange : Color.white.opacity(0.3))
                    .foregroundColor(.white)
                    .cornerRadius(12)
                    
                    Button("Admin") {
                        selectedRole = .admin
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(selectedRole == .admin ? Color.orange : Color.white.opacity(0.3))
                    .foregroundColor(.white)
                    .cornerRadius(12)
                }
                .padding(.horizontal)
                
               
                Button {
                    login()
                } label: {
                    Text("Login")
                        .font(.system(size: 18, weight: .bold))
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            LinearGradient(colors: [.blue, .purple],
                                           startPoint: .leading,
                                           endPoint: .trailing)
                        )
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                .padding(.horizontal)
                
                
                Button("Forgot Password?") {
                    showForgot = true
                }
                .foregroundColor(.white)
                
                Spacer()
            }
        }
        
        .fullScreenCover(isPresented: $isLoggedIn) {
            HomeView(isLoggedIn: $isLoggedIn, role: $selectedRole)
        }
        
        .sheet(isPresented: $showForgot) {
            ForgotPasswordView()
        }
        
        .alert("Error", isPresented: $showAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(alertMessage)
        }
    }
    
    func login() {
        
        if selectedRole == .student &&
            email == "student@test.com" &&
            password == "123456" {
            
            session.userName = "Student"
            isLoggedIn = true
        }
        
        else if selectedRole == .professor &&
                email == "prof@test.com" &&
                password == "123456" {
            
            session.userName = "Professor"
            isLoggedIn = true
        }
        
        else if selectedRole == .admin &&
                email == "admin@test.com" &&
                password == "123456" {
            
            session.userName = "Admin"
            isLoggedIn = true
        }
        
        else {
            alertMessage = "Invalid login credentials"
            showAlert = true
        }
    }
}
