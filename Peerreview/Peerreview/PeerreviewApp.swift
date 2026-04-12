import SwiftUI   //

@main
struct PeerreviewApp: App {
    
    @StateObject var session = UserSession()
    
    var body: some Scene {
        WindowGroup {
            SplashView()
                .environmentObject(session) // 
        }
    }
}
