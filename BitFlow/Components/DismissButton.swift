//
//  DismissButton.swift
//  BitFlow
//
//  Created by Macbook Pro on 16/08/2025.
//

import SwiftUI

struct DismissButton: View {
    
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        
        Button {
            presentationMode.wrappedValue.dismiss()
        } label: {
            Image(systemName: "xmark")
                .font(.headline)
        }

    }
}

#Preview {
    DismissButton()
}
