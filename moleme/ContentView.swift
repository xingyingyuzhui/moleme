import SwiftUI

struct ContentView: View {
    @EnvironmentObject var session: SessionManager
    @State private var isBossKeyActive = false
    
    var body: some View {
        ZStack {
            TabView {
                HomeView()
                    .tabItem {
                        Label("摸鱼", systemImage: "timer")
                    }
                
                ShareCardContainerView()
                    .tabItem {
                        Label("分享", systemImage: "square.and.arrow.up")
                    }
                
                SettingsView()
                    .tabItem {
                        Label("设置", systemImage: "gear")
                    }
            }
            .tint(Color(red: 163/255, green: 141/255, blue: 241/255))
            .onTapGesture(count: 2) {
                withAnimation(.easeInOut(duration: 0.15)) {
                    isBossKeyActive = true
                }
                let impactFeedback = UIImpactFeedbackGenerator(style: .heavy)
                impactFeedback.impactOccurred()
            }
            
            if isBossKeyActive {
                BossKeyView(isActive: $isBossKeyActive)
                    .transition(.opacity)
                    .zIndex(100)
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(SessionManager())
}
