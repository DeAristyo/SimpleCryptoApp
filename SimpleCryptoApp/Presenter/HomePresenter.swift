//
//  HomePresenter.swift
//  SimpleCryptoApp
//
//  Created by Dimas Aristyo Rahadian on 16/06/24.
//

import RxSwift
import RxCocoa

protocol HomePresenterProtocol: AnyObject {
    var view: HomeViewProtocol? { get set }
    func loadGlobalData()
    func loadCoinData()
}

class HomePresenter: HomePresenterProtocol {
    weak var view: HomeViewProtocol?
    private let interactor: HomeInteractorProtocol
    private let disposeBag = DisposeBag()
    
    init(interactor: HomeInteractorProtocol) {
        self.interactor = interactor
    }
    
    /// Funtion to load global data of crypto
    func loadGlobalData() {
        interactor.fetchGlobalData()
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] data in
                self?.view?.showGlobalData(data)
            }, onError: { [weak self] error in
                self?.view?.showError(error.localizedDescription)
            }).disposed(by: disposeBag)
    }
    
    func loadCoinData() {
        interactor.fetchCoinData()
            .subscribe(onNext: { [weak self] coins in
                self?.view?.showCoinData(coins)
            }, onError: { [weak self] error in
                self?.view?.showError(error.localizedDescription)
            })
            .disposed(by: disposeBag)
    }
}
