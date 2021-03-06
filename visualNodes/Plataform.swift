//
//  Plataform.swift
//  BridgeRunGame
//
//  Created by Victor Brito on 17/06/21.
//

import Foundation
import SpriteKit

class Platform: SKSpriteNode {
    
    private let kCoinMargin: CGFloat = 0

    public func configure() {
        physicsBody = SKPhysicsBody(rectangleOf: frame.size)
        physicsBody?.isDynamic = false
        physicsBody?.categoryBitMask = kIceCategory
        physicsBody?.collisionBitMask = 0
        physicsBody?.contactTestBitMask = kPlayerCategory

        generateCoins()
    }

    private func generateCoins() {
        var coins = [Coin]()

        let numberOfCoins = Int(self.frame.width / (kCoinWidthHeight + kCoinMargin)) - 1

        if numberOfCoins < 0 {
            return
        }

        for _ in 0...numberOfCoins {
            let coin = Coin(imageNamed: "Coin")
            let texture = SKTexture(imageNamed: "Coin")
            texture.filteringMode = .nearest
            coin.setScale(0.5)
            
            coin.size = CGSize(width: kCoinWidthHeight, height: kCoinWidthHeight)
            coin.configure()

            coins.append(coin)

            addChild(coin)
        }

        let coinBlock = CGFloat(numberOfCoins) * kCoinWidthHeight + kCoinMargin * (CGFloat(numberOfCoins) - 1) + CGFloat(kCoinMargin)
        let sideMargin = (frame.width - coinBlock) / 2

        for i in 0...numberOfCoins {
            let coin = coins[i]

            let margin = sideMargin + kCoinWidthHeight * CGFloat(i) + kCoinMargin * CGFloat(i) - frame.width / 2
            coin.position = CGPoint(x: margin, y: kCoinWidthHeight / 2 + frame.height / 2)
        }
    }
    
}
