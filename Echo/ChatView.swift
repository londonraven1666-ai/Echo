import SwiftUI
import WebKit

struct ChatView: View {
    var body: some View {
        ZStack {
            Color(hex: "0e0c0a").ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Header
                HStack {
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Echo")
                            .font(.system(size: 22, weight: .light))
                            .kerning(4)
                            .foregroundColor(Color(hex: "c9a96e"))
                        Text("Altair")
                            .font(.system(size: 10, weight: .regular))
                            .kerning(2)
                            .foregroundColor(Color(hex: "5a5550"))
                    }
                    Spacer()
                    Circle()
                        .fill(Color(hex: "1a1815"))
                        .frame(width: 32, height: 32)
                        .overlay(
                            Text("🐙")
                                .font(.system(size: 14))
                        )
                        .shadow(color: .black.opacity(0.2), radius: 4, x: 0, y: 2)
                }
                .padding(.horizontal, 20)
                .padding(.top, 12)
                .padding(.bottom, 8)
                
                // WebView
                GatewayWebView(url: "https://altairaquila-hafen.duckdns.org/hafen/")
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .padding(.horizontal, 8)
                    .padding(.bottom, 80)
            }
        }
    }
}

struct GatewayWebView: UIViewRepresentable {
    let url: String
    
    func makeUIView(context: Context) -> WKWebView {
        let config = WKWebViewConfiguration()
        config.allowsInlineMediaPlayback = true
        let webView = WKWebView(frame: .zero, configuration: config)
        webView.isOpaque = false
        webView.backgroundColor = .clear
        webView.scrollView.backgroundColor = .clear
        if let u = URL(string: url) {
            webView.load(URLRequest(url: u))
        }
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {}
}
