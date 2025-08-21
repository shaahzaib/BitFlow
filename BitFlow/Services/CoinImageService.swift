//
//  CoinImageService.swift
//  BitFlow
//
//  Created by Macbook Pro on 21/07/2025.
//

import Foundation
import SwiftUI
import Combine

class CoinImageService{
    
    @Published var image : UIImage? = nil
    var ImageSubscription: AnyCancellable?
    private let coin : CoinModel
    
    
    init(coin: CoinModel){
        self.coin = coin
        getCoinImage()
    }
    
    
    private func getCoinImage(){
        guard let url = URL(string: coin.image ?? " " )
        else {
            return
        }
          
        ImageSubscription = NetworkingManager.download(url: url )
            .tryMap({ (data)-> UIImage?  in
                return UIImage(data: data)
            })
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self](returnedImage) in
                self?.image = returnedImage
                self?.ImageSubscription?.cancel()
            })
    }
}
