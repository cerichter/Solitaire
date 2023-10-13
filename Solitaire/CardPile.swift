//
//  CardPile.swift
//  Solitaire
//
//  Created by Corinne Richter on 10/7/23.
//

import Foundation

class CardPile {
    
    var contents: [Card]
    var identity: (Int, Int) //0 = stock, 1 = waste, 2 = tableau, 3 = foundation
    
    init(contents: [Card]){
        
        self.contents = contents
        self.identity = (2,0)
    }
    
    func addCard(newCard: Card) {
        //adds new card to stack
        contents.insert(newCard, at: 0)
    }
    
    func removeCard() {
        //removes card from stack
        contents.removeFirst()
    }
    
}
