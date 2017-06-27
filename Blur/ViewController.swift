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
    @IBOutlet weak var alphaPicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.blurView.setup(style: UIBlurEffectStyle.light, alpha: 0.9).enable()
        
        alphaPicker.selectRow(1, inComponent: 0, animated: true)
        addLabel()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func styleDidChange(_ sender: UISegmentedControl) {
        let style: UIBlurEffectStyle = {
            switch sender.selectedSegmentIndex {
            case 0:
                return .light
            case 1:
                return .dark
            case 2:
                return .extraLight
            default:
                return .light
            }
        }()
        imageView.blurView.style = style
        addLabel()
    }
    
    func addLabel() {
        // Label for vibrant text
        let vibrantLabel = UILabel()
        vibrantLabel.text = "Vibrant"
        vibrantLabel.font = UIFont.systemFont(ofSize: 72.0)
        vibrantLabel.sizeToFit()
        vibrantLabel.center = imageView.center
        
        imageView.blurView.vibrancyContentView?.addSubview(vibrantLabel)
    }
}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 11
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return "alpha: \((10 - row) * 10)%"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        imageView.blurView.alpha = CGFloat(10 - row) / 10
    }
}

