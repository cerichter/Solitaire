//
//  DrawPile.swift
//  Solitaire
//
//  Created by Corinne Richter on 10/7/23.
//

import SpriteKit

class PileView: SKNode {
    
    let pile: SKShapeNode
    var cards: [SKSpriteNode]
    var pileIdentity: PileIdentification
    
    init(xVal: CGFloat, yVal: CGFloat, cardStack: CardPile) {
        
        pile = SKShapeNode(rect: CGRect(x: xVal, y: yVal, width: 75, height: 105), cornerRadius: 10) //place for pile
        pile.strokeColor = .white
        pile.lineWidth = 3

        cards = cardStack.contents
        
        pileIdentity = cardStack.identity
        
        super.init()
        
        var offset:CGFloat = 0.0 //offset to accordian display the cards
        
        for c in cards { //renders card nodes
            if cardStack.identity.pileType == .tableau { //tableau
                c.position = CGPoint(x: xVal, y: yVal + (-15.0 * offset))
                c.zPosition = offset
                offset = offset + 1
            } else if cardStack.identity.pileType == .waste { //waste
                c.position = CGPoint(x: xVal + (-15.0 * offset), y: yVal)
                c.zPosition = offset
                offset = offset + 1
            } else if cardStack.identity.pileType == .stock || cardStack.identity.pileType == .foundation { //stock or foundation
                c.position = CGPoint(x: xVal, y: yVal)
            }
            pile.addChild(c)
        }
        addChild(pile)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
