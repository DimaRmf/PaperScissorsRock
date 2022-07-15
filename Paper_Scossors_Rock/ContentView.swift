//
//  ContentView.swift
//  Paper_Scossors_Rock
//
//  Created by Дима РМФ on 18.03.2022.
//

import SwiftUI

struct ContentView: View {
    
    let gameTools = ["Rock", "Scissors", "Paper"]
    let gameToolsEmoji = ["✂️", "🔖", "👊"]
    
    @State private var gameToolChoise = ""
    @State private var gameResultChoise = Bool.random()
    @State private var score = 0
    @State private var showAlert = false
    @State private var gameTool = ["Scissors", "Paper", "Rock"].randomElement()
    
    var resultChoise: String {
        if self.gameResultChoise == false {
            return "Lose"
        } else {
            return "Win"
        }
    }
    
    

    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.white, .mint]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            VStack(spacing: 30) {
                Text("App chooses \(gameTool ?? "") and you need to \(resultChoise)")
                VStack(spacing: 20){
                    ForEach(0 ..< gameTools.count) { tool in
                        Button(action: {
                            self.checkResult(tool, self.gameTools.firstIndex(of: self.gameTool ?? "")!)
                        }) {
                            gameButton(emojies: self.gameToolsEmoji[tool])
                        }
                    }
                }
                Text("Your score: \(score)")
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("You won!"), message: Text(""), dismissButton: .default(Text("Restart")))
        }
    }
    
    func logic(_ index: Int, _ gameTool: Int) {
        if gameResultChoise {
            if (gameTool == 0 && index == 1) || (gameTool == 1 && index == 2) || (gameTool == 2 && index == 0) {
                score += 1
            } else if index == gameTool {
                score -= 0
            } else {
                score -= 1
            }
        }
        restartGame()
    }
    func checkResult(_ i: Int, _ gameTool: Int) {
        logic(i, gameTool)
        if score == 10 {
            showAlert = true
            restartGame()
        }
    }
    
    func restartGame() {
        if score == 5 {
            showAlert = true
            score = 0
        }
        gameResultChoise = Bool.random()
        gameTool = ["Scissors", "Paper", "Rock"].randomElement()
    }
}

struct gameButton: View {
    var emojies: String
    var body: some View {
        Text(emojies)
            .frame(width: 150, height: 150)
            .font(.system(size: 60))
            .border(Color.black, width: 5)
            .cornerRadius(10)
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
