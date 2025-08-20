//
//  CoinDetailView.swift
//  BitFlow
//
//  Created by Macbook Pro on 20/08/2025.
//

import SwiftUI

struct CoinDetailView: View {
    
    let coin: CoinModel
    
    init(coin: CoinModel) {
        self.coin = coin
        print("initializig details for \(coin.name)")
    }
    var body: some View {
        ZStack{
            Color.bgColor.ignoresSafeArea()
            
            Text(coin.name )
            
        }
        
    }
}

struct CoinDetailLoadingView: View {
    @Binding var coin: CoinModel?
    var body: some View {
        ZStack{
            if let coin = coin{
                CoinDetailView(coin: coin)
            }
        }
    }
}

#Preview {
    CoinDetailView(coin: CoinPreviewData)
}
