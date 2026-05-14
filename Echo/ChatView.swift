import SwiftUI
import WebKit

struct ChatView: View {
    var body: some View {
        GatewayWebView(url: "https://altairaquila-hafen.duckdns.org/hafen/")
    }
}

struct GatewayWebView: UIViewRepresentable {
    let url: String
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.backgroundColor = UIColor(red: 0.055, green: 0.047, blue: 0.039, alpha: 1)
        if let u = URL(string: url) {
            webView.load(URLRequest(url: u))
        }
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {}
}
