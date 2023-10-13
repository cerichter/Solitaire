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
    
    var movingCard: Card = Card.init(value: 52)
    

    override func didMove(to view: SKView) {
        
        addChild(gameBoard)
        addChild(movingCard)
        gameState.printStateOfThings()
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(tap))
        view.addGestureRecognizer(recognizer)
        
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            
            movingCard.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            movingCard.zPosition = 100 //ALWAYS on top
            
            let location = t.location(in: self)
            let move = SKAction.move(to: location, duration: 0.0001)
            self.touchMoved(toPoint: t.location(in: self))
            
            movingCard = self.nodes(at: location)
//            if location.x > -300.5 && location.x < 217.5 {  WRONG, left off here
//
//                movingCard = gameState.tableauPiles[0].contents.popLast() ?? Card.init(value: 52)
//
//            }
            
            movingCard.run(move)
            //gameBoard.tableauPiles[0].pile.run(move)
            
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    
    @objc func tap(recognizer: UIGestureRecognizer) {

        let viewLocation = recognizer.location(in: view)
        let sceneLocation = convertPoint(fromView: viewLocation)
        
        if (sceneLocation.x > 209 && sceneLocation.x < 280) && (sceneLocation.y < 310 && sceneLocation.y > 210 ) { //stock pile
            gameState.drawFromStock()
        }

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
