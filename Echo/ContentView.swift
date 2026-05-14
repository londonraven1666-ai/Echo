import SwiftUI

struct ContentView: View {
    @State private var showConfig = false
    
    var body: some View {
        ZStack {
            ChatView()
            
            // Floating config button - top right
            VStack {
                HStack {
                    Spacer()
                    Button(action: { showConfig = true }) {
                        Image(systemName: "gearshape")
                            .font(.system(size: 15, weight: .medium))
                            .foregroundColor(Color(hex: "c9a96e"))
                            .frame(width: 36, height: 36)
                            .background(
                                Circle()
                                    .fill(Color(hex: "1a1714"))
                                    .shadow(color: .black.opacity(0.3), radius: 6, x: 2, y: 2)
                                    .shadow(color: Color(hex: "2a2520").opacity(0.3), radius: 4, x: -1, y: -1)
                            )
                    }
                    .padding(.trailing, 16)
                    .padding(.top, 54)
                }
                Spacer()
            }
        }
        .sheet(isPresented: $showConfig) {
            ConfigSheet()
        }
    }
}

struct ConfigSheet: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            ConfigWebView(url: "https://altairaquila-hafen.duckdns.org/gateway/config")
                .navigationTitle("Gateway")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Done") { dismiss() }
                            .foregroundColor(Color(hex: "c9a96e"))
                    }
                }
        }
    }
}

struct ConfigWebView: UIViewRepresentable {
    let url: String
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        if let u = URL(string: url) {
            webView.load(URLRequest(url: u))
        }
        return webView
    }
    func updateUIView(_ uiView: WKWebView, context: Context) {}
}

import WebKit

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
