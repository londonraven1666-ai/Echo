import SwiftUI
import WebKit

struct ChatView: View {
    var body: some View {
        GatewayWebView(url: "https://altairaquila-hafen.duckdns.org/hafen/")
            .ignoresSafeArea(edges: [.bottom, .horizontal])
    }
}

struct GatewayWebView: UIViewRepresentable {
    let url: String
    
    func makeUIView(context: Context) -> WKWebView {
        let config = WKWebViewConfiguration()
        config.allowsInlineMediaPlayback = true
        
        // Force clear all cache
        let dataStore = WKWebsiteDataStore.default()
        dataStore.removeData(
            ofTypes: WKWebsiteDataStore.allWebsiteDataTypes(),
            modifiedSince: Date.distantPast
        ) {}
        config.websiteDataStore = dataStore
        
        let webView = WKWebView(frame: .zero, configuration: config)
        webView.isOpaque = false
        webView.backgroundColor = UIColor(red: 0.055, green: 0.047, blue: 0.039, alpha: 1)
        webView.scrollView.contentInsetAdjustmentBehavior = .always
        
        // Cache-busting URL
        let ts = Int(Date().timeIntervalSince1970)
        if let u = URL(string: "\(url)?_t=\(ts)") {
            let req = URLRequest(url: u, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData)
            webView.load(req)
        }
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {}
}
