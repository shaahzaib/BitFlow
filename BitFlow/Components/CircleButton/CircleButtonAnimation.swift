//
//  CircleButtonAnimation.swift
//  BitFlow
//
//  Created by Macbook Pro on 22/06/2025.
//

import SwiftUI

struct CircleButtonAnimation: View {
    @Binding var animate : Bool
    var body: some View {
        Circle()
            .stroke(lineWidth: 4.0)
            .scale(animate ? 1.0 : 0.0)
            .opacity(animate ? 0.0 : 1.0)
            .animation(animate ? Animation.easeOut(duration: 1.0) : .none , value: animate)
    }
}

#Preview {
    CircleButtonAnimation(animate: .constant(false))
        .foregroundStyle(Color.Accent)
        .frame(width: 100, height: 100)
}
