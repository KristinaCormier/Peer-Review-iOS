import SwiftUI

struct AssignmentHubView: View {
    
    @State private var showUpload = false
    @State private var showUpcoming = false
    @State private var showPast = false
    @State private var showReview = false
    
    var body: some View {
        
        NavigationStack {
            
            ZStack {
                
                LinearGradient(colors: [.purple, .blue], startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    
                    Text("Assignments")
                        .font(.largeTitle.bold())
                        .foregroundColor(.white)
                    
                    actionCard("Upload Assignment", icon: "square.and.arrow.up.fill") {
                        showUpload = true
                    }
                    
                    actionCard("Upcoming Assignments", icon: "calendar") {
                        showUpcoming = true
                    }
                    
                    actionCard("Past Assignments", icon: "clock.fill") {
                        showPast = true
                    }
                    
                    actionCard("Reviews", icon: "star.fill") {
                        showReview = true
                    }
                    
                    Spacer()
                }
                .padding()
            }
            
            .navigationDestination(isPresented: $showUpload) {
                UploadAssignmentView()
            }
            
            .navigationDestination(isPresented: $showUpcoming) {
                UpcomingAssignmentView()
            }
            
            .navigationDestination(isPresented: $showPast) {
                PastAssignmentView()
            }
            
            .navigationDestination(isPresented: $showReview) {
                ReviewView()
            }
        }
    }
    
    func actionCard(_ title: String, icon: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            HStack {
                Image(systemName: icon)
                Text(title)
                    .font(.headline)
            }
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity)
            .background(
                LinearGradient(colors: [.pink, .purple], startPoint: .leading, endPoint: .trailing)
            )
            .cornerRadius(12)
        }
    }
}
