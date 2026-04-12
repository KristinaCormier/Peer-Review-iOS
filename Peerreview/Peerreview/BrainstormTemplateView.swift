import SwiftUI

struct BrainstormTemplateView: View {
    
    var body: some View {
        
        ZStack {
            
            LinearGradient(colors: [.pink, .purple], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                
                Text("Brainstorming Template")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                
                Text("Add your ideas here...")
                    .foregroundColor(.white.opacity(0.8))
                
                Spacer()
            }
            .padding()
        }
    }
}
