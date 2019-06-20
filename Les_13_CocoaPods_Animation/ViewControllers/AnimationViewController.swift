//
//  AnimationViewController.swift
//  Les_13_CocoaPods_Animation
//
//  Created by Tetiana Hranchenko on 6/20/19.
//  Copyright © 2019 Canux Corporation. All rights reserved.
//

import UIKit

class AnimationViewController: UIViewController {
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var animationView: UIView!
    @IBOutlet weak var animationSwich: UISwitch!
    
    private weak var timer: Timer? // указатель на таймет
    
    @IBAction func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { (timer) in
            self.timerLabel.text = String(Date().timeIntervalSince1970)
        })
        timer?.tolerance = 0.1
    }
    
    @IBAction func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    deinit {
        timer?.invalidate()
        timer = nil // можно не указывать
    } // чтобы не потерять ссылку на таймер и он не работал вечно
    

    @IBAction func one() {
        UIView.animate(withDuration: 2.0, animations: {
            self.animationView.backgroundColor = UIColor.black
        }, completion: { isFinished in
            if isFinished {
                UIView.animate(withDuration: 2.0, animations: {
                    self.animationView.backgroundColor = UIColor.cyan
                })
            }
        })
    }
    
    @IBAction func two() {
        let frame = animationView.frame
        UIView.animate(withDuration: 2.0, delay: 0, options: [.curveEaseIn], animations: {
            self.animationView.frame = CGRect(x: 300, y: 60, width: 100, height: 100)
            self.animationView.backgroundColor = UIColor.magenta
        }, completion: { isFinished in
            if isFinished {
                UIView.animate(withDuration: 2.0, animations: {
                    self.animationView.frame = frame
                    self.animationView.backgroundColor = UIColor.cyan
                })
            }
        })
    }
    
    @IBAction func three() {
    }
    
    @IBAction func four() {
    }
    
// MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
