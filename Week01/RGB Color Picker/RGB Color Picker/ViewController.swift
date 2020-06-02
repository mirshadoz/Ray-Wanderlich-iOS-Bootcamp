//
//  ViewController.swift
//  RGB Color Picker
//
//  Created by Mirshad Oz on 5/31/20.
//  Copyright © 2020 Mirshad Oz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let DEFAULT_COLOR_NAME = "Black"
    var color: String?    
    var RGB_RED = 0.0, RGB_GREEN = 0.0, RGB_BLUE = 0.0
    @IBOutlet weak var colorNameLabel: UILabel!
    @IBOutlet weak var sliderRED: UISlider!
    @IBOutlet weak var sliderGREEN: UISlider!
    @IBOutlet weak var sliderBLUE: UISlider!
    @IBOutlet weak var redLabel: UILabel!
    @IBOutlet weak var greenLabel: UILabel!
    @IBOutlet weak var blueLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colorNameLabel.text = DEFAULT_COLOR_NAME
    }

    
    @IBAction func setColor() {
        
        var textColorName: UITextField?
        
        let alert = UIAlertController(title: "RGB Picker", message: "Please enter your color name", preferredStyle: .alert)
        
        let loginAction = UIAlertAction(title: "Set Color", style: .default) { (login) in
            if let colorName = textColorName?.text {
//                print("Color name is: \(colorName)")
                self.color = colorName
            } else {
//                print("No Color Name")
            }
            
            self.updateLabels()
            self.changeBackgroundColor()
            
        }
        
        alert.addTextField { (userColorName) in
            textColorName = userColorName
            textColorName?.placeholder = "Enter your Color Name"
        }
        
        alert.addAction(loginAction)
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func sliderRedMoved(_ slider: UISlider) {
//        print("Red Slider value now: \(Int(slider.value.rounded())) ")
        RGB_RED = Double(slider.value.rounded()) / 255
        redLabel.text = String(Int(sliderRED.value.rounded()))
        
    }
    
    @IBAction func sliderGreenMoved(_ slider: UISlider) {
//        print("Green Slider value now: \(Int(slider.value.rounded())) ")
        RGB_GREEN = Double(slider.value.rounded()) / 255
        greenLabel.text = String(Int(sliderGREEN.value.rounded()))
    }
    
    @IBAction func sliderBlueMoved(_ slider: UISlider) {
//        print("Blue Slider value now: \(Int(slider.value.rounded())) ")
        RGB_BLUE = Double(slider.value.rounded()) / 255
        blueLabel.text = String(Int(sliderBLUE.value.rounded()))
    }
    
    @IBAction func resetRGB() {
        RGB_RED = 0.0
        RGB_GREEN = 0.0
        RGB_BLUE = 0.0
        sliderRED.value = 0
        sliderGREEN.value = 0
        sliderBLUE.value = 0
        color = "Black"
        updateLabels()
        changeBackgroundColor()
    }
    
    func updateLabels() {
        colorNameLabel.text = color
        redLabel.text = String(Int(sliderRED.value.rounded()))
        greenLabel.text = String(Int(sliderGREEN.value.rounded()))
        blueLabel.text = String(Int(sliderBLUE.value.rounded()))
    }
    
    func changeBackgroundColor() {
//        print("Color CHANGED!!!")
        self.view.backgroundColor = UIColor(red: CGFloat(RGB_RED), green: CGFloat(RGB_GREEN), blue: CGFloat(RGB_BLUE), alpha: 1)
    }

}

