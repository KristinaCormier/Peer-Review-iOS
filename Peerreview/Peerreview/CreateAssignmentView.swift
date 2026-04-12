import SwiftUI

struct CreateAssignmentView: View {
    
    @State private var showTemplate = false
    
    var body: some View {
        
        ZStack {
            
     
            LinearGradient(
                colors: [Color.pink, Color.purple, Color.blue],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            VStack(spacing: 30) {
                
                Text("Create Assignment")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                
              
                Button {
                    showTemplate = true
                } label: {
                    Text("Choose Template")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.ultraThinMaterial)
                        .cornerRadius(15)
                        .foregroundColor(.black)
                }
                
                Spacer()
            }
            .padding()
        }
        
       
        .navigationDestination(isPresented: $showTemplate) {
            TemplatesView(role: .student)
        }
    }
}
