//
//  CoinDetailViewModel.swift
//  BitFlow
//
//  Created by Macbook Pro on 20/08/2025.
//

import Foundation
import Combine

class CoinDetailViewModel:ObservableObject{
    
    @Published var coin : CoinModel
    @Published var overviewStatistics : [StatisticsModel] = []
    @Published var additionalStatistics : [StatisticsModel] = []
    @Published var coinDescription : String? = nil
    @Published var websiteURL : String? = nil
    @Published var redditURL : String? = nil
    
    private let coinDetailService: CoinDetailDataService
    private var cancellables = Set<AnyCancellable>()
    
    
    init(coin:CoinModel){
        self.coin = coin
        self.coinDetailService = CoinDetailDataService(coin: coin)
        self.addSubscribers()
    }
    
    private func addSubscribers(){
        coinDetailService.$coinDetails
            .combineLatest($coin)
            .map(mapDataToStatistics)
            .sink { (returnedArrays) in
                self.overviewStatistics = returnedArrays.overview
                self.additionalStatistics = returnedArrays.additional
            }
            .store(in: &cancellables)
        
        coinDetailService.$coinDetails
            .sink {[weak self] (returnedCoinDetails) in
                self?.coinDescription = returnedCoinDetails?.description?.en
                self?.websiteURL = returnedCoinDetails?.links?.homepage?.first
                self?.redditURL = returnedCoinDetails?.links?.subredditURL
            }
            .store(in: &cancellables)
    }
    
    private func mapDataToStatistics(coinDetailModel: CoinDetailModel?,coinModel:CoinModel) -> (overview:[StatisticsModel], additional:[StatisticsModel]){
        let overviewArray =  createOverviewArray(coinModel: coinModel)
        let additionalArray = createAdditionalArray(coinDetailModel: coinDetailModel, coinModel: coinModel)
        return (overviewArray,additionalArray)
    }
    
   
    private func createOverviewArray(coinModel:CoinModel) -> [StatisticsModel]{
        let price = coinModel.currentPrice.asCurrency()
        let pricePercentChange = coinModel.priceChangePercentage24H
        let priceStat = StatisticsModel(title: "Current Price", value: price, percentageChange: pricePercentChange)
        
        let marketCap = "$" + (coinModel.marketCap?.FormatwithAbbreviation() ?? "")
        let marketCapPercetChange = coinModel.marketCapChangePercentage24H
        let marketCapStat = StatisticsModel(title: "Market Capitalization", value: marketCap, percentageChange: marketCapPercetChange)

        let volume = "$" + (coinModel.totalVolume?.FormatwithAbbreviation() ?? "")
        let volumeStat = StatisticsModel(title: "Volume", value: volume)
        
        let overviewArray: [StatisticsModel] = [
            priceStat,marketCapStat,volumeStat
        ]
        
        return overviewArray
    }
    
    private func createAdditionalArray(coinDetailModel: CoinDetailModel?,coinModel:CoinModel) -> [StatisticsModel]{
        let high = coinModel.high24H?.asCurrency() ?? "n/a"
        let highStat = StatisticsModel(title: "24H High", value: high)
        
        let low = coinModel.low24H?.asCurrency() ?? "n/a"
        let lowStat = StatisticsModel(title: "24H low", value: low)
        
        let priceChange = coinModel.priceChange24H?.asCurrency() ?? "n/a"
        let pricePercentChange = coinModel.priceChangePercentage24H
        let priceChangeStat = StatisticsModel(title: "24h Price Change", value: priceChange, percentageChange: pricePercentChange)
        
        let marketCapChange = "$" + (coinModel.marketCapChange24H?.FormatwithAbbreviation() ?? "")
        let marketCapPercetChange = coinModel.marketCapChangePercentage24H
        let marketCapChangeStat = StatisticsModel(title: "24h Market Cap Change", value: marketCapChange, percentageChange: marketCapPercetChange)
        
        let blockTime = coinDetailModel?.blockTimeInMinutes
        let blockTimeString = blockTime == 0 ? "n/a": "\(String(describing: blockTime))"
        let blockStat = StatisticsModel(title: "Block Time", value: blockTimeString)
        
        let hashing = coinDetailModel?.hashingAlgorithm ?? "n/a"
        let hashingStat = StatisticsModel(title: "Hashing Algorithm", value: hashing)
        
        let additionalArray : [StatisticsModel] = [
            highStat,lowStat,priceChangeStat,marketCapChangeStat,blockStat,hashingStat
        ]
        
        return additionalArray
    }
    
}
