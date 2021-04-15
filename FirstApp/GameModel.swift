//
//  GameModel.swift
//  FirstApp
//
//  Created by Матвей Попов on 15.04.2021.
//

import Foundation

protocol GameModelController {
    func onCardStatusChanged(at pos: Int32, card: Card)
}

class GameModel {
    
    var cardsArray = [Card]()
    
    var indexOfOneAndOnlyUpCard: Int32? = nil
    
    var cardStatusCallback: GameModelController?
    
    init(numberOfPairsCard: Int32, cardStatusCallback: GameModelController? = nil) {
        for _ in 1...numberOfPairsCard {
            let card = Card()
            cardsArray += [card, card]
        }
        cardsArray.shuffle()
        self.cardStatusCallback = cardStatusCallback
    }
    
    func chooseCard(at index: Int32) -> Void {
        if cardsArray[Int(index)].isMatched {
           return
        }
        if let matchingIndex = indexOfOneAndOnlyUpCard, matchingIndex != index {
            if (cardsArray[Int(matchingIndex)].id == cardsArray[Int(index)].id) {
                cardsArray[Int(matchingIndex)].isMatched = true
                cardsArray[Int(index)].isMatched = true
                self.cardStatusCallback?.onCardStatusChanged(at: matchingIndex, card: cardsArray[Int(matchingIndex)])
            }
            cardsArray[Int(index)].isFaceUp = true
            self.cardStatusCallback?.onCardStatusChanged(at: index, card: cardsArray[Int(index)])
            indexOfOneAndOnlyUpCard = nil
        }
        else {
            for flipDown in cardsArray.indices {
                cardsArray[flipDown].isFaceUp = false
                self.cardStatusCallback?.onCardStatusChanged(at: Int32(flipDown), card: cardsArray[Int(flipDown)])
            }
            cardsArray[Int(index)].isFaceUp = true
            self.cardStatusCallback?.onCardStatusChanged(at: index, card: cardsArray[Int(index)])
            indexOfOneAndOnlyUpCard = index
        }
    }
    
}
