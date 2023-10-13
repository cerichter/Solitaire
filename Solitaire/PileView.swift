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
    
    init(xVal: CGFloat, yVal: CGFloat, cardStack: CardPile) {
        
        pile = SKShapeNode(rect: CGRect(x: xVal, y: yVal, width: 75, height: 105), cornerRadius: 10) //place for pile
        pile.strokeColor = .white
        pile.lineWidth = 3
    
        cards = cardStack.contents
        
        super.init()
        
        var offset:CGFloat = 0.0 //offset to accordian display the cards
        
        for c in cards { //renders card nodes
            if cardStack.identity.0 == 2 { //tableau
                c.position = CGPoint(x: xVal, y: yVal + (-15.0 * offset))
                c.zPosition = offset
                offset = offset + 1
            } else if cardStack.identity.0 == 1 { //waste
                c.position = CGPoint(x: xVal + (-15.0 * offset), y: yVal)
                c.zPosition = offset
                offset = offset + 1
            } else if cardStack.identity.0 == 0 || cardStack.identity.0 == 3 { //stock or foundation
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
