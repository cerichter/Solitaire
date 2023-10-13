//
//  GameBoard.swift
//  Solitaire
//
//  Created by Corinne Richter on 10/7/23.
//

import SpriteKit

class GameBoard: SKNode {
    
    var stockPileView: PileView
    var wastePileView: PileView
    var foundationPileViews: [PileView]
    var tableauPileViews: [PileView]
    
    var topRowNodes: SKNode
    var bottomRowNodes: SKNode
    
    init(gameState: GameState) {
        
        topRowNodes = SKNode()
        bottomRowNodes = SKNode()
        
        foundationPileViews = [
            PileView(xVal: -300, yVal: 260, cardStack: gameState.foundationPiles[0]),
            PileView(xVal: -217.5, yVal: 260, cardStack: gameState.foundationPiles[1]),
            PileView(xVal: -132.5, yVal: 260, cardStack: gameState.foundationPiles[2]),
            PileView(xVal: -47.5, yVal: 260, cardStack: gameState.foundationPiles[3])
        ]
        
        
        wastePileView = PileView(xVal: 126.5, yVal: 260, cardStack: gameState.wastePile)
        stockPileView = PileView(xVal: 211.5, yVal: 260, cardStack: gameState.stockPile)
    
        tableauPileViews = [
            PileView(xVal: -300.5, yVal: 100, cardStack: gameState.tableauPiles[0]),
            PileView(xVal: -215.5, yVal: 100, cardStack: gameState.tableauPiles[1]),
            PileView(xVal: -130.5, yVal: 100, cardStack: gameState.tableauPiles[2]),
            PileView(xVal: -45.5, yVal: 100, cardStack: gameState.tableauPiles[3]),
            PileView(xVal: 39.5, yVal: 100, cardStack: gameState.tableauPiles[4]),
            PileView(xVal: 124.5, yVal: 100, cardStack: gameState.tableauPiles[5]),
            PileView(xVal: 209.5, yVal: 100, cardStack: gameState.tableauPiles[6])
        ]
        
        super.init()
        
        
        topRowNodes.addChild(foundationPileViews[0])
        topRowNodes.addChild(foundationPileViews[1])
        topRowNodes.addChild(foundationPileViews[2])
        topRowNodes.addChild(foundationPileViews[3])
        

        topRowNodes.addChild(wastePileView)
        topRowNodes.addChild(stockPileView)
        


        bottomRowNodes.addChild(tableauPileViews[0])
        bottomRowNodes.addChild(tableauPileViews[1])
        bottomRowNodes.addChild(tableauPileViews[2])
        bottomRowNodes.addChild(tableauPileViews[3])
        bottomRowNodes.addChild(tableauPileViews[4])
        bottomRowNodes.addChild(tableauPileViews[5])
        bottomRowNodes.addChild(tableauPileViews[6])
      
        addChild(topRowNodes)
        addChild(bottomRowNodes)
        
        zPosition = -1
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showDeal() {
        
        
        
        
    }
    
}
