import SwiftUI

struct SearchView: View {
    
    var role: UserRole
    
    @State private var query = ""
    @State private var showAlert = false
    
    var body: some View {
        
        ZStack {
            
            LinearGradient(colors: [.pink, .purple],
                           startPoint: .top,
                           endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack(spacing: 25) {
                
                Text("Search")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                
                TextField(placeholder(), text: $query)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(12)
                    .foregroundColor(.black)
                
                Button {
                    showAlert = true
                } label: {
                    Text("Search")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            LinearGradient(colors: [.blue, .purple],
                                           startPoint: .leading,
                                           endPoint: .trailing)
                        )
                        .cornerRadius(12)
                }
                
                Spacer()
            }
            .padding()
        }
        
        .alert("Success", isPresented: $showAlert) {
            Button("OK") {}
        } message: {
            Text("Results will be shown shortly")
        }
    }
    
    func placeholder() -> String {
        if role == .student {
            return "Enter student / professor / assignment"
        } else {
            return "Enter student / professor / admin"
        }
    }
}
