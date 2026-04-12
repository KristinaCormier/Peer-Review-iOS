import SwiftUI

struct CreateReviewView: View {
    
    @State private var assignmentName = ""
    @State private var reviewText = ""
    @State private var rating = 0
    
    @State private var showAlert = false
    
    var body: some View {
        
        ZStack {
            
         
            LinearGradient(
                colors: [Color.pink, Color.purple, Color.blue],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            ScrollView {
                
                VStack(spacing: 25) {
                    
                    Text("Create Review")
                        .font(.largeTitle.bold())
                        .foregroundColor(.white)
                    
              
                    card {
                        TextField("Assignment Name", text: $assignmentName)
                    }
                    
                   
                    card {
                        TextEditor(text: $reviewText)
                            .frame(height: 120)
                    }
                    
                    // ⭐ STARS
                    HStack(spacing: 15) {
                        ForEach(1...5, id: \.self) { i in
                            Image(systemName: i <= rating ? "star.fill" : "star")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.yellow)
                                .onTapGesture {
                                    rating = i
                                }
                        }
                    }
                    
                  
                    Button("Submit Review") {
                        showAlert = true
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.black)
                    .foregroundColor(.white)
                    .cornerRadius(15)
                    .shadow(radius: 5)
                    
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
    
   
    func card<Content: View>(@ViewBuilder content: () -> Content) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white.opacity(0.95))
                .shadow(radius: 8)
            
            content()
                .padding()
                .foregroundColor(.black)
        }
    }
}
