//
//  NetworkService.swift
//  SimpleCryptoApp
//
//  Created by Dimas Aristyo Rahadian on 16/06/24.
//

import Alamofire
import RxSwift

class CryptoAPI {
    static let shared = CryptoAPI()

    func fetchGlobalData() -> Observable<CryptoGlobalData> {
        return Observable.create { observer -> Disposable in
            let request = AF.request("https://api.coinlore.net/api/global/")
            request.responseDecodable(of: [CryptoGlobalData].self) { response in
                switch response.result {
                case .success(let data):
                    if let globalData = data.first {
                        observer.onNext(globalData)
                        observer.onCompleted()
                    } else {
                        observer.onError(NSError(domain: "CryptoAPI", code: -1, userInfo: [NSLocalizedDescriptionKey: "Data not found"]))
                    }
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create {
                request.cancel()
            }
        }
    }
    
    func fetchCoinData() -> Observable<[Coin]> {
            return Observable.create { observer in
                AF.request("https://api.coinlore.net/api/tickers/?start=100&limit=100")
                    .responseDecodable(of: CoinResponse.self) { response in
                        switch response.result {
                        case .success(let data):
                            observer.onNext(data.data)
                        case .failure(let error):
                            observer.onError(error)
                        }
                    }
                return Disposables.create()
            }
        }
}
