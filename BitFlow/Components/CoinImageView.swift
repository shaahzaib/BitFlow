//
//  CoinImageView.swift
//  BitFlow
//
//  Created by Macbook Pro on 21/07/2025.
//

import SwiftUI

struct CoinImageView: View {
    @StateObject var vm:CoinImageViewModel
    
    init(coin: CoinModel) {
        _vm = StateObject(wrappedValue: CoinImageViewModel(coin: coin))
    }
    var body: some View {

        ZStack{
            if let image = vm.image{
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            }else if vm.isLoading{
                ProgressView()
            }
            else{
                Image(systemName: "questionmark")
                    .foregroundStyle(Color.secondary)
            }
        }
    }
}

#Preview {
    CoinImageView(coin: CoinPreviewData)
     
}
