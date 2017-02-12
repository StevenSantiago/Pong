//
//  GameScene.swift
//  Pong
//
//  Created by Steven Santiago on 2/12/17.
//  Copyright © 2017 Steven Santiago. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var ball = SKSpriteNode()
    var playerBlue = SKSpriteNode()
    var playerRed = SKSpriteNode()
    var redScore = SKLabelNode()
    var blueScore = SKLabelNode()
    
    var score = [Int]()
    
    
    
    override func didMove(to view: SKView) {
        startGame()
        
        redScore = self.childNode(withName: "redScore") as! SKLabelNode
        blueScore = self.childNode(withName: "blueScore") as! SKLabelNode
        
        ball = self.childNode(withName: "ball") as! SKSpriteNode
        playerBlue = self.childNode(withName: "playerBlue") as! SKSpriteNode
        playerRed = self.childNode(withName: "playerRed") as! SKSpriteNode
        
        playerBlue.position.y = (self.frame.height/2) - 50
        blueScore.position.y = (self.frame.height/2) - 20
        playerRed.position.y = (-self.frame.height/2) + 50
        redScore.position.y = (-self.frame.height/2) + 20
        
        ball.physicsBody?.applyImpulse(CGVector(dx: 20, dy: 20))
        
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        
        border.friction = 0
        border.restitution = 1
        
        self.physicsBody = border
        
    }
    
    func startGame() {
        score = [0,0]
        redScore.text = String(score[0])
        blueScore.text = String(score[1])
    }
    
    func addScore(player:SKSpriteNode){
        ball.position = CGPoint(x:0,y:0)
        ball.physicsBody?.velocity = CGVector(dx:0,dy:0)
        if player == playerRed{
            score[0] += 1
            ball.physicsBody?.applyImpulse(CGVector(dx: 20, dy: 20))

        } else {
            score[1] += 1
            ball.physicsBody?.applyImpulse(CGVector(dx: -20, dy: -20))

        }
        
        redScore.text = String(score[0])
        blueScore.text = String(score[1])

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self) // grabs location of touch in view
            playerRed.run(SKAction.moveTo(x: location.x, duration: 0.2))
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self) // grabs location of touch in view
            playerRed.run(SKAction.moveTo(x: location.x, duration: 0.2))
        }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        playerBlue.run(SKAction.moveTo(x: ball.position.x, duration: 0.6))
        
        if ball.position.y <= playerRed.position.y - 20 {
            addScore(player: playerBlue)
            
        } else if ball.position.y >= playerBlue.position.y + 20 {
            addScore(player: playerRed)
        }
    }
}
