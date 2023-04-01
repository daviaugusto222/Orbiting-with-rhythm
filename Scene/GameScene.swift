//
//  GameScene.swift
//  Orbiting with rhythm
//
//  Created by user on 30/03/23.
//

import Foundation
import SpriteKit



class GameScene: SKScene {

    
    var jupiterLane: Lane!
    var planetNode = SKSpriteNode()

    var pontos = SKLabelNode(text: "Score: 0")
    var score = 0 {
        didSet {
            pontos.text = "Score: \(score)"
        }
    }
    
    public override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        jupiterLane = Lane(.jupiter)
        jupiterLane.setScale(0)
        
        nodesInitialSetup()
        repeatForeverActionsSetup()
        
    }
    
    func nodesInitialSetup() {
        self.addChild(jupiterLane)
        self.addChild(pontos)
        self.addChild(planetNode)
        
        jupiterLane.position = CGPoint(x: 0, y: 0)
        planetNode.texture = SKTexture(imageNamed: "Jupiter")
        planetNode.size = CGSize(width: 100, height: 100)
        planetNode.position = CGPoint(x: 0, y: 100)
        planetNode.name = "jupiter"
        
        pontos.horizontalAlignmentMode = .right
        pontos.position = CGPoint(x: frame.midX + 170, y: frame.midY + 100)
    }
    
    func repeatForeverActionsSetup() {
//        nota.run(
//            SKAction.repeatForever(
//                SKAction.sequence([
//                    SKAction.move(to: CGPoint(x: frame.midX - 20, y: frame.minY + 60), duration: 3),
//                    SKAction.wait(forDuration: 1),
//                    SKAction.move(to: CGPoint(x: frame.midX - 20, y: frame.maxY), duration: 0)
//                ])
//            )
//        )
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
    }
    
    var started: TimeInterval?
    
    public override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
        
//        if started == nil { started = currentTime }
//        print(currentTime, " - past time:", currentTime - started!)
        
//        let disInitial = planet.areaClique.frame.midY.distance(to: nota.frame.minY)
//        let disFinal = planet.areaClique.frame.midY.distance(to: nota.frame.maxY)
//        if planet.flag == 1 {
//            if disInitial <= 40 && disFinal >= -20 {
//                score += 1
//                nota.run(SKAction.run {self.nota.fillColor = .blue})
//            } else {
//                //score -= 1
//                nota.run(SKAction.run {self.nota.fillColor = .green})
//            }
//        }
    }
}
