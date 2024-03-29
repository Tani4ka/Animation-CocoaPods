//
//  KingfisherViewController.swift
//  Les_13_CocoaPods_Animation
//
//  Created by Tetiana Hranchenko on 6/20/19.
//  Copyright © 2019 Canux Corporation. All rights reserved.
//

import UIKit

class KingfisherViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // image literal from assets (Shift + Command + M, than double click and chose image)
        // let image1 = UIImage(named: "placeholder")
        // let image3: UIImage = #imageLiteral(resourceName: "placeholder")
        let image2: UIImage =  #imageLiteral(resourceName: "placeholder.jpg")
        
        let url = URL(string: "https://upload.wikimedia.org/wikipedia/commons/d/dd/Big_%26_Small_Pumkins.JPG")
        imageView.kf.setImage(with: url, placeholder: image2)
    }
}
