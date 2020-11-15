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
        static let ballDiameter: CGFloat = 60
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
        let maxX = bounds.maxX - Constants.ballDiameter
        let maxY = bounds.maxY - Constants.ballDiameter
        
        for i in 0...Constants.ballsCount {
            let ball = UIView()
            view.addSubview(ball)
            ball.frame.size = CGSize(width: Constants.ballDiameter,
                                     height: Constants.ballDiameter)
            
            let ballX = CGFloat.random(in: 0..<maxX)
            let ballY = CGFloat.random(in: 0..<maxY)
            ball.frame.origin = CGPoint(x: ballX, y: ballY)
            
            ball.layer.cornerRadius = Constants.ballDiameter / 2
            ball.layer.masksToBounds = true
            
            setupShadow(for: ball)
            
            if i % 2 == 0 {
                ball.backgroundColor = .red
                handleAction(ball, type: .broken)
            } else {
                ball.backgroundColor = .blue
                handleAction(ball, type: .lost)
            }
        }
    }
    
    private func handleAction(_ view: UIView, type: BallType) {
        view.isUserInteractionEnabled = true
        switch type {
        case .broken:
            let tap = UITapGestureRecognizer(target: self, action: #selector(brokeBall(_:)))
            view.addGestureRecognizer(tap)
        case .lost:
            let swipe = UISwipeGestureRecognizer(target: self, action: #selector(lostBall(_:)))
            view.addGestureRecognizer(swipe)
        }
    }
    
    @objc
    private func brokeBall(_ gesture: UITapGestureRecognizer) {
        let view = gesture.view
        view?.removeFromSuperview()
    }
    
    @objc
    private func lostBall(_ gesture: UISwipeGestureRecognizer) {
        let view = gesture.view
        view?.removeFromSuperview()
    }
    
    @objc
    private func error(_ gesture: UISwipeGestureRecognizer) {
        let view = gesture.view
        view?.removeFromSuperview()
    }
    
    private func setupShadow(for view: UIView) {
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = .init(width: 1, height: 1)
        view.layer.shadowOpacity = 0.5
        view.layer.shadowRadius = 5
        view.layer.masksToBounds = false
    }

}

