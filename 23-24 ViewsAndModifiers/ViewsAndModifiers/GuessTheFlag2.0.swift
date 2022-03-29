//
//  GuessTheFlag2.0.swift
//  ViewsAndModifiers
//
//  Created by 范三球 on 2022/3/14.
//  使用结构体重写GuessTheFlag样式
//

import SwiftUI

struct ProminentTitle: ViewModifier{
    func body(content:Content) -> some View{
        content
            .font(.largeTitle)
            .foregroundColor(.blue)
    }
}
extension View{
    func prominentTitleStytle() -> some View {
        modifier(ProminentTitle())
    }
}


struct FlagImage: ViewModifier{
    func body(content: Content) -> some View {
        content
            .clipShape(Capsule())
            .shadow(radius: 5)
    }
}

struct GuessTheFlag2_0: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var tapNumber = 0
    @State private var count = 0
    @State private var gameOver = false
        
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
//                            .font(.subheadline.weight(.heavy))
//                            .foregroundStyle(.secondary)
                            .modifier(ProminentTitle())

                        Text(countries[correctAnswer])
//                            .font(.largeTitle.weight(.semibold))
                            .prominentTitleStytle()
                    }

                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                            tapNumber = number
                        } label: {
                            Image(countries[number])
                                .modifier(FlagImage())
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
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
        } else {
            scoreTitle = "Wrong"
        }
        
        showingScore = true
    }
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        count += 1
        if count > 7 {
            gameOver = true
        }
    }
    func resetGame(){
        count = 0
        score = 0
    }
}

struct GuessTheFlag2_0_Previews: PreviewProvider {
    static var previews: some View {
        GuessTheFlag2_0()
    }
}
