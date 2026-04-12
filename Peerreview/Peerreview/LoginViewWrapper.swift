import SwiftUI

struct LoginViewWrapper: View {
    
    @State private var isLoggedIn = false
    @State private var role: UserRole = .student
    
    var body: some View {
        
        if isLoggedIn {
            
            switch role {
                
            case .student:
                HomeView(isLoggedIn: $isLoggedIn, role: $role)
                
            case .professor:
                HomeView(isLoggedIn: $isLoggedIn, role: $role)
                
            case .admin:
                HomeView(isLoggedIn: $isLoggedIn, role: $role)
            }
            
        } else {
            
            LoginView()
        }
    }
}
