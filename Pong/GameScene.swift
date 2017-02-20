//
//  GameScene.swift
//  Pong
//
//  Created by Steven Santiago on 2/12/17.
//  Copyright © 2017 Steven Santiago. All rights reserved.
//

import SpriteKit
import GameplayKit


var gameType: String! // Text from button will come in


class GameScene: SKScene {
    
    //var viewController: GameViewController!
    
    var ball = SKSpriteNode()
    var playerBlue = SKSpriteNode()
    var playerRed = SKSpriteNode()
    var redScore = SKLabelNode()
    var blueScore = SKLabelNode()
    
    var score = [Int]()
    var ballSpeed: Int!
    var enemyReaction = 0.6
    
    
    
    override func didMove(to view: SKView) {
        
        
        
        redScore = self.childNode(withName: "redScore") as! SKLabelNode
        blueScore = self.childNode(withName: "blueScore") as! SKLabelNode
        
        ball = self.childNode(withName: "ball") as! SKSpriteNode
        playerBlue = self.childNode(withName: "playerBlue") as! SKSpriteNode
        playerRed = self.childNode(withName: "playerRed") as! SKSpriteNode
        
        playerBlue.position.y = (self.frame.height/2) - 50
        blueScore.position.y = (self.frame.height/2) - 420
        playerRed.position.y = (-self.frame.height/2) + 50
        redScore.position.y = (-self.frame.height/2) + 420
        
        startGame()
        
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        
        border.friction = 0
        border.restitution = 1
        
        self.physicsBody = border
        
    }
    
    func startGame() {
        selectMode(gameType: gameType)
        score = [0,0]
        redScore.text = String(score[0])
        blueScore.text = String(score[1])
        ball.physicsBody?.applyImpulse(CGVector(dx: ballSpeed, dy: ballSpeed)) // applies intial ball push
    }
    
    func addScore(player:SKSpriteNode){
        ball.position = CGPoint(x:0,y:0)
        ball.physicsBody?.velocity = CGVector(dx:0,dy:0)
        if player == playerRed{
            score[0] += 1
            ball.physicsBody?.applyImpulse(CGVector(dx: ballSpeed , dy: ballSpeed ))
            
        } else {
            score[1] += 1
            ball.physicsBody?.applyImpulse(CGVector(dx: -ballSpeed, dy: -ballSpeed))
            
        }
        
        redScore.text = String(score[0])
        blueScore.text = String(score[1])
        
        
    }
    
    func selectMode(gameType: String){
        switch gameType {
        case "2 Players":
            ballSpeed = 20
        case "Easy":
            ballSpeed = 20
            enemyReaction = 1.0
        case "Medium":
            ballSpeed = 25
            enemyReaction = 0.9
        case "Hard":
            ballSpeed = 30
            enemyReaction = 0.75
        default:
            print(gameType)
            print("Invalid Mode")
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self) // grabs location of touch in view
            if gameType == "2 Players" {
                if location.y > 0{
                    playerBlue.run(SKAction.moveTo(x: location.x, duration: 0.2))
                }
                if location.y < 0 {
                    playerRed.run(SKAction.moveTo(x: location.x, duration: 0.2))
                }
            } else {
                
                playerRed.run(SKAction.moveTo(x: location.x, duration: 0.2))
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self) // grabs location of touch in view
            if gameType == "2 Players" {
                if location.y > 0{
                    playerBlue.run(SKAction.moveTo(x: location.x, duration: 0.2))
                }
                if location.y < 0 {
                    playerRed.run(SKAction.moveTo(x: location.x, duration: 0.2))
                }
            } else {
                
                playerRed.run(SKAction.moveTo(x: location.x, duration: 0.2))
            }
        }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        if gameType != "2 Players" {
        playerBlue.run(SKAction.moveTo(x: ball.position.x, duration: enemyReaction))
        }
        
        if ball.position.y <= playerRed.position.y - 18 {
            addScore(player: playerBlue)
            
            
        } else if ball.position.y >= playerBlue.position.y + 18 {
            addScore(player: playerRed)
        }
    }
}
