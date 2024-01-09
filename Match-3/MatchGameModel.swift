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
    
    mutating func chooseGem(_ gem: Gem, doUpdate: Bool = false){
        if let chosenGemIndex = gems.firstIndex(where: {$0.id == gem.id}){
            gems[chosenGemIndex].marked = true
            
            if (chosenGemIndex-1 >= 0 
                && chosenGemIndex % 8 != 0
                && gems[chosenGemIndex-1].color == gem.color
                && !gems[chosenGemIndex-1].marked){
                chooseGem(gems[chosenGemIndex-1])
            }
            if (chosenGemIndex+1 < gems.count
                && chosenGemIndex % 8 != 7
                && gems[chosenGemIndex+1].color == gem.color
                && !gems[chosenGemIndex+1].marked){
                chooseGem(gems[chosenGemIndex+1])
            }
            if (chosenGemIndex-8 >= 0 
                && gems[chosenGemIndex-8].color == gem.color
                && !gems[chosenGemIndex-8].marked){
                chooseGem(gems[chosenGemIndex-8])
            }
            if (chosenGemIndex+8 < gems.count 
                && gems[chosenGemIndex+8].color == gem.color
                && !gems[chosenGemIndex+8].marked){
                chooseGem(gems[chosenGemIndex+8])
            }
        }
        
        if (doUpdate) {
            for i in 0..<gems.count {
                if (gems[i].marked) {
                    gems[i].color = Color.white
                }
            }
        }
    }
    
    mutating func shuffle(){
            gems.shuffle()
    }
    
}
