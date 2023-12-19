//
//  ContentView.swift
//  Match-3
//
//  Created by Szymon Mikolajczuk on 10/12/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var showingAlert = false
    
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
            Divider()
            Spacer()
            //Game area
            LazyVGrid(columns: columns, spacing: 5) {
                ForEach(viewModel.getGems) { gem in
                    GemView(gem: gem)
                        .aspectRatio(1, contentMode: .fit) 
                }
            }
            .animation(.default, value: viewModel.getGems)
            
            // ---
            Spacer()
            Divider()
            score
                .padding(5)
            Button("Restart game"){
                showingAlert = true
            }
            .alert("Are you sure you want to restart game?", isPresented: $showingAlert) {
                Button("Restart", role: .cancel){
                    viewModel.restart()
                    viewModel.shuffle()
                }
                Button("Cancel", role: .destructive){}
            }
        }
        .padding()
    }
    
    var gameTitle: some View {
        HStack{
            Text("Match")
            Image(systemName: "3.square.fill")
                .imageScale(.large)
                
        }
        .foregroundStyle(
            LinearGradient(colors: [.red, .indigo], startPoint: .top, endPoint: .bottom)
        )
        .font(.system(size: 32, weight: .heavy))
    }
    
    var score: some View {
        Text("Score: 0")
            .font(.system(size: 22, weight: .heavy))
    }
}

#Preview {
    ContentView(viewModel: MatchGameViewModel())
}
