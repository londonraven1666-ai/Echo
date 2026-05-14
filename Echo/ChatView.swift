import SwiftUI
import WebKit

struct ChatView: View {
    var body: some View {
        GatewayWebView(url: "https://altairaquila-hafen.duckdns.org/hafen/")
    }
}

struct GatewayWebView: UIViewRepresentable {
    let url: String
    
    func makeCoordinator() -> Coordinator { Coordinator() }
    
    func makeUIView(context: Context) -> WKWebView {
        let config = WKWebViewConfiguration()
        config.allowsInlineMediaPlayback = true
        let webView = WKWebView(frame: .zero, configuration: config)
        webView.navigationDelegate = context.coordinator
        webView.isOpaque = false
        webView.backgroundColor = UIColor(red: 0.055, green: 0.047, blue: 0.039, alpha: 1)
        
        let ts = Int(Date().timeIntervalSince1970)
        if let u = URL(string: "\(url)?_t=\(ts)") {
            webView.load(URLRequest(url: u, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData))
        }
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {}
    
    class Coordinator: NSObject, WKNavigationDelegate {
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            let css = """
            :root, html[data-theme="dark"] {
                --card: #1a1714 !important;
                --card-h: #201c18 !important;
                --nav: #0e0c0a !important;
                --bubble-ai: #1a1714 !important;
            }
            body { background: #0e0c0a !important; }
            .glass, .glass-sm {
                background: #1a1714 !important;
                backdrop-filter: none !important;
                -webkit-backdrop-filter: none !important;
                box-shadow: 3px 3px 8px rgba(0,0,0,0.5), -2px -2px 6px rgba(50,44,36,0.12) !important;
            }
            .glass-nav {
                background: #0e0c0a !important;
                backdrop-filter: none !important;
                -webkit-backdrop-filter: none !important;
                box-shadow: 0 -3px 12px rgba(0,0,0,0.4) !important;
            }
            .bubble-a {
                background: #1a1714 !important;
                backdrop-filter: none !important;
                -webkit-backdrop-filter: none !important;
                box-shadow: 2px 2px 8px rgba(0,0,0,0.4), -1px -1px 4px rgba(50,44,36,0.1) !important;
            }
            .bubble-u {
                background: rgba(196,168,130,0.08) !important;
                backdrop-filter: none !important;
                -webkit-backdrop-filter: none !important;
            }
            """
            let escaped = css.replacingOccurrences(of: "\\n", with: "").replacingOccurrences(of: "\"", with: "\\\"")
            let js = "var s=document.createElement('style');s.textContent=\"\(escaped)\";document.head.appendChild(s);"
            webView.evaluateJavaScript(js)
        }
    }
}
