import SwiftUI

struct MyReviewsView: View {
    
    @State private var studentName = ""
    @State private var professorName = ""
    @State private var assignmentName = ""
    @State private var selectedDate = Date()
    @State private var rating = 3
    @State private var showAlert = false
    
    var body: some View {
        
        ZStack {
            
            LinearGradient(colors: [.pink, .purple],
                           startPoint: .top,
                           endPoint: .bottom)
            .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 25) {
                    
            
                    Text("Reviews Panel")
                        .font(.system(size: 34, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.top)
                    
                    VStack(spacing: 18) {
                        
                        
                        field("Enter Student Name", text: $studentName)
                        
                       
                        field("Enter Professor Name", text: $professorName)
                        
                       
                        field("Enter Assignment Name", text: $assignmentName)
                        
                    
                        HStack {
                            Image(systemName: "calendar")
                                .foregroundColor(.blue)
                            
                            DatePicker(
                                "",
                                selection: $selectedDate,
                                displayedComponents: .date
                            )
                            .labelsHidden()
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(12)
                        
                      
                        HStack(spacing: 12) {
                            ForEach(1...5, id: \.self) { star in
                                Image(systemName: star <= rating ? "star.fill" : "star")
                                    .foregroundColor(.yellow)
                                    .font(.title2)
                                    .onTapGesture {
                                        rating = star
                                    }
                            }
                        }
                        .padding(.vertical, 5)
                        
                      
                        Button {
                            showAlert = true
                        } label: {
                            Text("Check Review")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(
                                    LinearGradient(
                                        colors: [.blue, .purple],
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                                .cornerRadius(12)
                        }
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 25)
                            .fill(Color.white)
                            .shadow(color: .black.opacity(0.2), radius: 8)
                    )
                    .padding(.horizontal)
                }
            }
        }
        
      
        .alert("Success", isPresented: $showAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("Review fetched successfully.")
        }
    }
    
  
    func field(_ placeholder: String, text: Binding<String>) -> some View {
        TextField(placeholder, text: text)
            .padding()
            .background(Color.white)
            .cornerRadius(12)
            .foregroundColor(.black)
            .font(.headline)
    }
}
