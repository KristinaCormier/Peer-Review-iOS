import SwiftUI

struct PastAssignmentView: View {
    
    @State private var assignmentName = ""
    @State private var selectedDate = Date()
    @State private var showAlert = false
    
    var body: some View {
        
        ZStack {
            
            LinearGradient(colors: [.blue, .purple], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                
                Text("Past Assignments")
                    .font(.title.bold())
                    .foregroundColor(.white)
                
                TextField("Assignment Name", text: $assignmentName)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(12)
                
                DatePicker("Select Date", selection: $selectedDate, displayedComponents: .date)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(12)
                
                Button {
                    showAlert = true
                } label: {
                    Text("Submit")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .cornerRadius(12)
                }
                
                Spacer()
            }
            .padding()
        }
        
        .alert("Success", isPresented: $showAlert) {
            Button("OK") {}
        } message: {
            Text("Assignment fetched successfully")
        }
    }
}
