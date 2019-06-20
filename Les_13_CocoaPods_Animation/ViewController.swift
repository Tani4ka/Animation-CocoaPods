//
//  ViewController.swift
//  Les_13_CocoaPods_Animation
//
//  Created by Tetiana Hranchenko on 6/18/19.
//  Copyright © 2019 Canux Corporation. All rights reserved.
//

import UIKit
import Kingfisher // cashing images in memory cache and disk cache
import TableViewDragger // dragging table cells

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var heightConstraintForTableView: NSLayoutConstraint!
    var dragger: TableViewDragger!
    
    var imageNames = ["img_1", "img_2", "img_3", "img_4", "img_5", "img_6", "img_7", "img_8"]
    
    var statusBarHidden: Bool = false {
        didSet {
            setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    override var preferredStatusBarUpdateAnimation : UIStatusBarAnimation {
        return .slide
    }
    
    override var prefersStatusBarHidden : Bool {
        return statusBarHidden
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dragger = TableViewDragger(tableView: tableView)
        dragger.dataSource = self
        dragger.delegate = self
        dragger.alphaForCell = 0.7
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCellID", for: indexPath)
        if let draggerCell = cell as? DraggerTableViewCell {
            draggerCell.draggerImageView.image = UIImage(named: imageNames[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if let image = UIImage(named: imageNames[indexPath.row]) {
//            return image.size.height + 40  // 667+40=707
//        }
        return 100
    }
}

// MARK: - Extension
extension ViewController: TableViewDraggerDataSource, TableViewDraggerDelegate {
    
    func dragger(_ dragger: TableViewDragger, moveDraggingAt indexPath: IndexPath, newIndexPath: IndexPath) -> Bool {
        let imageName = imageNames[indexPath.row]
        imageNames.remove(at: indexPath.row)
        imageNames.insert(imageName, at: newIndexPath.row)
        tableView.moveRow(at: indexPath, to: newIndexPath)
    

        return true
    }

    func dragger(_ dragger: TableViewDragger, willBeginDraggingAt indexPath: IndexPath) {
        if let tableView = dragger.tableView {
            let scale = min(max(tableView.bounds.height / tableView.contentSize.height, 0.4), 1)
            dragger.scrollVelocity = scale


            UIView.animate(withDuration: 0.3) {
                self.statusBarHidden = true
                self.navigationController?.setNavigationBarHidden(true, animated: true)

                if let tabBarHeight = self.tabBarController?.tabBar.bounds.height {
                    self.tabBarController?.tabBar.frame.origin.y += tabBarHeight
                }

                self.heightConstraintForTableView.constant = (tableView.bounds.height) / scale - tableView.bounds.height
                tableView.transform = CGAffineTransform(scaleX: scale, y: scale)
                self.view.layoutIfNeeded()
            }
        }
    }

    func dragger(_ dragger: TableViewDragger, willEndDraggingAt indexPath: IndexPath) {

        UIView.animate(withDuration: 0.3) {
            self.statusBarHidden = false
            self.navigationController?.setNavigationBarHidden(false, animated: false)

            if let tabBarHeight = self.tabBarController?.tabBar.bounds.height {
                self.tabBarController?.tabBar.frame.origin.y -= tabBarHeight
            }

            self.heightConstraintForTableView.constant = 0
            if let tableView = dragger.tableView {
                tableView.transform = CGAffineTransform.identity
                self.view.layoutIfNeeded()
                tableView.scrollToRow(at: indexPath, at: .top, animated: false)
            }
        }
    }
}

//extension ViewController: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return imageNames.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCellID", for: indexPath)
//                cell.imageView?.image = imageNames[indexPath.row]
//
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 150
//    }
//}

