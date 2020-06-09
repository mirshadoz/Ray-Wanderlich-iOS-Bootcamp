//
//  BullsEyeGame.swift
//  BullsEye
//
//  Created by Mirshad Oz on 6/9/20.
//  Copyright © 2020 Ray Wenderlich. All rights reserved.
//

import Foundation

class BullsEyeGame {
    
    var currentValue: Int
    var targetValue = BullsEyeGame.getTargetValue()
    var score: Int
    var round: Int
    var gameSlider = Slider(value: 0.0)
    
    
    static func getTargetValue() -> Int {
        return Int.random(in: 1...100)
    }
    
    init(currentValue: Int, score: Int, round: Int) {
        self.currentValue = currentValue
        self.score = score
        self.round = round
    }


    func startNewGame() {
        score = 0
        round = 0
        startNewRound()
    }

    func startNewRound() {
        round += 1
        targetValue = Int.random(in: 1...100)
        currentValue = 50
        gameSlider.value = Float(currentValue)
//        TODO: Add updateLabels() for UI
        //      updateLabels()
    }




    
}
