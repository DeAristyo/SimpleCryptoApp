//
//  HomeInteractor.swift
//  SimpleCryptoApp
//
//  Created by Dimas Aristyo Rahadian on 16/06/24.
//

import RxSwift

protocol HomeInteractorProtocol: AnyObject {
    func fetchGlobalData() -> Observable<CryptoGlobalData>
    func fetchCoinData() -> Observable<[Coin]>
}

class HomeInteractor: HomeInteractorProtocol {
    func fetchGlobalData() -> Observable<CryptoGlobalData> {
        return CryptoAPI.shared.fetchGlobalData()
    }
    
    func fetchCoinData() -> Observable<[Coin]> {
        return CryptoAPI.shared.fetchCoinData()
    }
}
