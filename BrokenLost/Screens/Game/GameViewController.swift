//
//  GameViewController.swift
//  Broken Lost
//
//  Created by Artur Islamgulov on 15.11.2020.
//

import UIKit

class GameViewController: UIViewController {
    
    private enum Constants {
        static let ballsCount: Int = 10
        static let ballRadius: CGFloat = 25
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupBalls()
    }

    private func setupView() {
        view.backgroundColor = .white
    }
    
    private func setupBalls() {
        
        let bounds = view.frame
        let maxX = bounds.maxX
        let maxY = bounds.maxY
        
        for i in 0...Constants.ballsCount {
            let ball = UIView()
            view.addSubview(ball)
            ball.frame.size = CGSize(width: Constants.ballRadius * 2,
                                     height: Constants.ballRadius * 2)
            
            let ballX = CGFloat.random(in: 0..<maxX)
            let ballY = CGFloat.random(in: 0..<maxY)
            ball.frame.origin = CGPoint(x: ballX, y: ballY)
            
            ball.layer.cornerRadius = Constants.ballRadius
            ball.layer.masksToBounds = true
            
            if i % 2 == 0 {
                ball.backgroundColor = .red
            } else {
                ball.backgroundColor = .blue
            }
        }
    }

}

