//
//  CoinDetailModel.swift
//  BitFlow
//
//  Created by Macbook Pro on 20/08/2025.
//

import Foundation


/* url: https://api.coingecko.com/api/v3/coins/bitcoin?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false
 */

import Foundation

 
struct CoinDetailModel: Identifiable, Decodable{
    let id, symbol, name: String?
    let blockTimeInMinutes: Int?
    let hashingAlgorithm: String?
    let description: Description?
    let links: Links?
    
    enum CodingKeys: String, CodingKey{
        case id,name,symbol,description,links
        case blockTimeInMinutes = "block_time_in_minutes"
        case hashingAlgorithm = "hashing_algorithm"
    }
}

struct Description:Decodable {
    let en: String?
}


struct Links: Decodable {
    let homepage: [String]?
    let subredditURL: String?
    
    enum CodingKeys: String, CodingKey{
        case homepage
        case subredditURL = "subreddit_url" 
    }
}




