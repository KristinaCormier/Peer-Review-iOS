import SwiftUI

struct HomeView: View {
    
    @Binding var isLoggedIn: Bool
    @Binding var role: UserRole
    
    @State private var showMenu = false
    @State private var selectedTab = "home"
    
    let courses = [
        Course(title: "COSC 404", code: "C404"),
        Course(title: "COSC 470", code: "C470"),
        Course(title: "COSC 360", code: "C360")
    ]
    
    var body: some View {
        
        NavigationStack {
            
            ZStack {
                
                LinearGradient(
                    colors: [Color.pink, Color.purple],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
                
                VStack {
                    
                    HStack {
                        Button {
                            withAnimation { showMenu.toggle() }
                        } label: {
                            Image(systemName: "line.3.horizontal")
                                .foregroundColor(.white)
                                .font(.title)
                        }
                        
                        Spacer()
                        
                        Text("Dashboard")
                            .font(.title2.bold())
                            .foregroundColor(.white)
                        
                        Spacer()
                    }
                    .padding()
                    
                   
                    ScrollView {
                        VStack(spacing: 20) {
                            
                            ForEach(courses) { course in
                                NavigationLink(value: course) {
                                    CourseCardView(title: course.title, code: course.code)
                                }
                            }
                        }
                        .padding()
                    }
                }
                
                if showMenu {
                    SidebarView(
                        isLoggedIn: $isLoggedIn,
                        selectedTab: $selectedTab,
                        role: $role
                    )
                    .onChange(of: selectedTab) { _ in
                        showMenu = false
                    }
                    .transition(.move(edge: .leading))
                }
            }
            
            
            .navigationDestination(for: Course.self) { _ in
                CourseDetailView()
            }
            
            .navigationDestination(isPresented: Binding(
                get: { selectedTab == "profile" },
                set: { _ in }
            )) {
                ProfileView()
            }
            
            .navigationDestination(isPresented: Binding(
                get: { selectedTab == "search" },
                set: { _ in }
            )) {
                SearchView(role: role)
            }
            
            .navigationDestination(isPresented: Binding(
                get: { selectedTab == "reviews" },
                set: { _ in }
            )) {
                MyReviewsView()
            }
            
            .navigationDestination(isPresented: Binding(
                get: { selectedTab == "templates" },
                set: { _ in }
            )) {
                TemplatesView(role: role)
            }
            
            .navigationDestination(isPresented: Binding(
                get: { selectedTab == "manageStudents" },
                set: { _ in }
            )) {
                ManageStudentsView()
            }
            
            .navigationDestination(isPresented: Binding(
                get: { selectedTab == "manageProfessors" },
                set: { _ in }
            )) {
                ManageProfessorsView()
            }
            
            .navigationDestination(isPresented: Binding(
                get: { selectedTab == "courses" },
                set: { _ in }
            )) {
                AdminCoursesView()
            }
        }
    }
}
