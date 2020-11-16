//
//  GameViewController.swift
//  Broken Lost
//
//  Created by Artur Islamgulov on 15.11.2020.
//

import UIKit

class GameViewController: UIViewController {
    
    private let timerLabel = UILabel()
    
    private var timer: Timer?
    
    private var counter: Int = .zero
    
    private enum Constants {
        static let ballsCount: Int = 60
        static let ballDiameter: CGFloat = 80
        static let seconds = 30
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        startGame()
    }
    
    private func setupTimerLabel() {
        timerLabel.textColor = .black
        timerLabel.text = "\(Constants.seconds)"
        view.addSubview(timerLabel)
        let bounds = view.frame
        let timerX: CGFloat = bounds.width - 40
        let timerY: CGFloat = 30
        timerLabel.frame = CGRect(origin: .init(x: timerX, y: timerY),
                                  size: .init(width: 30, height: 20))
    }
    
    private func setupTimer() -> Timer {
        return Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimerLabel), userInfo: nil, repeats: true)
    }
    
    @objc
    private func updateTimerLabel() {
        var currentSeconds = Int(timerLabel.text ?? "0") ?? .zero
        guard currentSeconds > 0 else {
            endGame()
            return
        }
        currentSeconds -= 1
        timerLabel.text = "\(currentSeconds)"
    }

    private func setupView() {
        view.backgroundColor = .white
    }
    
    private func startGame() {
        timer = setupTimer()
        counter = .zero
        
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
        
        // Чтобы таймер всегда был сверху шаров
        setupTimerLabel()
    }
    
    private func handleAction(_ view: UIView, type: BallType) {
        view.isUserInteractionEnabled = true
        switch type {
        case .broken:
            let tap = UITapGestureRecognizer(target: self, action: #selector(brokeBall(_:)))
            view.addGestureRecognizer(tap)
            
            let errorSwipe = UISwipeGestureRecognizer(target: self, action: #selector(endGame))
            errorSwipe.direction = .up
            view.addGestureRecognizer(errorSwipe)
        case .lost:
            let swipe = UISwipeGestureRecognizer(target: self, action: #selector(lostBall(_:)))
            swipe.direction = .up
            view.addGestureRecognizer(swipe)
            
            let errorTap = UITapGestureRecognizer(target: self, action: #selector(endGame))
            view.addGestureRecognizer(errorTap)
        }
    }
    
    @objc
    private func brokeBall(_ gesture: UITapGestureRecognizer) {
        let view = gesture.view
        UIView.animate(withDuration: 0.5,
                       animations: { view?.alpha = 0 },
                       completion: { _ in
                        view?.removeFromSuperview()
                        self.counter += 1
                       })
    }
    
    @objc
    private func lostBall(_ gesture: UISwipeGestureRecognizer) {
        guard let view = gesture.view else { return }
        
        let imageSpeed = 5 / view.frame.size.height
        let averageSpeed = (view.frame.size.height - view.frame.origin.y) * imageSpeed
        
        UIView.animate(withDuration: TimeInterval(averageSpeed),
                       delay: 0,
                       options: .curveLinear,
                       animations: { view.frame.origin.y = -view.frame.height },
                       completion: { _ in
                        view.removeFromSuperview()
                        self.counter += 1
                       })
    }
    
    @objc
    private func endGame() {
        timer?.invalidate()
        
        // TODO: вынести в localize
        let alert = UIAlertController(title: "Игра окончена!",
                                      message: "Ваш счет: \(counter)",
                                      preferredStyle: .alert)
        let againAction = UIAlertAction(title: "Заново",
                                        style: .default,
                                        handler: { [weak self] _ in
                                            self?.view.subviews.forEach({ $0.removeFromSuperview() })
                                            self?.startGame()
                                        })
        alert.addAction(againAction)
        present(alert, animated: true, completion: nil)
    }
    
    private func setupShadow(for view: UIView) {
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = .init(width: 1, height: 1)
        view.layer.shadowOpacity = 0.5
        view.layer.shadowRadius = 5
        view.layer.masksToBounds = false
    }

}

