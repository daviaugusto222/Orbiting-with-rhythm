//
//  PlanetsView.swift
//  Orbiting with rhythm
//
//  Created by user on 30/03/23.
//

import Foundation
import SwiftUI
import SpriteKit

struct PlanetsView: View {
    
    func sizedScene(size: CGSize) -> SKScene {
        let scene = GameScene(size: size)
        scene.scaleMode = .resizeFill
        scene.anchorPoint = .zero
        return scene
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
//                SpriteView(scene: scene)
//                    .frame(width: width, height: height)
                SpriteView(scene: self.sizedScene(size: CGSize(width: geometry.size.width, height: geometry.size.height)))
                    .frame(width: geometry.size.width, height: geometry.size.height)
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct PlanetsView_Previews: PreviewProvider {
    static var previews: some View {
        PlanetsView()
    }
}
