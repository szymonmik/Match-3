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
    private(set) var points: Int = 0
    private(set) var movesLeft: Int = 10
    var gemsPoped: Int = 0
    
    init(numberOfGems: Int, numberOfColors: Int, gemFactory: (Int) -> Color) {
        gems = []
        for i in 0..<numberOfGems {
            let color = gemFactory(Int.random(in: 0..<numberOfColors))
            gems.append(Gem(id: i, color: color))
        }
    }
    
    mutating func chooseGem(_ gem: Gem, doUpdate: Bool = false){
        
        if(doUpdate){
            if(movesLeft <= 0){
                return
            }
            gemsPoped = 1
            movesLeft -= 1
        }
        else{
            gemsPoped += 1
        }
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
            updateGems()
            points += gemsPoped*gemsPoped
        }
    }
    func findAvailableGemIndex(emptyGemId: Int) -> Int{
        var j = 8
        var indexToReturn = -1
        while(emptyGemId - j - 8 >= 0 && gems[emptyGemId - j].marked){
            j += 8
        }
        indexToReturn = emptyGemId - j
        print(indexToReturn)
        return indexToReturn
    }
    mutating func updateGems(){
        for i in 0..<gems.count {
            if (gems[i].marked) {
                gems[i].color = Color.white
            }

        }
        for i in 0..<gems.count {
            if(gems[gems.count - i - 1].marked && gems.count - i - 9 >= 0)
            {
                let indexToSwap = findAvailableGemIndex(emptyGemId: gems.count - i - 1)
                if(indexToSwap != -1){
                    gems.swapAt(gems.count - i - 1, indexToSwap)
                }
            }
        }
    }
    func checkAdjacentGems(){
        
    }
    mutating func shuffle(){
            gems.shuffle()
    }
    
}
