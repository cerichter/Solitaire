//
//  GameBoard.swift
//  Solitaire
//
//  Created by Corinne Richter on 10/7/23.
//

import Foundation

class GameState {
    //this class holds the cards and their positions (stock, waste, foundation, or tableau)
    var stockPile: CardPile //the pile from which cards are drawn
    var wastePile: CardPile //the pile to which the above cards go
    var foundationPiles: [CardPile] //the 4 piles built up from aces
    var tableauPiles: [CardPile] //the 7 working piles
    
    var deck: [Card]
    
    init() {
        //creates deck of cards and emprty piles
        deck = [Card(value: 0)] //creating deck of cards
        for i in 1...51 {
            self.deck.append(Card(value: i))
        }
        
        tableauPiles = [ //empty tableau piles
            CardPile( contents: [] ),
            CardPile( contents: [] ),
            CardPile( contents: [] ),
            CardPile( contents: [] ),
            CardPile( contents: [] ),
            CardPile( contents: [] ),
            CardPile( contents: [] )
        ]
        stockPile = CardPile( contents: [] ) //empty stock
        wastePile = CardPile(contents: [] ) //empty waste pile
        foundationPiles = [ //empty foundation piles
            CardPile(contents: []),
            CardPile(contents: []),
            CardPile(contents: []),
            CardPile(contents: [])
        ]
        
        //assigning identities
        stockPile.identity = (0,0)
        wastePile.identity = (1,0)
        
        foundationPiles[0].identity = (3,0)
        foundationPiles[1].identity = (3,1)
        foundationPiles[2].identity = (3,2)
        foundationPiles[3].identity = (3,3)
        
        tableauPiles[0].identity = (2,0)
        tableauPiles[1].identity = (2,1)
        tableauPiles[2].identity = (2,2)
        tableauPiles[3].identity = (2,3)
        tableauPiles[4].identity = (2,4)
        tableauPiles[5].identity = (2,5)
        tableauPiles[6].identity = (2,6)
        
        deal()

    }
    

}
