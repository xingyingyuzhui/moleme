import SwiftUI

struct ShareCardView: View {
    let earnings: Double
    let duration: TimeInterval
    
    private let backgroundGrey = Color(.sRGB, red: 242/255, green: 242/255, blue: 247/255, opacity: 1)
    private let surfaceWhite = Color.white
    private let coralRed = Color(.sRGB, red: 231/255, green: 111/255, blue: 111/255, opacity: 1)
    private let primaryPurple = Color(.sRGB, red: 163/255, green: 141/255, blue: 241/255, opacity: 1)
    private let primaryText = Color(.sRGB, red: 45/255, green: 45/255, blue: 45/255, opacity: 1)
    private let secondaryText = Color(.sRGB, red: 142/255, green: 142/255, blue: 147/255, opacity: 1)
    
    private var formattedEarnings: String {
        String(format: "%.2f", earnings)
    }
    
    private var formattedDuration: String {
        let hours = Int(duration) / 3600
        let minutes = (Int(duration) % 3600) / 60
        if hours > 0 {
            return "\(hours)小时\(minutes)分钟"
        } else {
            return "\(minutes)分钟"
        }
    }
    
    var body: some View {
        VStack(spacing: 24) {
            VStack(spacing: 20) {
                Circle()
                    .fill(coralRed.opacity(0.1))
                    .frame(width: 60, height: 60)
                    .overlay(
                        Image(systemName: "dollarsign.circle.fill")
                            .font(.system(size: 30))
                            .foregroundColor(coralRed)
                    )
                
                Text("¥\(formattedEarnings)")
                    .font(.system(size: 64, weight: .bold, design: .rounded))
                    .foregroundColor(coralRed)
                
                VStack(spacing: 8) {
                    Text("今日摸鱼收益 💰")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(primaryText)
                    
                    Text("摸鱼时长: \(formattedDuration)")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(secondaryText)
                }
                
                HStack(spacing: 4) {
                    Text("💪")
                    Text("加油打工人!")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(secondaryText)
                    Text("👊")
                }
                .padding(.top, 8)
                
                HStack(spacing: 6) {
                    Image(systemName: "apple.logo")
                        .font(.system(size: 12))
                    Text("摸了么 App")
                        .font(.system(size: 12, weight: .medium))
                }
                .foregroundColor(secondaryText.opacity(0.6))
                .padding(.top, 16)
            }
            .padding(32)
            .background(surfaceWhite)
            .cornerRadius(32)
            .shadow(color: Color.black.opacity(0.06), radius: 20, x: 0, y: 15)
        }
        .padding(24)
        .background(backgroundGrey)
    }
}

struct ShareCardContainerView: View {
    @EnvironmentObject var session: SessionManager
    @State private var showingShareSheet = false
    @State private var shareImage: UIImage?
    
    private let primaryPurple = Color(.sRGB, red: 163/255, green: 141/255, blue: 241/255, opacity: 1)
    
    var body: some View {
        VStack(spacing: 24) {
            ShareCardView(earnings: session.currentEarnings, duration: session.duration)
            
            Button(action: generateAndShare) {
                HStack(spacing: 8) {
                    Image(systemName: "square.and.arrow.up")
                    Text("分享战绩")
                        .font(.system(size: 18, weight: .bold))
                }
                .foregroundColor(primaryPurple)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background(primaryPurple.opacity(0.1))
                .cornerRadius(16)
            }
            .padding(.horizontal, 24)
        }
        .sheet(isPresented: $showingShareSheet) {
            if let image = shareImage {
                ShareSheet(items: [image])
            }
        }
    }
    
    private func generateAndShare() {
        let renderer = ImageRenderer(content: ShareCardView(earnings: session.currentEarnings, duration: session.duration))
        renderer.scale = 3.0
        
        if let image = renderer.uiImage {
            shareImage = image
            showingShareSheet = true
        }
        
        let impactFeedback = UIImpactFeedbackGenerator(style: .medium)
        impactFeedback.impactOccurred()
    }
}

struct ShareSheet: UIViewControllerRepresentable {
    let items: [Any]
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        UIActivityViewController(activityItems: items, applicationActivities: nil)
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}

#Preview {
    ShareCardContainerView()
        .environmentObject(SessionManager())
}
