import SwiftUI

struct UpcomingAssignmentView: View {
    
    @State private var selectedDate = Date()
    @State private var showAlert = false
    
    var body: some View {
        
        ZStack {
            
            LinearGradient(colors: [.green, .blue], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                
                Text("Upcoming Assignments")
                    .font(.title.bold())
                    .foregroundColor(.white)
                
                DatePicker("Select Date", selection: $selectedDate, displayedComponents: .date)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(12)
                
                Button("Fetch") {
                    showAlert = true
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.orange)
                .cornerRadius(12)
                .foregroundColor(.white)
                
                Spacer()
            }
            .padding()
        }
        .alert("Success", isPresented: $showAlert) {
            Button("OK") {}
        } message: {
            Text("Upcoming assignments fetched successfully")
        }
    }
}
