//
//  CoinListCell.swift
//  SimpleCryptoApp
//
//  Created by Dimas Aristyo Rahadian on 17/06/24.
//

import UIKit

class CoinListCell: UITableViewCell {
    static let identifier = "CoinListCell"
    
    lazy var symbolLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .gray
        return label
    }()
    
    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .right
        return label
    }()
    
    lazy var change24hLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .right
        return label
    }()
    
    lazy var coinVstack: VStack = {
        let coinStack = VStack(arrangedSubviews: [
            symbolLabel,
            nameLabel
        ])
        
        coinStack.configure(alignment: .leading, distribution: .fill, spacing: 5)
        return coinStack
    }()
    
    lazy var coinHstack: HStack = {
        let coinStack = HStack(arrangedSubviews: [
            coinVstack,
            priceLabel,
            change24hLabel
        ])
        
        coinStack.configure(alignment: .center, distribution: .fill, spacing: 10)
        return coinStack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(coinHstack)
        
        NSLayoutConstraint.activate([
            coinHstack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            coinHstack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            coinHstack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            coinHstack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    func configure(with coin: Coin) {
        symbolLabel.text = coin.symbol
        nameLabel.text = coin.name
        priceLabel.text = NumberFormatter.currencyString(from: Double(coin.priceUsd) ?? 0)
        change24hLabel.text = "\(coin.percentChange24h)%"
        change24hLabel.textColor = (coin.percentChange24h as NSString).doubleValue >= 0 ? .systemGreen : .systemRed
    }
}

extension NumberFormatter {
    static func currencyString(from value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "USD"
        formatter.maximumFractionDigits = 2
        return formatter.string(from: NSNumber(value: value)) ?? "$0.00"
    }
}
