//
//  ContentView.swift
//  RockPaperScissorsWin
//
//  Created by Josh Hrach on 12/30/19.
//  Copyright © 2019 Random Projects, LLC. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var currentMove: Move = Move.allCases.randomElement()!
    @State private var shouldWin = Bool.random()
    @State private var score = 0
    
    @State private var showEndOfGame = false
    
    var body: some View {
        VStack(spacing: 50) {
            VStack {
                Text("Your Score: \(score)")
                    .font(.title)
                
                Text("Computer threw \(currentMove.rawValue)")
                    .font(.largeTitle)
                
                Text("Play to \(shouldWin ? "win" : "lose")!")
                    .font(.largeTitle)
            }
            
            VStack(spacing: 10) {
                ForEach(Move.allCases, id: \.self) { move in
                    Button(action: {
                        if move != self.currentMove {
                            self.playerChose(move)
                        }
                    }) {
                        Text(move.rawValue)
                            .frame(width: 150, height: 50)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .overlay(RoundedRectangle(cornerRadius: 20).stroke(lineWidth: 1))
                            .disabled(move == self.currentMove)
                    }
                }
            }
        }
        .alert(isPresented: $showEndOfGame) {
            Alert(title: Text("Game Over"), message: Text("You finally won!"), dismissButton: .default(Text("New Game"), action: {
                self.score = 0
                self.nextRound()
            }))
        }
    }
    
    
    func playerChose(_ move: Move) {
        let outcome = move.outcome(against: currentMove)
        
        if (outcome == .win && shouldWin) || (outcome == .lose && !shouldWin) {
            // Won! Get a point
            updateScore(by: 1)
        } else {
            // Lost
            updateScore(by: -1)
        }
        
        if score < 10 {
            nextRound()
        } else {
            showEndOfGame = true
        }
    }
    
    
    private func updateScore(by amount: Int) {
        score += amount
    }
    
    
    private func nextRound() {
        currentMove = Move.allCases.randomElement()!
        shouldWin = Bool.random()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

enum Move: String, CaseIterable {
    case rock = "Rock"
    case paper = "Paper"
    case scissors = "Scissors"
//
//    func beats(_ move: Move) -> Bool {
//        return Move.move(self, beats: move)
//    }
    
    func outcome(against move: Move) -> Outcome {
//        if Move.move(self, beats: move) {
//            return .win
//        } else if Move.move(self, losesTo: move) {
//            return .lose
//        } else {
//            return .tie
//        }
        Move.outcome(for: self, against: move)
    }
    
    static func outcome(for move: Move, against otherMove: Move) -> Outcome {
        switch (move, otherMove) {
        case (.rock, .scissors), (.scissors, .paper), (.paper, .rock):
            return .win
        case (.scissors, .rock), (.paper, .scissors), (.rock, .paper):
                return .lose
        default:
            return .tie
        }
    }
    
//    static func move(_ move: Move, beats otherMove: Move) -> Bool {
//        switch (move, otherMove) {
//        case (.rock, .scissors), (.scissors, .paper), (.paper, .rock):
//            return true
//        default:
//            return false
//        }
//    }
//
//    static func move(_ move: Move, losesTo otherMove: Move) -> Bool {
//        switch (move, otherMove) {
//        case (.scissors, .rock), (.paper, .scissors), (.rock, .paper):
//            return true
//        default:
//            return false
//        }
//    }
}

enum Outcome {
    case win
    case lose
    case tie
}
