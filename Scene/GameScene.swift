//
//  GameScene.swift
//  Orbiting with rhythm
//
//  Created by user on 30/03/23.
//

import Foundation
import SpriteKit

class GameScene: SKScene {

    var planet = SKSpriteNode()
    var linha = SKShapeNode()
    var nota = SKShapeNode()
    var areaClique = SKShapeNode()
    var pontos = SKLabelNode(text: "Score: 0")
    var score = 0 {
        didSet {
            pontos.text = "Score: \(score)"
        }
    }
    var flag: Int = 0
    
    public override func didMove(to view: SKView) {
        super.didMove(to: view)
        nodesInitialSetup()
        repeatForeverActionsSetup()
    }
    
    func nodesInitialSetup() {
        self.addChild(linha)
        self.addChild(nota)
        self.addChild(planet)
        self.addChild(areaClique)
        self.addChild(pontos)
        
        pontos.horizontalAlignmentMode = .right
        pontos.position = CGPoint(x: frame.midX + 170, y: frame.midY + 100)
        
        linha.path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: 50, height: 900), cornerRadius: 64).cgPath
        linha.position = CGPoint(x: frame.midX - 25, y: 60)
        linha.fillColor = UIColor.red
        linha.strokeColor = UIColor.blue
        linha.lineWidth = 5
        
        nota.path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: 40, height: 140), cornerRadius: 20).cgPath
        nota.position = CGPoint(x: frame.midX - 20, y: frame.maxY)
        nota.fillColor = UIColor.green
        nota.strokeColor = UIColor.yellow
        nota.lineWidth = 5
        
        planet.texture = SKTexture(imageNamed: "Jupiter")
        planet.size = CGSize(width: 100, height: 100)
        planet.position = CGPoint(x: self.frame.midX, y: 100)
        planet.name = "jupiter"
        
        areaClique.path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: frame.width * 0.30, height: 60), cornerRadius: 10).cgPath
        areaClique.position = CGPoint(x: frame.midX * 0.70, y: frame.midY * 0.60)
        areaClique.fillColor = UIColor.white
        areaClique.strokeColor = UIColor.gray
        areaClique.alpha = 0.2
        areaClique.lineWidth = 3
    }
    
    func repeatForeverActionsSetup() {
        nota.run(
            SKAction.repeatForever(
                SKAction.sequence([
                    SKAction.move(to: CGPoint(x: frame.midX - 20, y: frame.minY + 60), duration: 3),
                    SKAction.wait(forDuration: 1),
                    SKAction.move(to: CGPoint(x: frame.midX - 20, y: frame.maxY), duration: 0)
                ])
            )
        )
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        
        nodes(at: location).forEach { node in
            if node.name == "jupiter" {
                planet.run(SKAction.sequence([
                    SKAction.setTexture(SKTexture(imageNamed: "JupiterSing")),
                    SKAction.scale(by: 1.3, duration: 0.2)
                ]))
                areaClique.run(SKAction.sequence([
                    SKAction.run({
                        self.areaClique.alpha = 0.5
                    })
                ]))
                
                flag = 1
            }
        }
        
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        
        nodes(at: location).forEach { node in
            if node.name == "jupiter" {
                planet.run(SKAction.sequence([
                    SKAction.setTexture(SKTexture(imageNamed: "Jupiter")),
                    SKAction.scale(to: CGSize(width: 100, height: 100), duration: 0.2)
                ]))
                areaClique.run(SKAction.sequence([
                    SKAction.run({
                        self.areaClique.alpha = 0.2
                    })
                ]))
                
                flag = 0
                nota.run(SKAction.run {self.nota.fillColor = .green})
                
            }
        }
    }
    
    public override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
        let disInitial = areaClique.frame.midY.distance(to: nota.frame.minY)
        let disFinal = areaClique.frame.midY.distance(to: nota.frame.maxY)
        if flag == 1 {
            if disInitial <= 40 && disFinal >= -20 {
                score += 1
                nota.run(SKAction.run {self.nota.fillColor = .blue})
            } else {
                //score -= 1
                nota.run(SKAction.run {self.nota.fillColor = .green})
            }
        }
    }
}
