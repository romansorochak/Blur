//
//  ViewController.swift
//  Blur
//
//  Created by Roman Sorochak on 6/27/17.
//  Copyright © 2017 MagicLab. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.applyBlurEffect(
            style: UIBlurEffectStyle.light,
            enableVibrancy: true,
            blurAlpha: 0.9
        )
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

