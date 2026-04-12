import SwiftUI

struct SplashView: View {
    
    @State private var isActive = false
    @State private var scale: CGFloat = 0.7
    @State private var glow: CGFloat = 0
    @State private var textGlow: CGFloat = 0
    
    var body: some View {
        
        if isActive {
            LoginViewWrapper()
        } else {
            ZStack {
                
                LinearGradient(
                    colors: [Color.pink, Color.purple],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
                
                VStack(spacing: 30) {
                    
                    Spacer()
                    
                 
                    Image("logo_icon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 240, height: 240) // 🔥 BIGGER
                        .scaleEffect(scale)
                        .shadow(color: .white.opacity(1), radius: glow)
                        .shadow(color: .pink.opacity(1), radius: glow)
                        .shadow(color: .purple.opacity(1), radius: glow)
                    
                
                    Text("Peer Review")
                        .font(.system(size: 48, weight: .heavy))
                        .foregroundColor(.white)
                        .shadow(color: .white.opacity(1), radius: textGlow)
                        .shadow(color: .pink.opacity(0.9), radius: textGlow)
                        .shadow(color: .purple.opacity(0.9), radius: textGlow)
                    
                   
                    Text("Grow together. Review together.")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.white.opacity(0.95))
                        .shadow(color: .white.opacity(0.8), radius: 8)
                    
                    Spacer()
                }
            }
            .onAppear {
                
            
                withAnimation(.easeInOut(duration: 1.2)) {
                    scale = 1.1
                    glow = 35
                }
                
               
                withAnimation(.easeInOut(duration: 1.5).delay(0.3)) {
                    textGlow = 20
                }
                
              
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                    isActive = true
                }
            }
        }
    }
}
