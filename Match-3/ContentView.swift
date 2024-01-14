//
//  ContentView.swift
//  Match-3
//
//  Created by Szymon Mikolajczuk on 10/12/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var showingAlert = false
    @State private var gameEndAlert = false
    @ObservedObject var viewModel: MatchGameViewModel
    
    let columns = [GridItem(.flexible()),
                   GridItem(.flexible()),
                   GridItem(.flexible()),
                   GridItem(.flexible()),
                   GridItem(.flexible()),
                   GridItem(.flexible()),
                   GridItem(.flexible()),
                   GridItem(.flexible())]
    
    var body: some View {
        VStack {
            gameTitle
            score
                .padding(5)
            highScore
            Spacer()
            Divider()
            //Game area
            LazyVGrid(columns: columns, spacing: 5) {
                ForEach(viewModel.getGems) { gem in
                    GemView(gem: gem)
                        .aspectRatio(1, contentMode: .fit)
                        .onTapGesture {
                            viewModel.chooseGem(gem: gem, doUpdate: true)
                            if(viewModel.getMovesLeft <= 0){
                                gameEndAlert = true
                            }
                        }
                }.animation(.default, value: viewModel.getGems)
            }
            
            Spacer()
            Divider()
            // ---
            movesLeft
            Spacer()
            Divider()
            Button("Restart game"){
                showingAlert = true
            }
            .alert("Are you sure you want to restart game?", isPresented: $showingAlert) {
                Button("Restart", role: .cancel){
                    viewModel.restart()
                    viewModel.shuffle()
                }
                Button("Cancel", role: .destructive){}
            }.alert("Game over!\n Do you want to play again?", isPresented: $gameEndAlert) {
                Button("Yes", role: .cancel){
                    viewModel.restart()
                    viewModel.shuffle()
                }
                Button("No", role: .destructive){}
            }
        }
        .padding()
    }
    
    var gameTitle: some View {
        HStack{
            Text("Color Matcher")
            Image(systemName: "paintpalette.fill")
                .imageScale(.large)
                
        }
        .foregroundStyle(
            LinearGradient(colors: [.red, .indigo], startPoint: .top, endPoint: .bottom)
        )
        .font(.system(size: 36, weight: .heavy))
    }
    
    var score: some View {
        Text("Score: \(viewModel.getPoints)")
            .font(.system(size: 32, weight: .heavy))
    }
    var highScore: some View{
        Text("High score: \(viewModel.highScore)")
            .font(.system(size: 20, weight: .heavy)).foregroundColor(Color.gray)
    }
    var movesLeft: some View {
        Text("Moves left: \(viewModel.getMovesLeft)")
            .font(.system(size: 28, weight: .heavy))
    }

}

#Preview {
    ContentView(viewModel: MatchGameViewModel())
}
