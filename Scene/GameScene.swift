//
//  GameScene.swift
//  Orbiting with rhythm
//
//  Created by user on 30/03/23.
//

import Foundation
import SpriteKit

public class GameScene: SKScene {

    var timeSeg: Double = 0.0
    var started: TimeInterval!
    var aux = 0.0
    
    var jupiterLane: Lane!
    var marsLane: Lane!
    var earthLane: Lane!

    var pontos = SKLabelNode(text: "Score: 0")
    var score = 0 {
        didSet {
            pontos.text = "Score: \(score)"
        }
    }
    
    public override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        self.scene?.anchorPoint = .zero
        
        nodesInitialSetup()
        repeatForeverActionsSetup()
    }
    
    func nodesInitialSetup() {
        
        self.addChild(pontos)
        
        jupiterLane = Lane(.jupiter, gamescene: self, mock: 1)
        marsLane = Lane(.mars, gamescene: self, mock: 2)
        earthLane = Lane(.earth, gamescene: self, mock: 3)
        
        jupiterLane.position = CGPoint(x: -130, y: 0)
        marsLane.position = CGPoint(x: 0, y: 0)
        earthLane.position = CGPoint(x: 130 , y: 0)
        
        self.addChild(jupiterLane)
        self.addChild(marsLane)
        self.addChild(earthLane)

        pontos.horizontalAlignmentMode = .right
        pontos.position = CGPoint(x: frame.midX, y: frame.midY)
        pontos.zPosition = 5
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
    
    
    
    public override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
        
        
        if started == nil { started = currentTime }
        
        timeSeg = (currentTime - started).rounded()
        
        if aux != timeSeg {
            aux = timeSeg
            jupiterLane.setupNotas(currentTime: aux)
            marsLane.setupNotas(currentTime: aux)
            earthLane.setupNotas(currentTime: aux)
            print("\(aux) ")
        }
        
        
       
        
        //let disInitial = jupiterLane.areaClique.frame.midY.distance(to: jupiterLane.nota.frame.minY)
        //let disFinal = jupiterLane.areaClique.frame.midY.distance(to: nota.frame.maxY)
        jupiterLane.flag = { flag in
            if (flag != 0) {
                print("apertei")
            } else {
                print("soltei")
            }
        }
        
//
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
