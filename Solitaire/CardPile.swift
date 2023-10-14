//
//  CardPile.swift
//  Solitaire
//
//  Created by Corinne Richter on 10/7/23.
//

import Foundation

class CardPile {
    
    var contents: [Card]
    var identity: PileIdentification
    
    init(contents: [Card], identity: PileIdentification){
        
        self.contents = contents
        self.identity = identity
    }
    
    func addCard(newCard: Card) {
        //adds new card to stack
        contents.append(newCard)
    }
    
    func removeCard() {
        //removes card from stack
        contents.removeLast()
    }
    
}
