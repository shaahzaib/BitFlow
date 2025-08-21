//
//  CoinModel.swift
//  BitFlow
//
//  Created by Macbook Pro on 29/06/2025.
//

import Foundation

// http GET
/* "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&names=Bitcoin%2CEthereum&symbols=btc%2Ceth&order=market_cap_desc&per_page=80&page=1&sparkline=true&price_change_percentage=24h"

 
 response body
 {
     "id": "bitcoin",
     "symbol": "btc",
     "name": "Bitcoin",
     "image": "https://coin-images.coingecko.com/coins/images/1/large/bitcoin.png?1696501400",
     "current_price": 119170,
     "market_cap": 2371604520041,
     "market_cap_rank": 1,
     "fully_diluted_valuation": 2371604520041,
     "total_volume": 24114716977,
     "high_24h": 119303,
     "low_24h": 117175,
     "price_change_24h": 1612.51,
     "price_change_percentage_24h": 1.37167,
     "market_cap_change_24h": 33694313114,
     "market_cap_change_percentage_24h": 1.44122,
     "circulating_supply": 19891896,
     "total_supply": 19891896,
     "max_supply": 21000000,
     "ath": 119303,
     "ath_change_percentage": -0.0582,
     "ath_date": "2025-07-13T19:35:46.672Z",
     "atl": 67.81,
     "atl_change_percentage": 175737.91481,
     "atl_date": "2013-07-06T00:00:00.000Z",
     "roi": null,
     "last_updated": "2025-07-13T19:44:02.200Z",
     "sparkline_in_7d": {
       "price": [
         108922.67195979225,
         108465.20961302417,
         108519.48830047643,
       ]
     },
 "price_change_percentage_24h_in_currency": 1.3716740818743016
 }
 
 
*/

struct CoinModel:Identifiable , Codable {
    let id, symbol, name: String
        let image: String?
    let currentPrice: Double
    let marketCap, marketCapRank, fullyDilutedValuation: Double?
    let totalVolume, high24H, low24H: Double?
        let priceChange24H, priceChangePercentage24H: Double?
        let marketCapChange24H: Double?
        let marketCapChangePercentage24H: Double?
        let circulatingSupply, totalSupply, maxSupply, ath: Double?
        let athChangePercentage: Double?
        let athDate: String?
        let atl, atlChangePercentage: Double?
        let atlDate: String?
        let lastUpdated: String?
        let sparklineIn7D: SparklineIn7D?
        let priceChangePercentage24HInCurrency: Double?
    let currentHoldings : Double?
  

    // formatted according to json data
    enum CodingKeys: String , CodingKey{
        case id, symbol, name , image
        case  currentPrice = "current_price"
        case  marketCap = "market_cap"
        case marketCapRank = "market_cap_rank"
        case fullyDilutedValuation = "fully_diluted_valuation"
        case totalVolume =  "total_volume"
        case high24H = "high_24h"
        case low24H =  "low_24h"
        case priceChange24H = "price_change_24h"
        case priceChangePercentage24H = "price_change_percentage_24h"
        case marketCapChange24H = "market_cap_change_24h"
        case marketCapChangePercentage24H = "market_cap_change_percentage_24h"
        case circulatingSupply =  "circulating_supply"
        case totalSupply = "total_supply"
        case maxSupply = "max_supply"
        case ath =  "ath"
        case athChangePercentage =  "ath_change_percentage"
        case athDate = "ath_date"
        case atl = "atl"
        case atlChangePercentage = "atl_change_percentage"
        case atlDate = "atl_date"
        case lastUpdated = "last_updated"
        case sparklineIn7D = "sparkline_in_7d"
        case priceChangePercentage24HInCurrency = "price_change_percentage_24h_in_currency"
        case currentHoldings
    }
    
    func updateHoldings(amount: Double) ->CoinModel{
        return CoinModel(id: id, symbol: symbol, name: name, image: image, currentPrice: currentPrice, marketCap: marketCap, marketCapRank: marketCapRank, fullyDilutedValuation: fullyDilutedValuation, totalVolume: totalVolume, high24H: high24H, low24H: low24H, priceChange24H: priceChange24H, priceChangePercentage24H: priceChangePercentage24H, marketCapChange24H: marketCapChange24H, marketCapChangePercentage24H: marketCapChangePercentage24H, circulatingSupply: circulatingSupply, totalSupply: totalSupply, maxSupply: maxSupply, ath: ath, athChangePercentage: athChangePercentage, athDate: athDate, atl: atl, atlChangePercentage: atlChangePercentage, atlDate: atlDate ,lastUpdated: lastUpdated, sparklineIn7D: sparklineIn7D, priceChangePercentage24HInCurrency: priceChangePercentage24HInCurrency, currentHoldings:amount)
    }
    
    
    var currentHoldingValue: Double{
        return (currentHoldings ?? 0) * (currentPrice)
    }
    
//    var rank : Int{
//        return Int(marketCapRank ?? 0)
//    }
}

// MARK: - SparklineIn7D
struct SparklineIn7D:Codable {
    let price: [Double]?
}


