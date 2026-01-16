import SwiftUI
import SwiftData

@main
struct molemeApp: App {
    @StateObject private var session = SessionManager()
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(session)
        }
        .modelContainer(for: SlackingSession.self)
        .onChange(of: scenePhase) { _, newPhase in
            session.handleScenePhase(newPhase)
        }
    }
}
