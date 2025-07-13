//
//   CoinViewModel.swift
//  BitFlow
//
//  Created by Macbook Pro on 29/06/2025.
//

import Foundation
import Combine

class CoinViewModel:ObservableObject{
    
    @Published var allCoins:[CoinModel] = []
    @Published var profileCoins :[CoinModel] = []
    
    private let coinService = CoinServices()
    private var cancellables = Set<AnyCancellable>()
 
    init(){
        addSubscribers()
    }
    
    func addSubscribers(){
        coinService.$allCoins
            .sink { [weak self] (returnedCoins) in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)
    }
    
    
    
}
