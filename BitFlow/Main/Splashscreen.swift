import SwiftUI

struct SplashScreen: View {
    @State private var logoScale: CGFloat = 0.6
    @State private var logoOpacity: Double = 0.0
    @State private var logoOffsetY: CGFloat = 80

    @State private var nameOpacity: Double = 0.0
    @State private var nameOffsetY: CGFloat = 40

    @State private var isActive = false

    var body: some View {
        ZStack {
            if isActive {
                HomeView()
                    .environmentObject(CoinViewModel())
            } else {
                // Splash screen background
                Color.bgColor
                    .ignoresSafeArea()

                VStack(spacing: 20) {
                    // Bitcoin Logo
                    Text("₿")
                        .font(.system(size: 120, weight: .bold))
                        .foregroundColor(Color.accent)
                        .scaleEffect(logoScale)
                        .opacity(logoOpacity)
                        .offset(y: logoOffsetY)
                    
                    Text("BitFlow")
                        .font(.system(size: 34, weight: .semibold))
                        .foregroundColor(Color.accent)
                        .opacity(nameOpacity)
                        .offset(y: nameOffsetY)
                }
                .onAppear {
                    // Animate logo
                    withAnimation(.spring(response: 0.8, dampingFraction: 0.6)) {
                        logoScale = 1.0
                        logoOpacity = 1.0
                        logoOffsetY = 0
                    }

                    // Animate name after logo
                    withAnimation(.easeOut(duration: 1.0).delay(0.5)) {
                        nameOpacity = 1.0
                        nameOffsetY = 0
                    }

                    // Navigate after delay
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                        withAnimation {
                            isActive = true
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    SplashScreen()
}
