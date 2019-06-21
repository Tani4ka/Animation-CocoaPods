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
        UIView.transition(with: animationView, duration: 2.0, options: [.transitionCurlUp], animations: {
            self.animationSwich.isHidden = false
        }, completion: { isFinished in
            if isFinished {
                UIView.transition(with: self.animationView, duration: 2.0, options: [.transitionFlipFromBottom], animations: {
                    self.animationSwich.isHidden = true
                }, completion: nil)
            }
        })
    }
    
    @IBAction func four() {
        UIView.animate(withDuration: 2, delay: 0, options: [.curveLinear], animations: {
            self.animationView.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        }) { (isFinished) in
            UIView.animate(withDuration: 3, delay: 0, options: [.curveLinear], animations: {
                self.animationView.transform = CGAffineTransform(scaleX: 1, y: 1)
            }, completion: nil)
        }
    }
    
    
    // Dynamic Animation
    
    // create vars
    var animator: UIDynamicAnimator?
    var gravity: UIGravityBehavior?
    var colider: UICollisionBehavior?
    var itemBehavior: UIDynamicItemBehavior?
    
    @IBAction func five() {
        
        let newView = UIView(frame: CGRect(x: 200, y: 0, width: 30, height: 30))
        newView.backgroundColor = UIColor.magenta
        view.addSubview(newView)
        
        // add properties to newView
        itemBehavior?.addItem(newView)
        gravity?.addItem(newView)
        colider?.addItem(newView)
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // init vars
        animator = UIDynamicAnimator(referenceView: view)
        
        gravity = UIGravityBehavior()
        colider = UICollisionBehavior()
        itemBehavior = UIDynamicItemBehavior()
        
        // set value for vars
        colider?.translatesReferenceBoundsIntoBoundary = true // не вылезит за границы
        colider?.collisionMode = .everything // все внутри будет соприкасаться между собой, buundaries - только с границами view
        
        itemBehavior?.allowsRotation = true  // вращение при соприкосновении
        itemBehavior?.elasticity = 0.7       // жесткость элемента
        itemBehavior?.friction = 0.6         // сопритивление какому-то поведению
        
         // add view this behaviors
        animator?.addBehavior(gravity!)
        animator?.addBehavior(colider!)
        animator?.addBehavior(itemBehavior!)

    }
}
