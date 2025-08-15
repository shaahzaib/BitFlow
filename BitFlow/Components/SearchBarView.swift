//
//  SearchBarView.swift
//  BitFlow
//
//  Created by Macbook Pro on 22/07/2025.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var searchText : String
        
    var body: some View {
        HStack{
            Image(systemName: "magnifyingglass")
                .foregroundStyle(
                    searchText.isEmpty ? Color.white : Color.accent)
            
             TextField("Search by name or symbol...", text: $searchText)
                .foregroundStyle(Color.accent)
                .disableAutocorrection(true)
        }
        .font(.headline)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.background )
                .shadow(color: Color.accent.opacity(0.5), radius: 3)
        )
        .padding()
    }
    
}

#Preview {
    SearchBarView(searchText: .constant(""))
}
