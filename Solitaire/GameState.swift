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
    var savedPositions = pilePositions()
    
    init() {
        //creates deck of cards and emprty piles
        deck = [Card(value: 0)] //creating deck of cards
        for i in 1...51 {
            self.deck.append(Card(value: i))
        }
        
        tableauPiles = [ //empty tableau piles
            CardPile(contents: [], identity: PileIdentification(pileType: .tableau, pileNumber: .zero)),
            CardPile(contents: [], identity: PileIdentification(pileType: .tableau, pileNumber: .one)),
            CardPile(contents: [], identity: PileIdentification(pileType: .tableau, pileNumber: .two)),
            CardPile(contents: [], identity: PileIdentification(pileType: .tableau, pileNumber: .three)),
            CardPile(contents: [], identity: PileIdentification(pileType: .tableau, pileNumber: .four)),
            CardPile(contents: [], identity: PileIdentification(pileType: .tableau, pileNumber: .five)),
            CardPile(contents: [],identity: PileIdentification(pileType: .tableau, pileNumber: .six))
        ]
        stockPile = CardPile(contents: [], identity: PileIdentification(pileType: .stock, pileNumber: .zero)) //empty stock
        wastePile = CardPile(contents: [], identity: PileIdentification(pileType: .waste, pileNumber: .zero)) //empty waste pile
        foundationPiles = [ //empty foundation piles
            CardPile(contents: [], identity: PileIdentification(pileType: .foundation, pileNumber: .zero)),
            CardPile(contents: [], identity: PileIdentification(pileType: .foundation, pileNumber: .one)),
            CardPile(contents: [], identity: PileIdentification(pileType: .foundation, pileNumber: .two)),
            CardPile(contents: [], identity: PileIdentification(pileType: .foundation, pileNumber: .three))
        ]
        
        deal()
        
    }
    
    
}
