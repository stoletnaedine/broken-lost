//
//  RootManager.swift
//  Broken Lost
//
//  Created by Artur Islamgulov on 15.11.2020.
//

import UIKit

class RootManager {
    
    var window: UIWindow?
//    let connectionHelper = ConnectionHelper()
//    let alertService: AlertService = AlertServiceDefault()
    
    func start() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
//        window?.rootViewController = R.storyboard.launchScreen().instantiateInitialViewController()
        
        startGame()
    }
    
    private func startGame() {
        let gameVC = GameViewController()
        window?.rootViewController = gameVC
    }
    
}
