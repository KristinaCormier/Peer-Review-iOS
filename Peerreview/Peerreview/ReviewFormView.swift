import SwiftUI

struct ReviewFormView: View {
    
    @State private var assignmentName = ""
    @State private var reviewText = ""
    @State private var selectedDate = Date()
    
    @State private var rating = 0
    
    @State private var showAlert = false
    
    var body: some View {
        
        ZStack {
            
            LinearGradient(
                colors: [Color.pink, Color.purple],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 20) {
                    
                    Text("Submit Review")
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
                    
                   
                    TextEditor(text: $reviewText)
                        .frame(height: 120)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(12)
                    
                 
                    HStack {
                        ForEach(1...5, id: \.self) { star in
                            Image(systemName: star <= rating ? "star.fill" : "star")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.yellow)
                                .onTapGesture {
                                    rating = star
                                }
                        }
                    }
                    
                  
                    Button {
                        showAlert = true
                    } label: {
                        Text("Submit Review")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                    
                }
                .padding()
            }
        }
        .alert("Success", isPresented: $showAlert) {
            Button("OK") {}
        } message: {
            Text("Review submitted successfully")
        }
    }
}
