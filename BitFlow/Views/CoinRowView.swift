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
           
        }
        .background(Color.bgColor)
        
    }
}

#Preview {
    CoinRowView(coin: CoinPreviewData, showHoldings: true)
}


extension CoinRowView{
    
    private var ShowCoin : some View{
        HStack(spacing: 0) {
            Circle()
                .frame(width: 30, height: 30)
            
             Text(coin.symbol .uppercased())
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
            
            Text((coin.currentHoldings ?? 0 ).asNumberString())
        }
        .foregroundStyle(Color.softgray)
        
    }
    
    private var Stats: some View{
        VStack(alignment: .trailing){
            Text(coin.currentPrice?.asCurrency() ?? "$0.00")
                .bold()
                .foregroundStyle(Color.softgray)
            
            Text(coin.priceChangePercentage24H?.asPercentString() ?? "")
                .foregroundStyle(
                   (coin.priceChangePercentage24H ?? 0) >= 0 ?
                   Color.green:
                   Color.red )
            
        }
        .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
    }

}
