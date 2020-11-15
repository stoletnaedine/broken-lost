//
//  MenuViewController.swift
//  BrokenLost
//
//  Created by Artur Islamgulov on 15.11.2020.
//

import UIKit

class MenuViewController: UIViewController {

    @IBOutlet weak var trainingButton: UIButton!
    @IBOutlet weak var gameButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupButtons()
    }
    
    private func setupView() {
        view.backgroundColor = .white
    }
    
    private func setupButtons() {
        trainingButton.setTitle(R.string.localizable.menuTraining(), for: .normal)
        trainingButton.titleLabel?.font = Fonts.main
        trainingButton.setTitleColor(.gray, for: .normal)
        trainingButton.addTarget(self, action: #selector(trainingButtonDidTap), for: .touchUpInside)
        
        gameButton.setTitle(R.string.localizable.menuGame(), for: .normal)
        gameButton.titleLabel?.font = Fonts.main
        gameButton.setTitleColor(.gray, for: .normal)
        gameButton.addTarget(self, action: #selector(gameButtonDidTap), for: .touchUpInside)
    }
    
    @objc
    private func trainingButtonDidTap() {
        print(#function)
    }
    
    @objc
    private func gameButtonDidTap() {
        let gameVC = GameViewController()
        gameVC.modalPresentationStyle = .overFullScreen
        present(gameVC, animated: true, completion: nil)
    }

}
