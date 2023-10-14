//
//  GameScene.swift
//  Solitaire
//
//  Created by Corinne Richter on 10/7/23.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var gameState = GameState()
    var gameBoard: GameBoard { GameBoard(gameState: gameState) }
    
    var movingCard: Card?
    
    
    override func didMove(to view: SKView) {
        
        addChild(gameBoard)
        if let movingCard {
            addChild(movingCard)
        }
        gameState.printStateOfThings()
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(tap))
        view.addGestureRecognizer(recognizer)
        
    }
    
    //
    //    func touchDown(atPoint pos : CGPoint) {
    //
    //    }
    //
    //    func touchMoved(toPoint pos : CGPoint) {
    //
    //    }
    //
    //    func touchUp(atPoint pos : CGPoint) {
    //
    //    }
    //
    //    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    //
    //        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    //    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let t = touches.first
        
        if let location = t?.location(in: self){
            let move = SKAction.move(to: location, duration: 0.0001)
            let nodeArray = self.nodes(at: location) //nodes touched
            
            if movingCard == nil { //sets moving card if no card currently grabbed
                if let n = nodeArray.first as? Card { //attempts to cast first touched node as card
                    if n.faceUp != false {
                        movingCard = nodeArray[0] as? Card //if touched node is card and accesable
                    }
                }
            }
            movingCard?.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            movingCard?.zPosition = 100 //ALWAYS on top
            movingCard?.run(move)
        }
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let t = touches.first
        var valid: Bool
        
        //        if let location = t?.location(in: self) {
        //            if location.y > 210  && location.y < 310 {
        //                valid = gameState.validateMove(movingCard: movingCard!, proposedDestination: <#T##CardPile#>)
        //            }
        //        }
        
        movingCard = nil
        print("END")
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        //let t = touches.first
        movingCard = nil
        
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    
    @objc func tap(recognizer: UIGestureRecognizer) {
        //responds to tap user input
        print("In tap")
        let viewLocation = recognizer.location(in: view)
        let sceneLocation = convertPoint(fromView: viewLocation)
        
        let nodeArray = self.nodes(at: sceneLocation)
        var offset: Double = 0.0
        //print("sceneLoc: \(nodeArray)")
        
        if let n = nodeArray.first as? Card { //attempts to cast touched node as card
            if n.location.pileType == .stock { //card is in stock, draws
                gameState.drawFromStock()
            } else { //card NOT the unflipped stock card
                let destination = gameState.tapToMove(card: n) //returns the pile to move and the x,y coridinates to move to
                if destination.1 != 0.0 { //if not 0.0 which tapToMove returns when no move avaliable
                    destination.0.addCard(newCard: n) //adds to pile
                    
                    if n.location.pileType == .tableau { //handles logic for moving out of tableau
                        let oldLoc = n.location
                        gameState.tableauPiles[n.location.pileNumber.rawValue].removeCard() //removes from old pile
                        gameState.tableauPiles[oldLoc.pileNumber.rawValue].contents.last?.flipCard() //flips next card
                    } else if n.location.pileType == .waste { //handles removing from waste pile
                        gameState.wastePile.removeCard()
                    }
                    
                    if destination.0.identity.pileType == .foundation { //position offset for accordian
                        offset = 0.0
                    } else {
                        offset = Double(destination.0.contents.count) * -15.0
                    }
                    print(destination.0.contents.count)
                    n.position = CGPoint(x: Double(destination.1), y: destination.2 + offset) //moves card, with appropriate offset
                    n.zPosition = CGFloat(destination.0.contents.count) //brings moved card to top
                    

                }
                n.location.pileType = destination.0.identity.pileType //updates card location
                n.location.pileNumber = destination.0.identity.pileNumber
            }
        } else { //no card
            for i in nodeArray {
                if let n = i as? PileView { //if selected node is a pile instead of card
                    if n.pileIdentity.pileType == .stock { //if pile is stock pile, thus empty
                        gameState.drawFromStock()
                    }
                }
            }
            
        }
        
        //        if (sceneLocation.x > 209 && sceneLocation.x < 280) && (sceneLocation.y < 310 && sceneLocation.y > 210 ) { //stock pile
        //            gameState.drawFromStock()
        //        }
        
        
        
        
        
        
        //        //let moveToAction = SKAction.move(to: sceneLocation, duration: 1)
        //        let moveByAction = SKAction.moveBy(x: (sceneLocation.x - label.position.x), y: (sceneLocation.y - label.position.y), duration: 0.5)
        //
        //        let moveByReversedAction = moveByAction.reversed()
        //        let moveByActions = [moveByAction, moveByReversedAction]
        //        let moveSequence = SKAction.sequence(moveByActions)
        //        let moveRepeatSequence = SKAction.repeat(moveSequence, count: 3)
        //
        //        label.run(moveRepeatSequence)
        //
        //
        //        //label.run(moveSequence)
        //        //label.run(moveByAction)
    }
}
