//
//  ViewController.swift
//  BullsEye
//
//  Created by Ray Wenderlich on 6/13/18.
//  Copyright © 2018 Ray Wenderlich. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let bullsEyeGame = BullsEyeGame(currentValue: 0, score: 0, round: 0)


    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!

    override func viewDidLoad() {
    super.viewDidLoad()
        let roundedValue = bullsEyeGame.gameSlider.value.rounded()
        bullsEyeGame.currentValue = Int(roundedValue)
        bullsEyeGame.startNewGame()
        updateLabelsFromModel()
    }

    @IBAction func showAlert() {

        let difference = abs(bullsEyeGame.targetValue - bullsEyeGame.currentValue)
        var points = 100 - difference

            bullsEyeGame.score += points

        let title: String
        if difference == 0 {
          title = "Perfect!"
          points += 100
        } else if difference < 5 {
          title = "You almost had it!"
          if difference == 1 {
            points += 50
          }
        } else if difference < 10 {
          title = "Pretty good!"
        } else {
          title = "Not even close..."
        }

        let message = "You scored \(points) points"

        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let action = UIAlertAction(title: "OK", style: .default, handler: {
          action in
            self.bullsEyeGame.startNewRound()
            self.updateLabelsFromModel()
        })

        alert.addAction(action)

        present(alert, animated: true, completion: nil)

    }

    @IBAction func sliderMoved(_ slider: UISlider) {
        let roundedValue = bullsEyeGame.gameSlider.value.rounded()
        bullsEyeGame.currentValue = Int(roundedValue)
        print("Target value: \(bullsEyeGame.targetValue)")
        print("Slider value: \(slider.value)")
        
    }

    func updateLabelsFromModel() {
        targetLabel.text = String(bullsEyeGame.targetValue)
        scoreLabel.text = String(bullsEyeGame.score)
        roundLabel.text = String(bullsEyeGame.round)
        slider.value = bullsEyeGame.gameSlider.value

    }

    @IBAction func startNewGame() {
        bullsEyeGame.startNewRound()
        updateLabelsFromModel()
    }
  
}



