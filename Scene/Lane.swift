//
//  Lane.swift
//  Orbiting with rhythm
//
//  Created by user on 31/03/23.
//

import Foundation
import SpriteKit

enum PlanetType: String {
    case mars = "Mars"
    case earth = "Earth"
    case jupiter = "Jupiter"
}

class Lane: SKNode {
    
    var gamescene: GameScene
    
    var linha = SKShapeNode()
    var areaClique = SKShapeNode()
    var planetNode = SKSpriteNode()
    
    //var planet: PlanetNode?
    var notes: [Nota]?
    
    let planetType: PlanetType
    
    var flag: ((Int) -> ())?
    
    var mock = 0
    
    init(_ planet: PlanetType, gamescene: GameScene, mock: Int) {
        self.planetType = planet
        self.gamescene = gamescene
        self.mock = mock
        super.init()
        setupNodes()
        
        flag?(0)
        scene?.anchorPoint = .zero
        
        if mock == 1 {
            notes = Nota.mock1()
        } else if mock == 2 {
            notes = Nota.mock2()
        } else {
            notes = Nota.mock3()
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Ativa as interações no node, touchesbegan por exemplo
    override var isUserInteractionEnabled: Bool {
        get {
            return true
        }
        set {
            // ignore
        }
    }
    
    func setupNodes() {
        self.addChild(linha)
        self.addChild(areaClique)
        self.addChild(planetNode)
        
        linha.path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: 70, height: gamescene.size.height), cornerRadius: 64).cgPath
        linha.position = CGPoint(x: gamescene.frame.midX - 35, y: gamescene.size.height * 0.1)
        linha.fillColor = UIColor.gray
        linha.strokeColor = UIColor.blue
        linha.lineWidth = 3
        linha.zPosition = 1
        
        areaClique.path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: 70, height: 60), cornerRadius: 10).cgPath
        areaClique.position = CGPoint(x: linha.frame.midX - 35, y: gamescene.frame.midY * 0.60)
        areaClique.fillColor = UIColor.white
        areaClique.strokeColor = UIColor.blue
        areaClique.alpha = 0.2
        areaClique.lineWidth = 3
        areaClique.zPosition = 2
        
        planetNode.texture = SKTexture(imageNamed: planetType.rawValue)
        planetNode.size = CGSize(width: 100, height: 100)
        planetNode.position = CGPoint(x: gamescene.frame.midX, y: 100)
        planetNode.name = planetType.rawValue
        planetNode.zPosition = 3
    }
    
    func setupNotas(currentTime: TimeInterval) {
        
        let notasNesseTempo = notes?.filter({
            $0.initialTime == currentTime
        })
        
        notasNesseTempo!.forEach({ nota in
            let note = SKShapeNode()
            note.path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: 40, height: 40 * nota.duration), cornerRadius: 20).cgPath
            note.position = CGPoint(x: 15, y: linha.frame.maxY)
            note.fillColor = UIColor.green
            note.strokeColor = UIColor.yellow
            note.lineWidth = 5
            note.zPosition = 2
            linha.addChild(note)
            moveNode(node: note, duration: nota.duration)
           
        })
        
    }
    
    func moveNode(node: SKNode, duration: Double) {
        node.run(
            
            SKAction.sequence([
                SKAction.move(to: CGPoint(x: 13, y: 0), duration: duration)
            ])
            
        )
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        
        nodes(at: location).forEach { node in
            if node.name == planetType.rawValue {
                planetNode.run(SKAction.sequence([
                    SKAction.setTexture(SKTexture(imageNamed: "\(planetType.rawValue)Sing")),
                    SKAction.scale(by: 1.3, duration: 0.2)
                ]))
                areaClique.run(SKAction.sequence([
                    SKAction.run({
                        self.areaClique.alpha = 0.5
                    })
                ]))
                
                flag?(1)
            }
            
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        
        nodes(at: location).forEach { node in
            if node.name == planetType.rawValue {
                planetNode.run(SKAction.sequence([
                    SKAction.setTexture(SKTexture(imageNamed: planetType.rawValue)),
                    SKAction.scale(to: CGSize(width: 100, height: 100), duration: 0.2)
                ]))
                areaClique.run(SKAction.sequence([
                    SKAction.run({
                        self.areaClique.alpha = 0.2
                    })
                ]))
                
                flag?(0)
            }
            
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
    }
}
