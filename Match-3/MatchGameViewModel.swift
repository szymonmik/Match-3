//
//  MatchGameViewModel.swift
//  Match-3
//
//  Created by student on 19/12/2023.
//

import Foundation
import SwiftUI

class MatchGameViewModel: ObservableObject {
    private static let colors: [Color] = [.blue, .red, .green, .yellow, .purple, .orange]
    
    @Published private var model: MatchGameModel = createMatchGameModel()
    
    private static func createMatchGameModel() -> MatchGameModel {
        return MatchGameModel(numberOfGems: 80, numberOfColors: colors.count, gemFactory: { index in
            return colors[index]
        })
    }
    
    var getGems: Array<Gem>{
        return model.gems
    }
    
    func chooseGem(gem: Gem, doUpdate: Bool){
        model.chooseGem(gem, doUpdate: doUpdate)
    }
    
    func shuffle(){
        model.shuffle()
    }
    
    func restart(){
        model = MatchGameViewModel.createMatchGameModel()
    }
}
