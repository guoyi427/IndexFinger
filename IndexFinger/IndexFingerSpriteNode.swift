//
//  IndexFingerSpriteNode.swift
//  IndexFinger
//
//  Created by 郭毅 on 2020/4/28.
//  Copyright © 2020 sha jin. All rights reserved.
//

import SpriteKit

class IndexFingerSpriteNode: SKSpriteNode {
    enum IndexFingerTouchState {
        case touchBegan
        case touchMoved
        case touchEnded
        case touchCancelled
    }
    
    enum IndexFingerType {
        case unknow
        case left
        case right
    }
    
    public var type: IndexFingerType = .unknow
    
    fileprivate var _touchCallback: ((_ state: IndexFingerTouchState, _ type: IndexFingerType) -> Void)?
    
    public convenience init(texture: SKTexture?, size: CGSize, touchCallback: @escaping (_ state: IndexFingerTouchState, _ type: IndexFingerType) -> Void) {
        self.init(texture: texture, size: size)
        _touchCallback = touchCallback
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let callback = _touchCallback else { return }
        callback(.touchBegan, type)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let callback = _touchCallback else { return }
        callback(.touchMoved, type)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let callback = _touchCallback else { return }
        callback(.touchEnded, type)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let callback = _touchCallback else { return }
        callback(.touchCancelled, type)
    }
}
