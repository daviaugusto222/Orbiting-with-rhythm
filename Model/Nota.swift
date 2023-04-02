//
//  Nota.swift
//  Orbiting with rhythm
//
//  Created by user on 31/03/23.
//

import Foundation
import SpriteKit

struct Nota {
    var initialTime: Double
    var duration: Double
    
    static func mock1() -> [Nota] {
        return [Nota(initialTime: 2.0, duration: 3.0), Nota(initialTime: 6.0, duration: 4.0), Nota(initialTime: 10.0, duration: 13.0)]
    }
    
    static func mock2() -> [Nota] {
        return [Nota(initialTime: 4.0, duration: 3.0), Nota(initialTime: 9.0, duration: 4.0), Nota(initialTime: 17.0, duration: 13.0)]
    }
    
    static func mock3() -> [Nota] {
        return [Nota(initialTime: 2.0, duration: 3.0), Nota(initialTime: 6.0, duration: 4.0), Nota(initialTime: 13.0, duration: 13.0)]
    }
}
