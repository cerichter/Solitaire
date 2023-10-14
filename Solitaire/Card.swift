//
//  Card.swift
//  Solitaire
//
//  Created by Corinne Richter on 10/7/23.
//

import Foundation
import SpriteKit


class Card: SKSpriteNode {
    
    static func == (lhs: Card, rhs: Card) -> Bool {
        if lhs.value == rhs.value {
            return true
        }
        return false
    }

    let value: Int
    var face: SKTexture
    var faceUp: Bool
    var location: PileIdentification
    
    init(value: Int ) {
        self.value = value
        self.face = SKTexture(imageNamed: "CardBack")
        self.faceUp = false
        self.location = PileIdentification(pileType: .stock, pileNumber: .zero)

        super.init(texture: face, color: .white, size: CGSize(width: 75.0, height: 105.0))
        
        anchorPoint = CGPoint(x: 0, y: 0)
        name = String(value)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func flipCard() {
        //flips card opposite of what is was before function call
        self.faceUp = !self.faceUp
        if self.faceUp {
            self.texture = SKTexture(imageNamed: String(value))
            //self.accesable = true
        }
        else {
            self.texture = SKTexture(imageNamed: "CardBack")
        }
    }
    
}
