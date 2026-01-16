import Foundation
import SwiftUI
import Combine
import SwiftData

@MainActor
class SessionManager: ObservableObject {
    @Published var currentEarnings: Double = 0
    @Published var duration: TimeInterval = 0
    @Published var isRunning: Bool = false
    
    private var backgroundTimestamp: Date?
    private var timerCancellable: AnyCancellable?
    private var salaryPerSecond: Double = 0
    
    func updateSettings(salary: Double, days: Int, hours: Int) {
        salaryPerSecond = SalaryCalculator(
            monthlySalary: salary,
            workDays: days,
            workHours: hours
        ).perSecond
    }
    
    func start() {
        guard !isRunning else { return }
        isRunning = true
        timerCancellable = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.tick()
            }
    }
    
    private func tick() {
        currentEarnings += salaryPerSecond
        duration += 1
    }
    
    func pause() {
        isRunning = false
        timerCancellable?.cancel()
        timerCancellable = nil
    }
    
    func reset(context: ModelContext?) {
        pause()
        
        if currentEarnings > 0, let context = context {
            let startTime = Date().addingTimeInterval(-duration)
            let session = SlackingSession(startTime: startTime, earnings: currentEarnings)
            session.endTime = Date()
            context.insert(session)
            try? context.save()
        }
        
        currentEarnings = 0
        duration = 0
    }
    
    func handleScenePhase(_ phase: ScenePhase) {
        switch phase {
        case .background, .inactive:
            if isRunning {
                backgroundTimestamp = Date()
            }
        case .active:
            if let timestamp = backgroundTimestamp, isRunning {
                let elapsed = Date().timeIntervalSince(timestamp)
                currentEarnings += elapsed * salaryPerSecond
                duration += elapsed
                backgroundTimestamp = nil
            }
        @unknown default:
            break
        }
    }
}
