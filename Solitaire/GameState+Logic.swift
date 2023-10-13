//
//  GameState+Logic.swift
//  Solitaire
//
//  Created by Corinne Richter on 10/9/23.
//

import Foundation

extension GameState {
    //functions that move cards between stacks
    func deal() {
        //deals out game
        deck.shuffle()
        
        tableauPiles[0].contents = [deck[0]] //distributes cards to tableau piles
        tableauPiles[1].contents = Array(deck[1...2])
        tableauPiles[2].contents = Array(deck[3...5])
        tableauPiles[3].contents = Array(deck[6...9])
        tableauPiles[4].contents = Array(deck[10...14])
        tableauPiles[5].contents = Array(deck[15...20])
        tableauPiles[6].contents = Array(deck[21...27])
        
        stockPile.contents = Array(deck[28...]) //puts rest of cards in stock
        wastePile.contents = []  //empty waste pile
        
        foundationPiles[0].contents = [] //empty foundation piles
        foundationPiles[1].contents = []
        foundationPiles[2].contents = []
        foundationPiles[3].contents = []
    
        tableauPiles[0].contents.last?.flipCard() //flipping top most card to be faceup
        tableauPiles[1].contents.last?.flipCard()
        tableauPiles[2].contents.last?.flipCard()
        tableauPiles[3].contents.last?.flipCard()
        tableauPiles[4].contents.last?.flipCard()
        tableauPiles[5].contents.last?.flipCard()
        tableauPiles[6].contents.last?.flipCard()
        
        
        //ensuring cards were correctly distributed
        assert(tableauPiles[0].contents.count == 1)
        assert(tableauPiles[1].contents.count == 2)
        assert(tableauPiles[2].contents.count == 3)
        assert(tableauPiles[3].contents.count == 4)
        assert(tableauPiles[4].contents.count == 5)
        assert(tableauPiles[5].contents.count == 6)
        assert(tableauPiles[6].contents.count == 7)
        
        assert(stockPile.contents.count == 24)
        assert(wastePile.contents.count == 0)
        
        assert(foundationPiles[0].contents.count == 0)
        assert(foundationPiles[1].contents.count == 0)
        assert(foundationPiles[2].contents.count == 0)
        assert(foundationPiles[3].contents.count == 0)
    }
    
    func drawFromStock(){
        //Moves a card from stock to waste
        //TO DO: add 3 draw capability
        if stockPile.contents.count == 0 { //all stock in waste
            stockPile.contents = wastePile.contents
            for c in stockPile.contents {
                c.flipCard()
            }
            wastePile.contents = []
        } else { //draw from stock
            let temp = stockPile.contents[0]
            stockPile.contents.removeFirst()
            wastePile.contents.append(temp)
            wastePile.contents.last?.flipCard()
        }
    }
    
    func validateMove(movingCard: Card, proposedDestination: CardPile) -> Bool {
        //ensures that the proposed movement is legal
        let movingSuit = Suit(rawValue: Int(floor(Double(movingCard.value)/13.0)))
        var movingValue: Int {(movingCard.value % 13)+1}
        
        let destinationSuit: Suit
        var destinationValue: Int
        
        if let destinationCount = proposedDestination.contents.last?.value { //destination is NOT an empty stack
            destinationSuit = Suit(rawValue: Int(floor(Double(destinationCount)/13.0))) ?? Suit(rawValue: 4)!
            destinationValue = (proposedDestination.contents.last!.value % 13)+1
        } else { //destination is an empty stack
            destinationSuit = Suit(rawValue: 4)!
            destinationValue = 52
        }
        
        switch(movingValue) {
        case 13: //KING movement
            if proposedDestination.identity.0 == 2 && destinationSuit.rawValue == 4 { //king moved to empty tableau
                return true
            } else if proposedDestination.identity.0 == 3 && destinationSuit.rawValue != 4 && proposedDestination.contents.last!.value == movingCard.value - 1 && destinationSuit == movingSuit { //king moved to foundation
                return true
            }
            return false
        case 1: //ACE movement
            if proposedDestination.identity.0 == 3 && proposedDestination.identity.1 == movingSuit?.rawValue { //ace moved to foundation
                return true
            } else if proposedDestination.identity.0 == 2 && (destinationSuit.isRed() != movingSuit?.isRed()) && destinationValue == 2 { //ace moved to tableau
                return true
            }
            return false
        default: // 2...12 movement
            if proposedDestination.identity.0 == 2 && (destinationSuit.isRed() != movingSuit?.isRed()) && destinationValue == movingValue + 1 { //card moved to tableau
                return true
            } else if proposedDestination.identity.0 == 3 && proposedDestination.identity.1 == movingSuit?.rawValue && destinationValue == movingValue - 1{ //moved to foundation
                return true
            }
            return false
        }
        
    }
    
    func moveCardInWorkingStacks(card: Card, originPile: CardPile, destinationPile: CardPile) {
        //Moves a card between working piles
    
        if validateMove(movingCard: card, proposedDestination: destinationPile) == false {
    
            print("nah bitch!!!!!! \(card.value), \(destinationPile.identity)")
            return
        }
        
        if originPile.identity == (1,0) { //if card is coming out of waste pile
            let loc: Int = originPile.contents.firstIndex(of: card) ?? 52 //set to illogical 52 loc if nil
            if loc != 52 {
                originPile.contents.remove(at: loc)
            } else {
                return
            }
        } else {
            //original pile is a tableau or foundation pile so we know that is the top most card
            originPile.contents.removeLast()
        }
        //add to destination pile in both cases
        destinationPile.contents.append(card)
    }
    
    func printStateOfThings() {
        
        print("Tableau: ")
        for p in tableauPiles {
            print("New Pile: \(p.identity)")
            for c in p.contents {
                print("\(c.value)", terminator: ", ")
            }
            print("\n")
        }
        print("Stock: \(stockPile.identity)")
        for c in stockPile.contents {
            print("\(c.value)", terminator: ", ")
        }
        print("\n")
        print("Waste: \(wastePile.identity)")
        for c in wastePile.contents {
            print("\(c.value)", terminator: ", ")
        }
        print("\n")
        print("Foundations")
        for p in foundationPiles {
            print("New Pile: \(p.identity)")
            for c in p.contents {
                print("\(c.value)", terminator: ", ")
            }
            print("\n")
        }
        
    }
    
    func testing() {
        //all tests run on an unshuffled deck
        
       printStateOfThings()
        
        //valid, move between tableau ------
        moveCardInWorkingStacks(card: tableauPiles[4].contents.last!, originPile: tableauPiles[4], destinationPile: tableauPiles[1]) //H2 on S3
        moveCardInWorkingStacks(card: tableauPiles[4].contents.last!, originPile: tableauPiles[4], destinationPile: tableauPiles[6]) //HA on C2
        moveCardInWorkingStacks(card: tableauPiles[0].contents.last!, originPile: tableauPiles[0], destinationPile: tableauPiles[1]) //SA on H2
        moveCardInWorkingStacks(card: tableauPiles[4].contents.last!, originPile: tableauPiles[4], destinationPile: tableauPiles[0]) //SK on empty T0
        
        assert( tableauPiles[0].contents[0].value == 12 )
        assert( tableauPiles[1].contents.last!.value  == 0 )
        assert( tableauPiles[6].contents.last!.value == 13 )
        
        //valid, move to waste ------
        drawFromStock()
        drawFromStock()
        drawFromStock()
        drawFromStock()
        drawFromStock()
        
        assert( wastePile.contents[0].value == 28 )
        assert( wastePile.contents[1].value == 29 )
        assert( wastePile.contents[2].value == 30 )
        assert( stockPile.contents[0].value == 33 )
        
        //valid, move to foundation ------
        moveCardInWorkingStacks(card: tableauPiles[6].contents.last!, originPile: tableauPiles[6], destinationPile: foundationPiles[1]) //ace
        moveCardInWorkingStacks(card: tableauPiles[1].contents.last!, originPile: tableauPiles[1], destinationPile: foundationPiles[0])
        moveCardInWorkingStacks(card: tableauPiles[1].contents.last!, originPile: tableauPiles[1], destinationPile: foundationPiles[1]) //2 on top of ace
        
        assert( foundationPiles[1].contents.count == 2 )
        
        //valid, move from waste ------
        moveCardInWorkingStacks(card: wastePile.contents.last!, originPile: wastePile, destinationPile: tableauPiles[5])
        
        assert( tableauPiles[5].contents.last!.value == 32 )
        
        //valid, move out of foundation
        moveCardInWorkingStacks(card: foundationPiles[1].contents.last!, originPile: foundationPiles[1], destinationPile: tableauPiles[1])
        assert( tableauPiles[1].contents.last!.value == 14 )
        
        //invalid, move between tableau ------
        moveCardInWorkingStacks(card: tableauPiles[0].contents.last!, originPile: tableauPiles[0], destinationPile: tableauPiles[1]) //king to non empty
        moveCardInWorkingStacks(card: tableauPiles[1].contents.last!, originPile: tableauPiles[1], destinationPile: tableauPiles[4]) //H2 on SQ
        moveCardInWorkingStacks(card: tableauPiles[2].contents.last!, originPile: tableauPiles[2], destinationPile: tableauPiles[5]) //S6 to C7
        
        assert( tableauPiles[1].contents.last!.value != 12 )
        assert( tableauPiles[4].contents.last!.value != 5 )
        
        
        //Invalid, move to foundation -----
        moveCardInWorkingStacks(card: tableauPiles[0].contents.last!, originPile: tableauPiles[0], destinationPile: foundationPiles[3]) //king to empty foundation
        
        
        assert( foundationPiles[3].contents.count == 0 )
        
        
    }
}
