//
//  GameScene.swift
//  Orbiting with rhythm
//
//  Created by user on 30/03/23.
//

import Foundation
import SpriteKit

class GameScene: SKScene {

    var roundedTime: Double = 0.0
    var started: TimeInterval!
    var timeSeg = 0.0
    
    var contactUp1 = 0
    var contactUp2 = 0
    var contactUp3 = 0
    var flag1 = 0
    var flag2 = 0
    var flag3 = 0
    
    var jupiterLane: Lane!
    var marsLane: Lane!
    var earthLane: Lane!
    
    var modalEndTurn: Modal!

    var pontos = SKLabelNode(text: "P: 0")
    var score = 0 {
        didSet {
            pontos.text = "P: \(score)"
        }
    }
    
    public override func didMove(to view: SKView) {
        super.didMove(to: view)
        self.scene?.anchorPoint = .zero
        nodesInitialSetup()
        
        self.physicsWorld.contactDelegate = self
        self.view?.isMultipleTouchEnabled = true
        
        jupiterLane.flag = { flag1 in
            if flag1 == 1 {
                self.flag1 = 1
            } else {
                self.flag1 = 0
            }
        }
        
        marsLane.flag = { flag2 in
            if flag2 == 1 {
                self.flag2 = 1
            } else {
                self.flag2 = 0
            }
        }
//
        earthLane.flag = { flag3 in
            if flag3 == 1 {
                self.flag3 = 1
            } else {
                self.flag3 = 0
            }
        }
        
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
        pontos.position = CGPoint(x: frame.midX - 40, y: frame.midY)
        pontos.zPosition = 5
        
        
    }
    
    func endMusic() {
        modalEndTurn = Modal(self, score: score)
        modalEndTurn.position = .zero
        modalEndTurn.goHome = { arg in
            self.removeFromParent()
            self.removeAllChildren()
            let scene = GameScene()
            scene.scaleMode = .resizeFill
            self.view?.presentScene(scene)
                
            
            
        }
        self.addChild(modalEndTurn)
        
    }
 
    public override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
        
        
        if started == nil { started = currentTime }
        roundedTime = (currentTime - started).rounded()
        
        if timeSeg != roundedTime {
            timeSeg = roundedTime
            jupiterLane.setupNotas(currentTime: timeSeg)
            marsLane.setupNotas(currentTime: timeSeg)
            earthLane.setupNotas(currentTime: timeSeg)
            print("\(timeSeg) ")
            if timeSeg == 22.0 {
                endMusic()
            }
        }
        
        
        //verifica se esta clicando e se tem contato
        if self.contactUp1 == 1 && self.flag1 == 1 {
            self.score += 1
            jupiterLane.changeColor!(true)
            
        } else if self.contactUp1 == 0 && self.flag1 == 1 {
            self.score -= 1
            
        }
        
        if self.contactUp2 == 1 && self.flag2 == 1 {
            self.score += 1
            marsLane.changeColor!(true)
        } else if self.contactUp2 == 0 && self.flag2 == 1 {
            self.score -= 1
        }
        
        if self.contactUp3 == 1 && self.flag3 == 1 {
            self.score += 1
            earthLane.changeColor!(true)
        } else if self.contactUp3 == 0 && self.flag3 == 1 {
            self.score -= 1
        }
    }
}

extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyB.node?.name == jupiterLane.planetType.rawValue && contact.bodyA.node?.name == "area"  {
            self.contactUp1 = 1
        }
        if contact.bodyB.node?.name == marsLane.planetType.rawValue && contact.bodyA.node?.name == "area"  {
            self.contactUp2 = 1
        }
        if contact.bodyB.node?.name == earthLane.planetType.rawValue && contact.bodyA.node?.name == "area"  {
            self.contactUp3 = 1
        }
    }
    
    func didEnd(_ contact: SKPhysicsContact) {
        if contact.bodyB.node?.name == jupiterLane.planetType.rawValue && contact.bodyA.node?.name == "area" {
            self.contactUp1 = 0
        }
        if contact.bodyB.node?.name == marsLane.planetType.rawValue && contact.bodyA.node?.name == "area" {
            self.contactUp2 = 0
        }
        if contact.bodyB.node?.name == earthLane.planetType.rawValue && contact.bodyA.node?.name == "area" {
            self.contactUp3 = 0
        }
    }
}
