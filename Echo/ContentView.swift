import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        ZStack(alignment: .bottom) {
            // Content
            Group {
                switch selectedTab {
                case 0: ChatView()
                case 1: ConfigView()
                default: ChatView()
                }
            }
            
            // Custom floating tab bar
            HStack(spacing: 40) {
                TabButton(icon: "bubble.left.fill", label: "CHAT", isSelected: selectedTab == 0) {
                    selectedTab = 0
                }
                TabButton(icon: "gearshape.fill", label: "CONFIG", isSelected: selectedTab == 1) {
                    selectedTab = 1
                }
            }
            .padding(.horizontal, 32)
            .padding(.vertical, 12)
            .background(
                RoundedRectangle(cornerRadius: 24)
                    .fill(Color(hex: "1a1815"))
                    .shadow(color: .black.opacity(0.3), radius: 16, x: 0, y: -4)
                    .shadow(color: Color(hex: "2a2520").opacity(0.5), radius: 4, x: 0, y: -1)
            )
            .padding(.bottom, 20)
        }
        .ignoresSafeArea(.keyboard)
    }
}

struct TabButton: View {
    let icon: String
    let label: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                Image(systemName: icon)
                    .font(.system(size: 18, weight: .medium))
                Text(label)
                    .font(.system(size: 9, weight: .medium))
                    .kerning(2)
            }
            .foregroundColor(isSelected ? Color(hex: "c9a96e") : Color(hex: "5a5550"))
        }
    }
}

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        self.init(
            red: Double((rgbValue >> 16) & 0xFF) / 255,
            green: Double((rgbValue >> 8) & 0xFF) / 255,
            blue: Double(rgbValue & 0xFF) / 255
        )
    }
}
