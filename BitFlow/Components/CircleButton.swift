//
//  CircleButton.swift
//  BitFlow
//
//  Created by Macbook Pro on 22/06/2025.
//

import SwiftUI

struct CircleButton: View {
    
    var iconName: String
    var body: some View {
        Image(systemName: iconName)
            .font(.headline)
            .foregroundStyle(Color.Accent)
            .frame(width: 50, height: 50)
            .background(
                Circle()
                    .foregroundStyle(Color.bgColor)
            )
            .shadow(color: Color.Accent.opacity(0.2),radius:5,x: 0,y: 0)
            .padding()
    }
}

#Preview {
    CircleButton(iconName: "info")
        
}
