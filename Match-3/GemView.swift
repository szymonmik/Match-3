//
//  GemView.swift
//  Match-3
//
//  Created by student on 19/12/2023.
//

import SwiftUI

struct GemView: View {
    let gem: Gem
    
    var body: some View {
        RoundedRectangle(cornerRadius: 6).fill(gem.color)
    }
}

#Preview {
    GemView(gem: Gem(id: 1, color: .red))
}
