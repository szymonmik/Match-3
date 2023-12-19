//
//  MatchGameModel.swift
//  Match-3
//
//  Created by student on 19/12/2023.
//

import Foundation
import SwiftUI

struct MatchGameModel {
    private(set) var gems: Array<Gem>
    
    init(numberOfGems: Int, numberOfColors: Int, gemFactory: (Int) -> Color) {
        gems = []
        for i in 0..<numberOfGems {
            let color = gemFactory(Int.random(in: 0..<numberOfColors))
            gems.append(Gem(id: i, color: color))
        }
    }
    
    mutating func shuffle(){
            gems.shuffle()
    }
    
}
