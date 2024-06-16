//
//  HomeRouter.swift
//  SimpleCryptoApp
//
//  Created by Dimas Aristyo Rahadian on 16/06/24.
//

import UIKit

class HomeRouter {
    
    static func createHomeModule() -> UIViewController {
        let viewController = HomeViewController.createModule()
        return viewController
    }
    
}
