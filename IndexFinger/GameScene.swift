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
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    
    override func didMove(to view: SKView) {
        let backgroundTexture = SKTexture(imageNamed: "background")
        backgroundTexture.filteringMode = .nearest
        for i in 0...1 {
            print(i)
            let sprite = SKSpriteNode(texture: backgroundTexture, size: CGSize(width: self.frame.size.width, height: self.frame.size.width / backgroundTexture.size().width * backgroundTexture.size().height))
//            sprite.anchorPoint = CGPoint(x: 0, y: 0)
            sprite.position = CGPoint(x: 0, y: Int(sprite.size.height) * i)
            moveBackground(sprite: sprite, timer: 0.005)
            self.addChild(sprite)
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
}
