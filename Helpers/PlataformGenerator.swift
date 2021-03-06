//
//  PlataformGenerator.swift
//  BridgeRunGame
//
//  Created by Victor Brito on 17/06/21.
//

import Foundation
import SpriteKit
import GameplayKit

class PlatformsGenerator {

    private let kMaxPlatformsOnScreen = 8
    private let kMinSpace: Int = 140

    private let randomDistribPlatformWidth = GKRandomDistribution(lowestValue: 150, highestValue: 500)
    private let randomDistribPlatformPositionX = GKRandomDistribution(lowestValue: 0, highestValue: 300)
    private let randomDistribPlatformPositionY = GKRandomDistribution(lowestValue: -250, highestValue: 90)

    private var platforms = [Platform]()
    private var parentNode = SKSpriteNode()

    public func configurePlatformsNode(size: CGSize) -> SKSpriteNode {
        parentNode = SKSpriteNode(color: .clear, size: size)

        return parentNode
    }

    public func updatePlatform(velocity: CGFloat) {
        generatePlatformsFor(parentNode: parentNode)

        for platform in platforms {
            let platformRightPoint = platform.frame.origin.x + platform.frame.size.width
            let parentNodeLeftSize = parentNode.position.x - parentNode.frame.size.width/2
            if platformRightPoint < parentNodeLeftSize {
                if let index = platforms.firstIndex(of: platform) {
                    platform.removeFromParent()
                    platforms.remove(at: index)
                }
            } else {
                platform.position = CGPoint(x: platform.position.x - velocity,
                                            y: platform.position.y)
            }
        }
    }

    private func generatePlatformsFor(parentNode: SKSpriteNode) {
        //gerador de plataforma e lugares dentro dos nodes
        if platforms.count < kMaxPlatformsOnScreen {

            guard let platform = createPlatform() else { return }

            platform.position = calculateRandomPlatformPosition()
            platforms.append(platform)
            parentNode.addChild(platform)
        }
    }

    private func createPlatform() -> Platform? {
        let randomSize = calculateRandomPlatformSize()

        let platform = Platform(color: .platformColor(), size: randomSize)
        platform.configure()
        platform.setScale(0.90) //Aqui ele defini o tamanho da plataforma

        return platform
    }

    private func calculateRandomPlatformSize() -> CGSize {
        let platformWidth = CGFloat(randomDistribPlatformWidth.nextInt())

        return CGSize(width: platformWidth,
                      height: kPlatformHeight)
    }

    private func calculateRandomPlatformPosition() -> CGPoint {
        let lastPlatform = platforms.last

        if let lPlatform = lastPlatform {
            let startPoint = lPlatform.frame.origin.x + lPlatform.frame.size.width
            return CGPoint(x: randomDistribPlatformPositionX.nextInt() + Int(startPoint) + kMinSpace,
                           y: randomDistribPlatformPositionY.nextInt() + kMinSpace)
        } else {
            return CGPoint(x: randomDistribPlatformPositionX.nextInt() + Int(parentNode.frame.size.width),
                           y: randomDistribPlatformPositionY.nextInt())
        }
    }

}
