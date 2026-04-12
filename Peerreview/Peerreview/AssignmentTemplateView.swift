import SwiftUI

struct AssignmentTemplateView: View {
    
    var body: some View {
        
        ZStack {
            
            LinearGradient(colors: [.blue, .purple], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                
                Text("Assignment Template")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                
                Text("Write your assignment here...")
                    .foregroundColor(.white.opacity(0.8))
                
                Spacer()
            }
            .padding()
        }
    }
}
