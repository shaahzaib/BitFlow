//
//  CoinServices.swift
//  BitFlow
//
//  Created by Macbook Pro on 13/07/2025.
//

import Foundation
import Combine

class CoinServices:ObservableObject{
    
    
    @Published var allCoins: [CoinModel] = []
    var coinSubscription : AnyCancellable?
    
    init(){
        getCoins()
    }
    
    private func getCoins(){
       
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&include_tokens=top&order=market_cap_desc&per_page=20&page=1&sparkline=true&price_change_percentage=24h")
        else {
            return
        }
          
        coinSubscription = URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap{ (output) -> Data in
                guard let response = output.response as? HTTPURLResponse,
                      response.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                print(String(data: output.data, encoding: .utf8) ?? "No response body")
                return output.data
            }
            .receive(on: DispatchQueue.main)
            .decode(type: [CoinModel].self, decoder: JSONDecoder())
            .sink { (completion) in
                switch completion{
                case .finished : break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { [weak self] (returnedCoins)  in
                self?.allCoins = returnedCoins
                self?.coinSubscription?.cancel()
            }

                
    }
}
