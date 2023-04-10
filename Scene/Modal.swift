//
//  File.swift
//  
//
//  Created by user on 09/04/23.
//

import Foundation
import SpriteKit

class Modal: SKNode {
    
    var modal = SKShapeNode()
    var background = SKShapeNode()
    var retryButton = SKSpriteNode()
    var scoreLabel = SKLabelNode()
    var maxScoreLabel = SKLabelNode()
    
    var gamescene: GameScene
    
    var score: Int
    
    var goHome: ((Bool) -> ())?
    
    init(_ gamescene: GameScene, score: Int) {
        self.gamescene = gamescene
        self.score = score
        super.init()
        setupNodes()
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
    
        background = SKShapeNode(rect: CGRect(origin: .zero, size: CGSize(width: gamescene.frame.width, height: gamescene.frame.height)))
        background.fillColor = .white
        background.position = .zero
        background.alpha = 0.4
        background.zPosition = 6
        
        modal.path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: gamescene.frame.width * 0.7, height: gamescene.frame.height * 0.4), cornerRadius: 30).cgPath
        modal.position = CGPoint(x: (background.frame.width/2) - modal.frame.width/2, y: (background.frame.height/2) - modal.frame.height/2)
        modal.zPosition = 6
        modal.fillColor = UIColor.white
        modal.strokeColor = UIColor.blue
        modal.alpha = 1
        modal.lineWidth = 2
        
        maxScoreLabel = SKLabelNode(text: "Record: 648")
        maxScoreLabel.position = CGPoint(x: 120 , y: 200)
        maxScoreLabel.fontName = "Verdana-Bold"
        maxScoreLabel.fontSize = 16
        maxScoreLabel.fontColor = UIColor.blue
        
        scoreLabel = SKLabelNode(text: "Sua pontuação foi: \(score)")
        scoreLabel.position = CGPoint(x: 120 , y: 160)
        scoreLabel.fontName = "Verdana-Bold"
        scoreLabel.fontSize = 15
        scoreLabel.fontColor = UIColor.black
        
        retryButton = SKSpriteNode(texture: SKTexture(imageNamed: "go"), size: CGSize(width: modal.frame.width/2, height: 50))
        retryButton.position = CGPoint(x: modal.frame.midX - retryButton.size.width/2, y: 30)
        retryButton.name = "goButton"
        
        
        self.addChild(background)
        self.addChild(modal)
        modal.addChild(maxScoreLabel)
        modal.addChild(scoreLabel)
        modal.addChild(retryButton)
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        
        nodes(at: location).forEach { node in
            if node.name == "goButton" {
                print("go")
                ///Executar a ação de voltar para a home
                goHome?(true)
            }
        }
    }
    
}

