//
//  Lane.swift
//  Orbiting with rhythm
//
//  Created by user on 31/03/23.
//

import Foundation
import SpriteKit

enum PlanetType {
    case mars
    case earth
    case jupiter
}

class Lane: SKNode {
    
    var linha = SKShapeNode()
    var areaClique = SKShapeNode()
    var planetNode = SKSpriteNode()
    
    //var planet: PlanetNode?
    var notes: [Nota]?
    
    let planetType: PlanetType
    
    var flag: Int = 0
    
    init(_ planet: PlanetType) {
        self.planetType = planet
        super.init()
        setupNodes()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupNodes() {
        
        
        self.addChild(linha)
        self.addChild(areaClique)
        self.addChild(planetNode)
        
        linha.path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: 100, height: 100), cornerRadius: 64).cgPath
        linha.position = CGPoint(x: 0, y: 0)
        linha.fillColor = UIColor.red
        linha.strokeColor = UIColor.blue
        linha.lineWidth = 5
        
        //        nota.path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: 40, height: 140), cornerRadius: 20).cgPath
        //        nota.position = CGPoint(x: frame.midX - 20, y: frame.maxY)
        //        nota.fillColor = UIColor.green
        //        nota.strokeColor = UIColor.yellow
        //        nota.lineWidth = 5
        
        areaClique.path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: frame.width * 0.30, height: 60), cornerRadius: 10).cgPath
        areaClique.position = CGPoint(x: frame.midX * 0.70, y: frame.midY * 0.60)
        areaClique.fillColor = UIColor.white
        areaClique.strokeColor = UIColor.gray
        areaClique.alpha = 0.2
        areaClique.lineWidth = 3
        
        planetNode.texture = SKTexture(imageNamed: "Jupiter")
        planetNode.size = CGSize(width: 100, height: 100)
        planetNode.position = CGPoint(x: 0, y: 100)
        planetNode.name = "jupiter"
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.run(SKAction.sequence([
            //            SKAction.setTexture(singTexture),
            SKAction.scale(by: 1.3, duration: 0.2)
        ]))
        
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        
        nodes(at: location).forEach { node in
            
            areaClique.run(SKAction.sequence([
                SKAction.run({
                    self.areaClique.alpha = 0.5
                })
            ]))
            
            flag = 1
            
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        
        nodes(at: location).forEach { node in
            
            self.run(SKAction.sequence([
                SKAction.setTexture(SKTexture(imageNamed: "Jupiter")),
                SKAction.scale(to: CGSize(width: 100, height: 100), duration: 0.2)
            ]))
            areaClique.run(SKAction.sequence([
                SKAction.run({
                    self.areaClique.alpha = 0.2
                })
            ]))
            
            flag = 0
            //nota.run(SKAction.run {self.nota.fillColor = .green})
            
            
        }
    }
}
