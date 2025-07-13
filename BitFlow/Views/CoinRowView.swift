//
//  CoinRowView.swift
//  BitFlow
//
//  Created by Macbook Pro on 29/06/2025.
//

import SwiftUI

struct CoinRowView: View {
    
    let coin : CoinModel
    var showHoldings:Bool
    
    var body: some View {
            
        ZStack {
          Color.bgColor.ignoresSafeArea()
            HStack(spacing: 0){
                
                
                // coin symbol and image
                ShowCoin
                
                Spacer()
                
                // current holdings
                if showHoldings{
                    Holdings
                }
                
                // price and currentPercentage
                Stats
                    .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
                
            }
            .padding(.horizontal,10)
            .frame(height: 70)
            .background(Color.softgray.opacity(0.04))
            .cornerRadius(15)
            
            
        }
            
        
        
    }
}

#Preview {
    CoinRowView(coin: CoinPreviewData, showHoldings: true)
}


extension CoinRowView{
    
    private var ShowCoin : some View{
        HStack(spacing: 0) {
            Circle()
                .frame(width: 40, height: 40)
            
            Text(coin.symbol? .uppercased() ?? "00")
                .font(.headline)
                .foregroundStyle(Color.softgray)
                .padding(.leading,6)
        }
    }
    
    private var Holdings:some View{
        VStack(alignment: .trailing){
            
            Text(coin.currentHoldingValue.asCurrencyWith2Decimals())
                .bold()
                .font(.callout)
                .foregroundStyle(Color.Gold)
            Text((coin.currentHoldings ?? 0 ).asNumberString())
                .foregroundStyle(Color.Gold)
        }
        
        
    }
    
    private var Stats: some View{
        VStack(alignment: .trailing){
            Text(coin.currentPrice?.asCurrency() ?? "00")
                .bold()
                .foregroundStyle(Color.softgray)
            
            Text(coin.priceChangePercentage24H?.asPercentString() ?? "")
                .foregroundStyle(
                    (coin.priceChangePercentage24H ?? 00) >= 0 ?
                   Color.green:
                   Color.red )
            
        }
        
    }

}
