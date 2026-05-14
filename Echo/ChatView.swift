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
        let config = WKWebViewConfiguration()
        config.allowsInlineMediaPlayback = true
        
        let webView = WKWebView(frame: .zero, configuration: config)
        webView.isOpaque = false
        webView.backgroundColor = UIColor(red: 0.055, green: 0.047, blue: 0.039, alpha: 1)
        
        // Clear ALL cache before loading
        WKWebsiteDataStore.default().removeData(
            ofTypes: WKWebsiteDataStore.allWebsiteDataTypes(),
            modifiedSince: .distantPast
        ) {
            let ts = Int(Date().timeIntervalSince1970)
            if let u = URL(string: "\(self.url)?_t=\(ts)") {
                let req = URLRequest(url: u, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData)
                webView.load(req)
            }
        }
        
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {}
}
