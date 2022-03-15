//
//  ContentView.swift
//  ScissorsPaperStone
//
//  Created by MacBook Air on 2022/3/14.
//

import SwiftUI

struct ContentView: View {
    @State private var options = ["✂️", "📄", "🪨"]
    @State private var winOrLose = Bool.random()
    @State private var correctOption = Int.random (in: 0...2)
    @State private var score = 0
    @State private var frequency = 0
    
    @State private var gameOver = false
    
    var body: some View {
        VStack {
            Spacer()
            Text("\(winOrLose ? "Win" : "Lose") the game.")
            Text("\(options[correctOption])")
                .font(.system(size: 52))
            Spacer()
            Text("Your score is \(score)")
            Spacer()
            VStack() {
                ForEach(0..<3) { num in
                    Button("\(options[num])"){
                        tapOption(num)
                    }
                        .font(.system(size: 102))
                }
            }
            .alert("Your final score is \(score)", isPresented: $gameOver){
                Button("Restart the game", action: resetGame)
            }
            Spacer()
        }
    }
    
    func tapOption(_ tap: Int){
        correctOption = Int.random(in: 0...2)
        winOrLose.toggle()
        frequency += 1
        if frequency > 9{
            gameOver = true
        }
        //如果要选择赢
        if winOrLose {
            if options[correctOption] == "✂️"{
                if options[tap] == "🪨"{
                    score+=1
                }
            }else if options[correctOption] == "🪨"{
                if options[tap] == "📄"{
                    score+=1
                }
            }else if options[correctOption] == "📄"{
                if options[tap] == "✂️"{
                    score+=1
                }
            }
        }else {
            if options[correctOption] == "✂️"{
                if options[tap] == "📄"{
                    score+=1
                }
            }else if options[correctOption] == "🪨"{
                if options[tap] == "✂️"{
                    score+=1
                }
            }else if options[correctOption] == "📄"{
                if options[tap] == "🪨"{
                    score+=1
                }
            }
        }
    }
    
    func resetGame (){
        frequency = 0
        score = 0
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
