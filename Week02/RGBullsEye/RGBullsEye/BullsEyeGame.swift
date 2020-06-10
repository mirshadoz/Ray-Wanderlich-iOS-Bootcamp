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

import Foundation

class BullsEyeGame {  // might be class?
    var round: Int
    var score: Int
    var redSliderValue = 128.0
    var greenSliderValue = 128.0
    var blueSliderValue = 128.0
    var randomRed: Float = 0
    var randomGreen: Float = 0
    var randomBlue: Float = 0
    var rgb = RGB()

    var difference = 0.0
    
    init(round: Int, score: Int) {
        self.round = round
        self.score = score
    }
    
    func startNewRound() {
        round += 1
        randomRed = generateRandomColor()
        randomGreen = generateRandomColor()
        randomBlue = generateRandomColor()
        rgb.r = Int(randomRed)
        rgb.g = Int(randomGreen)
        rgb.b = Int(randomBlue)

    }
    
    func generateRandomColor() -> Float {
        let colorNumber = Int.random(in: 1...255)
        return Float(colorNumber)
    }
    
    func calculatePoints() {
        let points = (1 - calculateDifference()) * 100
                        
        score += Int(points.rounded())
        
    }
    
    func calculateDifference() -> Double{
        let guessRGB = RGB(r: Int(redSliderValue), g: Int(greenSliderValue), b: Int(blueSliderValue))
        
        return rgb.difference(target: guessRGB)
    }




    
    
}
