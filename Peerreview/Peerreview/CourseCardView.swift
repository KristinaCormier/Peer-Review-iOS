import SwiftUI

struct CourseCardView: View {
    
    var title: String
    var code: String
    
    var body: some View {
        
        ZStack {
            
            RoundedRectangle(cornerRadius: 20)
                .fill(
                    LinearGradient(
                        colors: [Color.blue, Color.purple, Color.pink],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .shadow(radius: 8)
            
            VStack(spacing: 10) {
                
                Text(title)
                    .font(.headline)
                    .foregroundColor(.white)
                
                Text(code)
                    .foregroundColor(.white.opacity(0.9))
                
            }
        }
        .frame(height: 120)
    }
}
