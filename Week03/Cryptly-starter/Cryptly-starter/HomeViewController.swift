/// Copyright (c) 2020 Razeware LLC
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import UIKit

class HomeViewController: UIViewController, Themeable {  

  @IBOutlet weak var view1: UIView!
  @IBOutlet weak var view2: UIView!
  @IBOutlet weak var view3: UIView!
  @IBOutlet weak var headingLabel: UILabel!
  @IBOutlet weak var view1TextLabel: UILabel!
  @IBOutlet weak var view2TextLabel: UILabel!
  @IBOutlet weak var view3TextLabel: UILabel!
  @IBOutlet weak var themeSwitch: UISwitch!
  
  let cryptoData = DataGenerator.shared.generateData()
    
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
    setupLabels()
    setView1Data()
    setView2Data()
    setView3Data()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    registerForTheme()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    unregisterForTheme()
  }

  func setupViews() {
      
    view1.backgroundColor = .systemGray6
    view1.layer.borderColor = UIColor.lightGray.cgColor
    view1.layer.borderWidth = 1.0
    view1.layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
    view1.layer.shadowOffset = CGSize(width: 0, height: 2)
    view1.layer.shadowRadius = 4
    view1.layer.shadowOpacity = 0.8
    
    view2.backgroundColor = .systemGray6
    view2.layer.borderColor = UIColor.lightGray.cgColor
    view2.layer.borderWidth = 1.0
    view2.layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
    view2.layer.shadowOffset = CGSize(width: 0, height: 2)
    view2.layer.shadowRadius = 4
    view2.layer.shadowOpacity = 0.8
    
    view3.backgroundColor = .systemGray6
    view3.layer.borderColor = UIColor.lightGray.cgColor
    view3.layer.borderWidth = 1.0
    view3.layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
    view3.layer.shadowOffset = CGSize(width: 0, height: 2)
    view3.layer.shadowRadius = 4
    view3.layer.shadowOpacity = 0.8
  }
  
  func setupLabels() {
    headingLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
    view1TextLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
    view2TextLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
  }
  
  func getStringFromCryptoArray(for cryptoArray: [CryptoCurrency]) -> String {
    var namesOfCrypto: String?
        
    namesOfCrypto = cryptoArray.reduce("") { (total, crypto) -> String in
    total + crypto.name + ","
    }.dropLast().replacingOccurrences(of: ",", with: ", ")
    
    if let cryptoNames = namesOfCrypto {
      return cryptoNames
    } else {
      return "Error!"
    }
    
  }
  
  func setView1Data() {
    if let cryptoDataArray = cryptoData {
        view1TextLabel.text = getStringFromCryptoArray(for: cryptoDataArray)
    }
  }
  
  func isIncreased(for currentValue: Double, for previousValue: Double) -> Bool {
    let difference = currentValue - previousValue

    return difference > 0 ? true : false
  }

  
  func setView2Data() {
    var increasedCrypto: [CryptoCurrency] = []
    
    if let cryptoDataArray = cryptoData {
      increasedCrypto = cryptoDataArray.filter({ (crypto) -> Bool in
        isIncreased(for: crypto.currentValue, for: crypto.previousValue)
      })
      
      view2TextLabel.text = getStringFromCryptoArray(for: increasedCrypto)
    }
    
    
  }
  
  func setView3Data() {
    var decreasedCrypto: [CryptoCurrency] = []
    
    if let cryptoDataArray = cryptoData {
      decreasedCrypto = cryptoDataArray.filter({ (crypto) -> Bool in
        !isIncreased(for: crypto.currentValue, for: crypto.previousValue)
      })
      
      view3TextLabel.text = getStringFromCryptoArray(for: decreasedCrypto)
    }
  }
  
  @IBAction func switchPressed(_ sender: Any) {
    themeSwitch.isOn ? ThemeManager.shared.set(theme: DarkTheme()) : ThemeManager.shared.set(theme: LightTheme())
  }
  
  func registerForTheme() {
    NotificationCenter.default.addObserver(self, selector: #selector(themeChanged), name: Notification.Name.init("themeChanged"), object: nil)

  }
  
  func unregisterForTheme() {
    NotificationCenter.default.removeObserver(self)
  }
  
  @objc func themeChanged() {
    view1.backgroundColor = ThemeManager.shared.currentTheme?.widgetBackgroundColor
    view2.backgroundColor = ThemeManager.shared.currentTheme?.widgetBackgroundColor
    view3.backgroundColor = ThemeManager.shared.currentTheme?.widgetBackgroundColor

    //    Todo:
    //     Set the layer’s border color to the current theme’s borderColor:
    

    
    view1TextLabel.textColor = ThemeManager.shared.currentTheme?.textColor
    view2TextLabel.textColor = ThemeManager.shared.currentTheme?.textColor
    view3TextLabel.textColor = ThemeManager.shared.currentTheme?.textColor
    
    self.view.backgroundColor = ThemeManager.shared.currentTheme?.backgroundColor
    
    
  }
  
  
  
}


