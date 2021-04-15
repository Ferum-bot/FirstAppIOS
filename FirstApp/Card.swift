//
//  Card.swift
//  FirstApp
//
//  Created by Матвей Попов on 15.04.2021.
//

import Foundation


struct Card {
    
    var id: Int32 = generateId()
    
    var isFaceUp: Bool = false
    var isMatched: Bool = false
    
    private static var avaliableId: Int32 = -1
    
    private static func generateId() -> Int32 {
        avaliableId += 1
        return avaliableId
    }
}
