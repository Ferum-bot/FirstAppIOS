//
//  ViewController.swift
//  FirstApp
//
//  Created by Матвей Попов on 08.04.2021.
//

import UIKit

class ViewController: UIViewController, GameModelController {
    
    func onCardStatusChanged(at pos: Int32, card: Card) {
        let button = buttonCollection[Int(pos)]
        if (card.isFaceUp) {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiCoolection.count)))
            if let emoji = emojiDictionary[Int(card.id)] {
                button.setTitle(emoji, for: .normal)
            }
            else {
                let emoji = emojiCoolection.remove(at: randomIndex)
                emojiDictionary[Int(card.id)] = emoji
                button.setTitle(emoji, for: .normal)
            }
            button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
        else {
            button.setTitle("", for: .normal)
            button.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
        if (card.isMatched) {
            buttonCollection[Int(pos)].backgroundColor = #colorLiteral(red: 0, green: 0.5628422499, blue: 0.3188166618, alpha: 1)
            buttonCollection[Int(pos)].isEnabled = false
            button.setTitle("", for: .normal)
            return
        }
    }
    
    
    @IBOutlet var buttonCollection: [UIButton]!
    
    @IBOutlet weak var touchCounterLabel: UILabel!
    
    var emojiCoolection: Array<String> = [
        "🐸", "🐽", "🐷", "🐮", "🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐻‍❄️", "🐨", "🐯", "🦁",
    ]
    
    var emojiDictionary = [Int:String]()
    
    var touchesNumber: Int32 = 0 {
        
        didSet {
            touchCounterLabel.text = "Touches: \(touchesNumber)"
        }
        
    }
    
    lazy var game = GameModel(
        numberOfPairsCard: Int32(buttonCollection.count + 1) / 2,
        cardStatusCallback: self
    )
    
    @IBAction func onButtonClicked(_ sender: UIButton) {
        let button = buttonCollection.firstIndex(of: sender)!
        game.chooseCard(at: Int32(button))
    }
    
    private func flipButton(emoji: String, button: UIButton) {
        if (button.currentTitle == emoji) {
            button.setTitle("", for: .normal)
            button.backgroundColor = #colorLiteral(red: 0.1921568662, green: 0.007843137719, blue: 0.09019608051, alpha: 1)
        } else {
            button.setTitle(emoji, for: .normal)
            button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
    
    }
}

