//
//  GameScene.swift
//  IPong
//
//  Created by Ash on 07/07/2019.
//  Copyright © 2019 Ash. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var ball = SKSpriteNode()
    var enemy = SKSpriteNode()
    var user = SKSpriteNode()
    var score = [Int]()
    var topLabel = SKLabelNode()
    var bottomLabel = SKLabelNode()
    
    override func didMove(to view: SKView) {
        
        
        // Making the labels show the score
        topLabel = self.childNode(withName: "topLabel") as! SKLabelNode
        bottomLabel = self.childNode(withName: "bottomLabel") as! SKLabelNode
        
        // Connecting each entity to our project
        ball = self.childNode(withName: "ball") as! SKSpriteNode
        
        enemy = self.childNode(withName: "enemy") as! SKSpriteNode
        // take the half of the height of the frame
        enemy.position.y  = (self.frame.height / 2) - 50
        
        user = self.childNode(withName: "user") as! SKSpriteNode
        // take the + half of the height of the frame
        user.position.y = (-self.frame.height / 2) + 50
        
        
        // Adding a border to the frame of the scene
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        border.friction = 0
        border.restitution = 1
        
        self.physicsBody = border
        
        startGame()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // determine location by touching the screen using the "set<UITouch>".
        for touch in touches {
            let location = touch.location(in: self)
            
            if currentGameType == .player2 {
                // second player controls enemy
                if location.y > 0 {
                    // Enables the userto move with the ball but with a slight delay
                    enemy.run(SKAction.moveTo(x: location.x , duration: 0.1))
                }
                // other player controlls normal user
                if location.y < 0 {
                    // Enables the user to move with the ball but with a slight delay
                    user.run(SKAction.moveTo(x: location.x , duration: 0.1))
                }
            }
            else {
                // Enables the user to move with the ball but with a slight delay
                user.run(SKAction.moveTo(x: location.x , duration: 0.1))
            }
        }
    }
    
    // Update the user with a slight ball delay
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            if currentGameType == .player2 {
                // second player controls enemy
                if location.y > 0 {
                    // Enables the userto move with the ball but with a slight delay
                    enemy.run(SKAction.moveTo(x: location.x , duration: 0.1))
                }
                // other player controlls normal user
                if location.y < 0 {
                    // Enables the user to move with the ball but with a slight delay
                    user.run(SKAction.moveTo(x: location.x , duration: 0.1))
                }
            }
            else {
                // Enables the user to move with the ball but with a slight delay
                user.run(SKAction.moveTo(x: location.x , duration: 0.1))
            }
        }
    }
    
    // Update the enemy with ball delay
    override func update(_ currenTime: TimeInterval) {
        
        // determines duation based on current game type
        switch currentGameType {
        case .easy:
            // Make enemy move with the ball but with delay
            enemy.run(SKAction.moveTo(x: ball.position.x, duration: 1.0))
            break
        case .medium:
            // Make enemy move with the ball but with delay
            enemy.run(SKAction.moveTo(x: ball.position.x, duration: 0.6))
            break
        case .difficult:
            // Make enemy move with the ball but with delay
            enemy.run(SKAction.moveTo(x: ball.position.x, duration: 0.3))
            break
        case .player2:
            
            break
        }
        
        // Test variables when playing the game
        
        // Test the boundaries from the user and adding the score to the enemy if they won
        if ball.position.y <= user.position.y - 20 {
            addScore(playerWhoWon: enemy)
        }
            // Test the boundaries of the enemy and adding the score to the user if they won
        else if ball.position.y >= enemy.position.y + 20 {
            addScore(playerWhoWon: user)
        }
    }
    
    // Starts the game and resets the score
    func startGame() {
        score = [0,0]
        // Adding the score to the label, added the quotes as the score will change and wont be static.
        topLabel.text = "\(score[1])"
        bottomLabel.text = "\(score[0])"
        
        // Makes the ball move in a direction to start the game
        // Lanches at a 45* angle (change the CGVector for diffrent angles)
        ball.physicsBody?.applyImpulse(CGVector(dx: 10,dy: 10))
    }
    
    // reset ball positon and adding the score to the player who won.
    func addScore(playerWhoWon : SKSpriteNode) {
        
        // fixes the ball from having infinate inpulses.(puts back into centre of screen
        ball.position = CGPoint(x: 0, y: 0)
        ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        
        if playerWhoWon == user {
            score[0] += 1
            ball.physicsBody?.applyImpulse(CGVector(dx: 10,dy: 10))
        }
        else if playerWhoWon == enemy {
            score [1] += 1
            ball.physicsBody?.applyImpulse(CGVector(dx: -10,dy: -10))
        }
        // test for console
        //print(score)
        // Addes the score.
        topLabel.text = "\(score[1])"
        bottomLabel.text = "\(score[0])"
    }
}
