//
//  GameScene.swift
//  IndexFinger
//
//  Created by guo yi on 2020/4/27.
//  Copyright © 2020 sha jin. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    fileprivate var leftStone: SKNode?
    fileprivate var rightStone: SKNode?
    
    override func didMove(to view: SKView) {
        //  背景
        let backgroundTexture = SKTexture(imageNamed: "background")
        backgroundTexture.filteringMode = .nearest
        for i in 0...1 {
            let sprite = SKSpriteNode(texture: backgroundTexture, size: CGSize(width: self.frame.size.width, height: self.frame.size.width / backgroundTexture.size().width * backgroundTexture.size().height))
            sprite.position = CGPoint(x: 0, y: Int(sprite.size.height) * i)
            sprite.zPosition = 0
            moveBackground(sprite: sprite, timer: 0.005)
            self.addChild(sprite)
        }
        //  手指
        let fingerTexture = SKTexture(imageNamed: "finger")
        fingerTexture.filteringMode = .nearest
        for i in 0...1 {
            let sprite = IndexFingerSpriteNode(texture: fingerTexture, size: CGSize(width: 100, height: 100)) { state, type  in
                print(state, type)
                self.moveStone(fingerType: type, touchState: state)
            }
            sprite.type = i == 0 ? .left : .right
            sprite.isUserInteractionEnabled = true
            sprite.position = CGPoint(x: i == 0 ? self.frame.midX - self.frame.width / 4 : self.frame.midX + self.frame.width / 4,
                                      y: -self.frame.height/2 + sprite.size.height + 20)
            sprite.zPosition = 1
            self.addChild(sprite)
        }
        //  球
        for i in 0...1 {
            let sprite = SKShapeNode(circleOfRadius: 60)
            sprite.fillColor = SKColor.red
            sprite.position = CGPoint(x: i == 0 ? self.frame.midX - self.frame.width / 8 : self.frame.midX + self.frame.width / 8,
                                      y: 100)
            sprite.zPosition = 1
            self.addChild(sprite)
            if i == 0 {
                leftStone = sprite
            } else {
                rightStone = sprite
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}

extension GameScene {
    func moveBackground(sprite: SKSpriteNode, timer: CGFloat) {
        let moveGroupSprite = SKAction.moveBy(x: 0, y: -sprite.size.height, duration: TimeInterval(timer * sprite.size.height))
        let resetGroupSprite = SKAction.moveBy(x: 0, y: sprite.size.height, duration: 0)
        
        let moveGroupSpritesForever = SKAction.repeatForever(SKAction.sequence([moveGroupSprite, resetGroupSprite]))
        sprite.run(moveGroupSpritesForever)
    }
    
    func moveStone(fingerType: IndexFingerSpriteNode.IndexFingerType, touchState: IndexFingerSpriteNode.IndexFingerTouchState) {
        var targetPositionX: CGFloat = 0.0
        
        switch fingerType {
        case .left:
            switch touchState {
            case .touchBegan, .touchMoved:
                targetPositionX = self.frame.midX - self.frame.width / 8 * 3
                break
            case .touchEnded, .touchCancelled:
                targetPositionX = self.frame.midX - self.frame.width / 8
                break
            }
            break
        case.right:
            switch touchState {
            case .touchBegan, .touchMoved:
                targetPositionX = self.frame.midX + self.frame.width / 8 * 3
                break
            case .touchEnded, .touchCancelled:
                targetPositionX = self.frame.midX + self.frame.width / 8.0
                break
            }
            break
            
        default: break
        }
        
        let stone = fingerType == .left ? leftStone : rightStone
        let moveAction = SKAction.moveTo(x: targetPositionX, duration: 0.2)
        stone?.run(moveAction)
    }
}
