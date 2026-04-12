import SwiftUI

struct ForgotPasswordView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State private var email = ""
    @State private var phone = ""
    
    @State private var showAlert = false
    @State private var message = ""
    
    var body: some View {
        
        ZStack {
            
          
            LinearGradient(colors: [.pink, .purple, .blue],
                           startPoint: .top,
                           endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack(spacing: 25) {
                
                Text("Reset Password")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                
               
                TextField("Email", text: $email)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(12)
                    .foregroundColor(.black)
                    .font(.system(size: 18, weight: .semibold))
                
        
                TextField("Phone", text: $phone)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(12)
                    .foregroundColor(.black)
                    .font(.system(size: 18, weight: .semibold))
                
            
                Button {
                    validate()
                } label: {
                    Text("Submit")
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
                
               
                Button("Cancel") {
                    dismiss()
                }
                .foregroundColor(.white)
                
                Spacer()
            }
            .padding()
        }
        
      
        .alert(message, isPresented: $showAlert) {
            Button("OK") {
                if message == "Reset link will be sent" {
                    dismiss()
                }
            }
        }
    }
    
    func validate() {
        
        let emailValid = email.contains("@") && email.contains(".")
        let phoneValid = phone.count >= 10
        
        if !emailValid || !phoneValid {
            message = "Invalid format"
        } else {
            message = "Reset link will be sent"
        }
        
        showAlert = true
    }
}
