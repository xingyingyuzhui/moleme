import SwiftUI
import SwiftData

struct SettingsView: View {
    @AppStorage("monthlySalary") private var monthlySalary: Double = 10000
    @AppStorage("workDays") private var workDays: Int = 22
    @AppStorage("workHours") private var workHours: Int = 8
    
    @Query(sort: \SlackingSession.startTime, order: .reverse) var sessions: [SlackingSession]
    
    private let backgroundGrey = Color(.sRGB, red: 242 / 255, green: 242 / 255, blue: 247 / 255, opacity: 1)
    private let surfaceWhite = Color(.sRGB, red: 1, green: 1, blue: 1, opacity: 1)
    private let primaryText = Color(.sRGB, red: 45 / 255, green: 45 / 255, blue: 45 / 255, opacity: 1)
    private let secondaryText = Color(.sRGB, red: 142 / 255, green: 142 / 255, blue: 147 / 255, opacity: 1)
    private let primaryPurple = Color(.sRGB, red: 163 / 255, green: 141 / 255, blue: 241 / 255, opacity: 1)
    
    var body: some View {
        ZStack {
            backgroundGrey
                .ignoresSafeArea()
            
            VStack(spacing: 24) {
                Text("薪资设置")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(primaryText)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 24)
                    .padding(.top, 20)
                
                VStack(spacing: 24) {
                    inputField(
                        title: "月薪 (元)",
                        value: Binding(
                            get: { monthlySalary },
                            set: { monthlySalary = $0 }
                        )
                    )
                    
                    Divider()
                        .background(Color(.sRGB, red: 229 / 255, green: 229 / 255, blue: 234 / 255, opacity: 1))
                    
                    inputField(
                        title: "每月工作天数",
                        value: Binding(
                            get: { Double(workDays) },
                            set: { workDays = Int($0) }
                        )
                    )
                    
                    Divider()
                        .background(Color(.sRGB, red: 229 / 255, green: 229 / 255, blue: 234 / 255, opacity: 1))
                    
                    inputField(
                        title: "每天工作小时",
                        value: Binding(
                            get: { Double(workHours) },
                            set: { workHours = Int($0) }
                        )
                    )
                }
                .padding(24)
                .background(surfaceWhite)
                .cornerRadius(32)
                .shadow(color: Color.black.opacity(0.06), radius: 20, x: 0, y: 15)
                .padding(.horizontal, 16)
                
                Spacer()
                
                VStack {
                    Divider()
                    Text("历史摸鱼次数: \(sessions.count)")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                .padding()
            }
        }
        .onChange(of: workDays) { _, newValue in
            if newValue > 31 { workDays = 31 }
            if newValue < 1 { workDays = 1 }
        }
        .onChange(of: workHours) { _, newValue in
            if newValue > 24 { workHours = 24 }
            if newValue < 1 { workHours = 1 }
        }
        .onChange(of: monthlySalary) { _, newValue in
            if newValue < 0 { monthlySalary = 0 }
        }
    }
    
    private func inputField(title: String, value: Binding<Double>) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(secondaryText)
            
            TextField("", value: value, format: .number)
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(primaryText)
        }
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3:
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6:
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8:
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

#Preview {
    SettingsView()
        .modelContainer(for: SlackingSession.self, inMemory: true)
}
