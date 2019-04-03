//
//  GameScene.swift
//  Bamboo Breakout
/**
 * Copyright (c) 2016 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */ 

import SpriteKit

let BallCategoryName = "ball"
let PaddleCategoryName = "paddle"
let BlockCategoryName = "block"
let GameMessageName = "gameMessage"


class GameScene: SKScene {
    var isFingerOnPaddle = false
  
  override func didMove(to view: SKView) {
    super.didMove(to: view)
    let borderBody = SKPhysicsBody(edgeLoopFrom: self.frame)
    borderBody.friction = 0
    self.physicsBody = borderBody
    
    physicsWorld.gravity = CGVector(dx: 0.0, dy: 0.0)
    
    let ball = childNode(withName: BallCategoryName) as! SKSpriteNode
    ball.physicsBody!.applyImpulse(CGVector(dx: 2.0, dy: -2.0))
  }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        let touch = touches.first
        let touchLocation = touch!.location(in: self)
        
        if let body = physicsWorld.body(at: touchLocation){
            if body.node!.name == PaddleCategoryName{
                print("began touch on the paddle")
                isFingerOnPaddle = true
            }
            
            
            
        }
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?){
        
        if isFingerOnPaddle {
        
        let touch = touches.first
        let touchLocation = touch!.location(in: self)
        let previousLocation = touch!.previousLocation(in: self)
        
        let paddle = childNode(withName: PaddleCategoryName) as! SKSpriteNode
        
        var paddleX = paddle.position.x + (touchLocation.x - previousLocation.x)
        
        paddleX = max(paddleX, paddle.size.width/2)
        paddleX = min(paddleX, size.width - paddle.size.width/2)
        
        paddle.position = CGPoint(x: paddleX, y: paddle.position.y)
        }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?){
        isFingerOnPaddle = false
    }
  
}
