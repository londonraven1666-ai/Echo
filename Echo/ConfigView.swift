import SwiftUI
import WebKit

struct ConfigView: View {
    var body: some View {
        ZStack {
            Color(hex: "0e0c0a").ignoresSafeArea()
            
            VStack(spacing: 0) {
                HStack {
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Config")
                            .font(.system(size: 22, weight: .light))
                            .kerning(4)
                            .foregroundColor(Color(hex: "c9a96e"))
                        Text("Gateway")
                            .font(.system(size: 10, weight: .regular))
                            .kerning(2)
                            .foregroundColor(Color(hex: "5a5550"))
                    }
                    Spacer()
                }
                .padding(.horizontal, 20)
                .padding(.top, 12)
                .padding(.bottom, 8)
                
                GatewayWebView(url: "https://altairaquila-hafen.duckdns.org/gateway/config")
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .padding(.horizontal, 8)
                    .padding(.bottom, 80)
            }
        }
    }
}
