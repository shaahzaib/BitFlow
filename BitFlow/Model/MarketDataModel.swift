//
//  MarketDataMModel.swift
//  BitFlow
//
//  Created by Macbook Pro on 15/08/2025.
//

import Foundation


//url: https://pro-api.coingecko.com/api/v3/global


// MARK: - Welcome
struct GlobalData: Codable{
    let data: MarketDataModel?
}

// MARK: - DataClass
struct MarketDataModel: Codable {
    
    let totalMarketCap, totalVolume, marketCapPercentage: [String: Double]
    let marketCapChangePercentage24HUsd: Double?
    
    enum CodingKeys: String, CodingKey{
       case totalMarketCap = "total_market_cap"
       case totalVolume = "total_volume"
       case marketCapPercentage = "market_cap_percentage"
       case marketCapChangePercentage24HUsd =  "market_cap_change_percentage_24h_usd"
     }
    
    var marketCap: String{
        if let item = totalMarketCap.first(where: {$0.key == "usd"}){
            return "$"+item.value.FormatwithAbbreviation()
        }
        return ""
    }
    
    
    var volume: String{
        if let item = totalVolume.first(where: {$0.key == "usd"}){
            return "$"+item.value.FormatwithAbbreviation()
        }
        return ""
    }
    
    var btcDominance: String{
        if let item = marketCapPercentage.first(where: {$0.key == "btc"}){
            return item.value.asPercentString()
        }
        return ""
    }
}

