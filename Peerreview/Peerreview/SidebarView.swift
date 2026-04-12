import SwiftUI

struct SidebarView: View {
    
    @EnvironmentObject var session: UserSession
    
    @Binding var isLoggedIn: Bool
    @Binding var selectedTab: String
    @Binding var role: UserRole
    
    @State private var showLogoutAlert = false
    
    var body: some View {
        
        ZStack(alignment: .leading) {
            
            Color.black.opacity(0.3)
                .ignoresSafeArea()
                .onTapGesture {
                    selectedTab = "home"
                }
            
            VStack(alignment: .leading, spacing: 20) {
                
                HStack(spacing: 12) {
                    
                    if let image = session.profileImage {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                    } else {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.purple)
                    }
                    
                    Text(session.userName.isEmpty ? roleTitle() : session.userName)
                        .font(.title2.bold())
                        .foregroundColor(.black)
                }
                .padding(.top, 50)
                
                Divider()
                
                menuItem("Home", "home")
                menuItem("Profile", "profile")
                menuItem("Search", "search")
                menuItem("Reviews", "reviews")
                menuItem("Templates", "templates")
                
                if role != .student {
                    Divider()
                    menuItem("Manage Students", "manageStudents")
                    menuItem("Manage Professors", "manageProfessors")
                    menuItem("Courses", "courses")
                }
                
                Spacer()
                
                Button {
                    showLogoutAlert = true
                } label: {
                    Text("Logout")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red)
                        .cornerRadius(10)
                }
            }
            .padding()
            .frame(width: 260)
            .background(Color.white)
        }
        
        .alert("Logout?", isPresented: $showLogoutAlert) {
            Button("Yes", role: .destructive) {
                isLoggedIn = false
            }
            Button("No", role: .cancel) {}
        }
    }
    
    func roleTitle() -> String {
        switch role {
        case .student: return "Student"
        case .professor: return "Professor"
        case .admin: return "Admin"
        }
    }
    
    func menuItem(_ title: String, _ tab: String) -> some View {
        Button {
            selectedTab = tab
        } label: {
            Text(title)
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.black)
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.gray.opacity(0.15))
                )
        }
    }
}
