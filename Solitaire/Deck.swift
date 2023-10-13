//
//  Deck.swift
//  Solitaire
//
//  Created by Corinne Richter on 10/7/23.
//

import Foundation

class Deck {
    
    var deck: [Card]
    
    init() {
        //Creates deck of standard cards
        deck = [Card(value: 0)]
        for i in 1...51 {
            self.deck.append(Card(value: i))
        }
        //does the first shuffle
        shuffle()
    }
    
    func shuffle() {
        //shuffles the deck of cards
        deck.shuffle()
    }
}
