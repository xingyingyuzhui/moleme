import SwiftUI
import SwiftData
#if canImport(UIKit)
import UIKit
#endif

struct HomeView: View {
    @EnvironmentObject var session: SessionManager
    @Environment(\.modelContext) private var modelContext
    
    @AppStorage("monthlySalary") private var monthlySalary: Double = 10000
    @AppStorage("workDays") private var workDays: Int = 22
    @AppStorage("workHours") private var workHours: Int = 8
    
    private let coralColor = Color(red: 238/255, green: 109/255, blue: 102/255)
    private let lavenderColor = Color(red: 163/255, green: 135/255, blue: 224/255)
    private let backgroundColor = Color(red: 245/255, green: 245/255, blue: 245/255)
    private let cardShadowColor = Color.black.opacity(0.05)
    
    var body: some View {
        ZStack {
            backgroundColor
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Text("摸鱼计时器")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(Color(red: 51/255, green: 51/255, blue: 51/255))
                    .padding(.top, 10)
                
                VStack(spacing: 0) {
                    HStack {
                        Spacer()
                        Button(action: resetTimer) {
                            Image(systemName: "arrow.counterclockwise")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(coralColor)
                                .frame(width: 40, height: 40)
                                .background(coralColor.opacity(0.1))
                                .clipShape(Circle())
                        }
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 24)
                    
                    Spacer()
                    
                    VStack(spacing: 16) {
                        Text(String(format: "%.4f", session.currentEarnings))
                            .font(.system(size: 72, weight: .bold, design: .rounded))
                            .foregroundColor(coralColor)
                            .minimumScaleFactor(0.5)
                            .lineLimit(1)
                            .padding(.horizontal)
                        
                        Text("本场摸鱼收入 (元)")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.gray)
                    }
                    
                    Spacer()
                    
                    if session.isRunning {
                        HStack(spacing: 6) {
                            Text("💪")
                            Text("正在努力摸鱼中...")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.gray)
                        }
                        .padding(.vertical, 8)
                        .padding(.horizontal, 16)
                        .background(Color(red: 240/255, green: 240/255, blue: 240/255))
                        .cornerRadius(20)
                        .padding(.bottom, 30)
                    } else {
                        Color.clear.frame(height: 44)
                            .padding(.bottom, 30)
                    }
                    
                    Button(action: toggleTimer) {
                        HStack {
                            Image(systemName: session.isRunning ? "pause.fill" : "play.fill")
                            Text(session.isRunning ? "暂停摸鱼" : "开始摸鱼")
                        }
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .background(session.isRunning ? lavenderColor : coralColor)
                        .cornerRadius(28)
                        .shadow(color: (session.isRunning ? lavenderColor : coralColor).opacity(0.3), radius: 10, x: 0, y: 5)
                    }
                    .padding(.horizontal, 24)
                    .padding(.bottom, 32)
                }
                .background(Color.white)
                .cornerRadius(32)
                .shadow(color: cardShadowColor, radius: 20, x: 0, y: 10)
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
                .aspectRatio(0.8, contentMode: .fit)
                
                Spacer()
            }
        }
        .onAppear {
            updateSessionSettings()
        }
        .onChange(of: monthlySalary) { _, _ in updateSessionSettings() }
        .onChange(of: workDays) { _, _ in updateSessionSettings() }
        .onChange(of: workHours) { _, _ in updateSessionSettings() }
    }
    
    private func updateSessionSettings() {
        session.updateSettings(salary: monthlySalary, days: workDays, hours: workHours)
    }
    
    private func toggleTimer() {
        #if canImport(UIKit)
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
        #endif
        
        if session.isRunning {
            session.pause()
        } else {
            session.start()
        }
    }
    
    private func resetTimer() {
        #if canImport(UIKit)
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
        #endif
        session.reset(context: modelContext)
    }
}

#Preview {
    HomeView()
        .environmentObject(SessionManager())
}
