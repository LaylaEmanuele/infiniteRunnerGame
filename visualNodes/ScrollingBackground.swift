//
//  ScrollingBackground.swift
//  BridgeRunGame
//
//  Created by Victor Brito on 17/06/21.
//

import Foundation
import SpriteKit

class ScrollingBackground: SKSpriteNode {

    public var velocity: CGFloat = 10.0
    //Todas as imagens tem o mesmo tamanho
    public var backgroundImagesNames = [String]()

    public func configureScrollingBackground() {
        color = .clear
        
        for i in 0...backgroundImagesNames.count - 1 {
            let node = SKSpriteNode(imageNamed: backgroundImagesNames[i])
            let texture = SKTexture(imageNamed: backgroundImagesNames[i])
            texture.filteringMode = .nearest

            let multiplier = node.size.width / node.size.height
            node.size = CGSize(width: size.height * multiplier, height: size.height)

            node.anchorPoint = CGPoint(x: 0, y: node.anchorPoint.y)
            node.position = CGPoint(x: -self.size.width/2 + CGFloat(i) * node.size.width, y: node.position.y)
            addChild(node)
        }
    }

    public func update(currentTime: TimeInterval) {
        for node in children {
            guard let sprite = node as? SKSpriteNode else { return }

            sprite.position = CGPoint(x: node.position.x - velocity, y: node.position.y)

            if sprite.position.x + sprite.size.width <= -self.size.width/2 {
                let delta = sprite.position.x + sprite.size.width
                sprite.position.x = sprite.size.width * CGFloat(children.count - 1) + delta
            }
        }
    }

}

