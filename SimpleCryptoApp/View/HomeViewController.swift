//
//  ViewController.swift
//  SimpleCryptoApp
//
//  Created by Dimas Aristyo Rahadian on 16/06/24.
//

import UIKit
import RxSwift
import RxCocoa

protocol HomeViewProtocol: AnyObject {
    func showGlobalData(_ data: CryptoGlobalData)
    func showError(_ message: String)
    func showCoinData(_ coins: [Coin])
}

class HomeViewController: UIViewController, HomeViewProtocol {
    private var presenter: HomePresenterProtocol!
    private let disposeBag = DisposeBag()
    private var coins: [Coin] = []
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(CoinListCell.self, forCellReuseIdentifier: CoinListCell.identifier)
        return tableView
    }()
    
    // MARK: - Coin Count label
    lazy var coinsCountLabel: UILabel = {
        let coinLabel = UILabel()
        coinLabel.text = "Coins"
        coinLabel.font = .systemFont(ofSize: 16, weight: .bold)
        
        return coinLabel
    }()
    
    lazy var coinsCountData: UILabel = {
        let coinsData = UILabel()
        coinsData.text = ""
        coinsData.font = .systemFont(ofSize: 20, weight: .bold)
        
        return coinsData
    }()
    
    lazy var vCoinCountStack: VStack = {
        let coinStack = VStack(arrangedSubviews: [
            coinsCountLabel,
            coinsCountData
        ])
        
        coinStack.configure(alignment: .center, distribution: .fill, spacing: 5)
        return coinStack
    }()
    
    // MARK: - Active Market Count label
    lazy var activeMarketsLabel: UILabel = {
        let marketLabel = UILabel()
        marketLabel.text = "Markets"
        marketLabel.font = .systemFont(ofSize: 16, weight: .bold)
        
        return marketLabel
    }()
    
    lazy var activeMarketData: UILabel = {
        let marketData = UILabel()
        marketData.text = ""
        marketData.font = .systemFont(ofSize: 20, weight: .bold)
        
        return marketData
    }()
    
    lazy var vActiveMarketStack: VStack = {
        let marketStack = VStack(arrangedSubviews: [
            activeMarketsLabel,
            activeMarketData
        ])
        
        marketStack.configure(alignment: .center, distribution: .fill, spacing: 5)
        return marketStack
    }()
    
    // MARK: - Total Market Cap label
    lazy var totalMCapLabel: UILabel = {
        let mCapLabel = UILabel()
        mCapLabel.text = "M Caps"
        mCapLabel.font = .systemFont(ofSize: 16, weight: .bold)
        
        return mCapLabel
    }()
    
    lazy var totalMCapData: UILabel = {
        let mCapData = UILabel()
        mCapData.text = ""
        mCapData.font = .systemFont(ofSize: 20, weight: .bold)
        
        return mCapData
    }()
    
    lazy var vTotalMCapStack: VStack = {
        let mCapStack = VStack(arrangedSubviews: [
            totalMCapLabel,
            totalMCapData
        ])
        
        mCapStack.configure(alignment: .center, distribution: .fill, spacing: 5)
        return mCapStack
    }()
    
    // MARK: - Total Volume label
    lazy var totalVolumeLabel: UILabel = {
        let volumeLabel = UILabel()
        volumeLabel.text = "Volume"
        volumeLabel.font = .systemFont(ofSize: 16, weight: .bold)
        
        return volumeLabel
    }()
    
    lazy var totalVolumeData: UILabel = {
        let volumeData = UILabel()
        volumeData.text = ""
        volumeData.font = .systemFont(ofSize: 20, weight: .bold)
        
        return volumeData
    }()
    
    lazy var vTotalVolumeStack: VStack = {
        let totalStack = VStack(arrangedSubviews: [
            totalVolumeLabel,
            totalVolumeData
        ])
        
        totalStack.configure(alignment: .center, distribution: .fill, spacing: 5)
        return totalStack
    }()
    
    // MARK: - BTC Dominance label
    lazy var btcDominanceLabel: UILabel = {
        let btcLabel = UILabel()
        btcLabel.text = "BTC.D"
        btcLabel.font = .systemFont(ofSize: 16, weight: .bold)
        
        return btcLabel
    }()
    
    lazy var btcDominanceData: UILabel = {
        let btcData = UILabel()
        btcData.text = ""
        btcData.font = .systemFont(ofSize: 20, weight: .bold)
        
        return btcData
    }()
    
    lazy var vBtcDominanceStack: VStack = {
        let btcStack = VStack(arrangedSubviews: [
            btcDominanceLabel,
            btcDominanceData
        ])
        
        btcStack.configure(alignment: .center, distribution: .fill, spacing: 5)
        return btcStack
    }()
    
    // MARK: - BTC Dominance label
    lazy var ethDominanceLabel: UILabel = {
        let volumeLabel = UILabel()
        volumeLabel.text = "ETH.D"
        volumeLabel.font = .systemFont(ofSize: 16, weight: .bold)
        
        return volumeLabel
    }()
    
    lazy var ethDominanceData: UILabel = {
        let volumeData = UILabel()
        volumeData.text = ""
        volumeData.font = .systemFont(ofSize: 20, weight: .bold)
        
        return volumeData
    }()
    
    lazy var vEthDominanceStack: VStack = {
        let ethStack = VStack(arrangedSubviews: [
            ethDominanceLabel,
            ethDominanceData
        ])
        
        ethStack.configure(alignment: .center, distribution: .fill, spacing: 5)
        return ethStack
    }()
    
    lazy var hStackTop: HStack = {
        let stack = HStack(arrangedSubviews: [
            vCoinCountStack,
            vActiveMarketStack,
            vTotalMCapStack
        ])
        
        stack.configure(alignment: .center, distribution: .fillEqually, spacing: 15)
        return stack
    }()
    
    lazy var hStackBottom: HStack = {
        let stack = HStack(arrangedSubviews: [
            vTotalVolumeStack,
            vBtcDominanceStack,
            vEthDominanceStack
        ])
        
        stack.configure(alignment: .center, distribution: .fillEqually, spacing: 15)
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter.loadGlobalData()
        presenter.loadCoinData()
    }
    
    func showGlobalData(_ data: CryptoGlobalData) {
        print("Global data received: \(data)")
        coinsCountData.text = String(data.coinsCount)
        activeMarketData.text = String(data.activeMarkets)
        totalMCapData.text = NumberFormatter.abbreviatedCurrencyString(from: data.totalMcap)
        totalVolumeData.text = NumberFormatter.abbreviatedString(from: data.totalVolume)
        btcDominanceData.text = "\(data.btcDominance) %"
        ethDominanceData.text = "\(data.ethDominance) %"
    }
    
    func showCoinData(_ coins: [Coin]) {
        self.coins = coins
        tableView.reloadData()
    }
    
    func showError(_ message: String) {
        print("Error: \(message)")
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    private func setupUI() {
        view.addSubview(hStackTop)
        view.addSubview(hStackBottom)
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        NSLayoutConstraint.activate([
            hStackTop.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            hStackTop.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            hStackTop.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            hStackBottom.topAnchor.constraint(equalTo: hStackTop.bottomAnchor, constant: 20),
            hStackBottom.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            hStackBottom.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            hStackBottom.bottomAnchor.constraint(lessThanOrEqualTo: tableView.topAnchor, constant: -20),
            
            tableView.topAnchor.constraint(equalTo: hStackBottom.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
            
        ])
    }
    
    static func createModule() -> HomeViewController {
        let view = HomeViewController()
        let interactor = HomeInteractor()
        let presenter = HomePresenter(interactor: interactor)
        view.presenter = presenter
        presenter.view = view
        return view
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CoinListCell.identifier, for: indexPath) as? CoinListCell else {
                return UITableViewCell()
            }
            let coin = coins[indexPath.row]
            cell.configure(with: coin)
            return cell
        }
}
