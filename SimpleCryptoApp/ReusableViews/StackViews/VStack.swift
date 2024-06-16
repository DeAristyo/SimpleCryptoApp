//
//  VStack.swift
//  SimpleCryptoApp
//
//  Created by Dimas Aristyo Rahadian on 16/06/24.
//

import UIKit

class VStack: UIStackView {
    init(arrangedSubviews: [UIView]) {
        super.init(frame: .zero)
        self.axis = .vertical
        self.alignment = .fill
        self.distribution = .fillEqually
        self.spacing = 10
        self.translatesAutoresizingMaskIntoConstraints = false
        
        for subview in arrangedSubviews {
            self.addArrangedSubview(subview)
        }
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(alignment: UIStackView.Alignment = .fill,
                   distribution: UIStackView.Distribution = .fillEqually,
                   spacing: CGFloat = 10) {
        self.alignment = alignment
        self.distribution = distribution
        self.spacing = spacing
    }
}
