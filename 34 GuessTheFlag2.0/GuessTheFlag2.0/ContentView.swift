//
//  ContentView.swift
//  GuessTheFlag2.0
//
//  Created by 范三球 on 2022/3/29.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var tapNumber = 0
    @State private var count = 0
    @State private var gameOver = false
    
    @State private var opacityAmount = 1.0
    @State private var rotationAmount = 0.0
    
    var body: some View {
        ZStack{
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 400)
                .ignoresSafeArea()
            VStack{
                Spacer()
                Text("Guess the Flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundColor(.white)
                Spacer()
                Spacer()
                Text("Score: \(score)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                Spacer()
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .font(.subheadline.weight(.heavy))
                            .foregroundStyle(.secondary)

                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                            tapNumber = number
                            // 使用显性动画调整参数
                            withAnimation(.spring()) {
                                opacityAmount = 0.25
                                rotationAmount += 360
                            }
                        } label: {
                            Image(countries[number])
                                .renderingMode(.original)
                                .clipShape(Capsule())
                                .shadow(radius: 5)
                                .opacity(tapNumber == number ? 1 : opacityAmount)
                                .rotation3DEffect(.degrees(tapNumber == number ? rotationAmount : 0), axis: (x: 0, y: 1, z: 0))
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
            }
            .alert(scoreTitle, isPresented: $showingScore) {
                Button("Continue", action: askQuestion)
            } message: {
                if scoreTitle == "Correct" {
                    Text("Your score is \(score)")
                }else if scoreTitle == "Wrong"{
                    Text("Your score is \(score)" + "\n" + "That's the flag of \(countries[tapNumber])")
                }
            }
            .alert("Game over", isPresented: $gameOver){
                Button("Restart the game", action: resetGame)
            }
            .padding()
        }
    }
    // 点击旗帜唤起函数
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
        } else {
            scoreTitle = "Wrong"
        }
        // 点击后重置透明度
        opacityAmount = 1
        showingScore = true
    }
    // 开始下一轮游戏
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        count += 1
        if count > 7 {
            gameOver = true
        }
        opacityAmount = 1.0
        rotationAmount = 0.0
    }
    // 重置游戏
    func resetGame(){
        count = 0
        score = 0
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
