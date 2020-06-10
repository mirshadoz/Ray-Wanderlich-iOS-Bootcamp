/*
* Copyright (c) 2015 Razeware LLC
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*/

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var targetTextLabel: UILabel!
    @IBOutlet weak var guessLabel: UILabel!

    @IBOutlet weak var redLabel: UILabel!
    @IBOutlet weak var greenLabel: UILabel!
    @IBOutlet weak var blueLabel: UILabel!

    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!

    @IBOutlet weak var roundLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
  
    let game = BullsEyeGame(round: 0, score: 0)
    
    @IBAction func aSliderMoved(sender: UISlider) {
    switch sender.tag {
        case 1:
            game.redSliderValue = Double(sender.value.rounded())
            redLabel.text = String(game.redSliderValue)
        case 2:
            game.greenSliderValue = Double(sender.value.rounded())
            greenLabel.text = String(game.greenSliderValue)
        case 3:
            game.blueSliderValue = Double(sender.value.rounded())
            blueLabel.text = String(game.blueSliderValue)
        default:
            print("Wrong slider is moved! :)")
        }
        guessLabel.backgroundColor = UIColor(red: CGFloat(game.redSliderValue/255), green: CGFloat(game.greenSliderValue/255), blue: CGFloat(game.blueSliderValue/255), alpha: 1)

    }
  
    @IBAction func showAlert(sender: AnyObject) {
        game.difference = game.calculateDifference()
        let message = game.difference == 0.0 ? "Match!" : "No Match!"
        let alert = UIAlertController(title: "RGB Picker", message: message, preferredStyle: .alert)
                
        let loginAction = UIAlertAction(title: "OK", style: .default) {
            action in
            self.game.calculatePoints()
            self.game.startNewRound()
            self.updateView()
            self.resetValues()
        }
                
        alert.addAction(loginAction)

        self.present(alert, animated: true, completion: nil)
    }
  
    @IBAction func startOver(sender: AnyObject) {
        game.round = 0
        game.score = 0
        game.startNewRound()
        updateView()
        resetValues()
    }
  
    func updateView() {
        redLabel.text = String(game.redSliderValue)
        greenLabel.text = String(game.greenSliderValue)
        blueLabel.text = String(game.blueSliderValue)
        targetLabel.backgroundColor = UIColor(red: CGFloat(game.randomRed/255), green: CGFloat(game.randomGreen/255), blue: CGFloat(game.randomBlue/255), alpha: 1)
        roundLabel.text = String("Round: \(game.round)")
        scoreLabel.text = String("Score: \(game.score)")
    }
    
    func resetValues() {
        redSlider.value = 127.0
        greenSlider.value = 127.0
        blueSlider.value = 127.0
        guessLabel.backgroundColor = UIColor(red: CGFloat(1), green: CGFloat(1), blue: CGFloat(1), alpha: 1)
        redLabel.text = String(0.0)
        greenLabel.text = String(0.0)
        blueLabel.text = String(0.0)

    }
  
    override func viewDidLoad() {
    super.viewDidLoad()
        redSlider.tag = 1
        greenSlider.tag = 2
        blueSlider.tag = 3
        game.randomRed = game.generateRandomColor()
        game.randomGreen = game.generateRandomColor()
        game.randomBlue = game.generateRandomColor()
        game.rgb.r = Int(game.randomRed)
        game.rgb.g = Int(game.randomGreen)
        game.rgb.b = Int(game.randomBlue)
        game.startNewRound()
        updateView()
    }
    
    
    
    

    
}

