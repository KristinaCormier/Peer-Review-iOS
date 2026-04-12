import SwiftUI

struct CourseDetailView: View {
    
    @State private var showUpload = false
    @State private var showReview = false
    @State private var showPast = false
    @State private var showUpcoming = false
    
    var body: some View {
        
        ZStack {
            
            LinearGradient(colors: [.purple, .blue], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack(spacing: 25) {
                
                Text("Course Details")
                    .font(.title.bold())
                    .foregroundColor(.white)
                
                featureCard(
                    title: "Upload Assignment",
                    icon: "arrow.up.doc.fill",
                    colors: [.orange, .red]
                ) {
                    showUpload = true
                }
                
                featureCard(
                    title: "Reviews",
                    icon: "star.fill",
                    colors: [.pink, .purple]
                ) {
                    showReview = true
                }
                
                featureCard(
                    title: "Past Assignments",
                    icon: "clock.arrow.circlepath",
                    colors: [.blue, .cyan]
                ) {
                    showPast = true
                }
                
                featureCard(
                    title: "Upcoming Assignments",
                    icon: "calendar",
                    colors: [.green, .mint]
                ) {
                    showUpcoming = true
                }
                
                Spacer()
            }
            .padding()
        }
        
        .navigationDestination(isPresented: $showUpload) {
            UploadAssignmentView()
        }
        
        .navigationDestination(isPresented: $showReview) {
            CreateReviewView()
        }
        
        .navigationDestination(isPresented: $showPast) {
            PastAssignmentView()
        }
        
        .navigationDestination(isPresented: $showUpcoming) {
            UpcomingAssignmentView()
        }
    }
    
    func featureCard(
        title: String,
        icon: String,
        colors: [Color],
        action: @escaping () -> Void
    ) -> some View {
        
        Button(action: action) {
            HStack {
                Image(systemName: icon)
                    .font(.title2)
                Text(title)
                    .font(.headline.bold())
            }
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity)
            .background(
                LinearGradient(colors: colors, startPoint: .leading, endPoint: .trailing)
            )
            .cornerRadius(20)
            .shadow(radius: 8)
        }
    }
}
