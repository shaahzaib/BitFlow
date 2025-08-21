//
//   CoinViewModel.swift
//  BitFlow
//
//  Created by Macbook Pro on 29/06/2025.
//

import Foundation
import Combine

class CoinViewModel:ObservableObject{
    
    
    @Published var statistics: [StatisticsModel] = []
    
    @Published var allCoins:[CoinModel] = []
    @Published var profileCoins :[CoinModel] = []
    @Published var isLoading : Bool = false
    @Published var searchtext : String = ""
    @Published var sortOption : SortOptions = .holdings
    
    private let coinDataService = CoinServices()
    private let marketDataService = MarketDataService()
    private let profileDataService = ProfileDataService()
    private var cancellables = Set<AnyCancellable>()
    
    
    // Options to sort the coins in homeView
    enum SortOptions{
        case  price, priceRevesed, holdings, holdingsRevesed
    }
    
    
    init(){
        addSubscribers()
    }
    
    func addSubscribers(){
        
        
        // update allcoins
        $searchtext
            .combineLatest(coinDataService.$allCoins)
            .debounce(for: .seconds(0.4), scheduler: DispatchQueue.main)
            .map(filterCoins)
            .sink { [weak self] (returnedCoins) in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)
        
        
        // updates market data
            marketDataService.$marketData
            .combineLatest($profileCoins)
            .map(mapGlobalMarketData)
            .sink { [weak self] (returnedStats) in
                self?.statistics = returnedStats
                self?.isLoading =  false
            }
            .store(in: &cancellables)
        
        // updates profile coins
        $allCoins
            .combineLatest(profileDataService.$savedEntities)
            .map(mapAllCoinsToProfileCoins)
            .sink { [weak self] (returnedCoins) in
                self?.profileCoins = returnedCoins
            }
            .store(in: &cancellables)
    }
    
    
    
    func upadteProfile(coin: CoinModel, amount: Double){
        profileDataService.updateProfile(coin: coin, amount: amount)
    }
    
    func reloadCoins(){
        isLoading = true
        coinDataService.getCoins()
        marketDataService.getData()
    }
    
    // to map allcoins to profilecoins
    private func mapAllCoinsToProfileCoins(allCoins: [CoinModel], profileEntities: [ProfileEntity])->
    [CoinModel]{
        allCoins
            .compactMap { (coin)->CoinModel? in
                guard let entity = profileEntities.first(where: { $0.coinID == coin.id }) else{
                    return nil
                }
                return coin.updateHoldings(amount: entity.amount)
            }
    }
    
    // filtering and sorting coins
    private func filterAndSortCoins(text: String, coins: [CoinModel], sort: SortOptions) ->
    [CoinModel] {
        var updatedCoins = filterCoins(text: text, coins: coins)
        sortCoins(sort: sort, coins: &updatedCoins)
        return updatedCoins
    }
    
    // filtering coins
    private func filterCoins(text: String, coins: [CoinModel]) -> [CoinModel]{
        guard !text.isEmpty else{
            return coins
        }
        let lowerCasedText = text.lowercased()
        return coins.filter { (coin) -> Bool in
            return  coin.name.lowercased().contains(lowerCasedText) ||
            coin.symbol.lowercased().contains(lowerCasedText) //||
            //  coin.id.lowercased().contains(lowerCasedText)
        }
    }
    
    //sorting coins
    private  func sortCoins(sort: SortOptions, coins: inout [CoinModel]){
        switch sort {
        case .price, .holdings:
            coins.sort(by: { ($0.currentPrice) > ($1.currentPrice) })
        case .priceRevesed, .holdingsRevesed:
            coins.sort(by: { ($0.currentPrice) < ($1.currentPrice) })
        }
    }
    
    
    // to map marketData and get statistics
    private func mapGlobalMarketData(marketDataModel: MarketDataModel?, profileCoins: [CoinModel]) ->
    [StatisticsModel]{
        var stats : [StatisticsModel] = []
        
        guard let data = marketDataModel else {
            return stats
        }
        let marketCap = StatisticsModel(title: "Market Cap", value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd)
        let volume = StatisticsModel(title: "24h Volume", value: data.volume)
        let btcDominance = StatisticsModel(title: "BTC Dominance", value: data.btcDominance)
        
        // current profile value
        let profileValue =
        profileCoins
            .map({ $0.currentHoldingValue })
            .reduce(0, +)
        
        // previous 24h value
        
        let previousValue =
        profileCoins
            .map { (coin) -> Double in
                let currentValue = coin.currentHoldingValue
                let percentChange = (coin.priceChangePercentage24H ?? 0 ) / 100
                let previousVal = currentValue / (1 + percentChange)
                return previousVal
            }
            .reduce(0, +)
        
        //total percentage change
        let percentageChange = ((profileValue - previousValue) / previousValue) * 100
        
        let profile =
        StatisticsModel(
            title: "Profile Value",
            value: profileValue.asCurrencyWith2Decimals(),
            percentageChange: percentageChange)
        
        stats.append(contentsOf: [
            marketCap,
            volume,
            btcDominance,
            profile
            
        ])
        return stats
    }
}
