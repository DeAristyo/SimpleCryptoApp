//
//  CoinData.swift
//  SimpleCryptoApp
//
//  Created by Dimas Aristyo Rahadian on 17/06/24.
//

import Foundation

struct Coin: Decodable {
    let id: String
    let symbol: String
    let name: String
    let rank: Int
    let priceUsd: String
    let percentChange24h: String
    let percentChange1h: String
    let percentChange7d: String
    let marketCapUsd: String
    let volume24: Double
    let csupply: String
    
    enum CodingKeys: String, CodingKey {
        case id, symbol, name, rank
        case priceUsd = "price_usd"
        case percentChange24h = "percent_change_24h"
        case percentChange1h = "percent_change_1h"
        case percentChange7d = "percent_change_7d"
        case marketCapUsd = "market_cap_usd"
        case volume24 = "volume24"
        case csupply = "csupply"
    }
}

struct CoinResponse: Decodable {
    let data: [Coin]
}
