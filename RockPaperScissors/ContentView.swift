//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Danjuma Nasiru on 02/01/2023.
//

import SwiftUI


struct ShouldWinText : View{
    var shouldWin: Bool
    
    var body: some View{
        if shouldWin{
            return Text("Play to Win")
        }else{
            return Text("Play to Loss")
        }
    }
}


struct LargeText : ViewModifier{
    var size: CGFloat
    func body(content: Content) -> some View {
        content
            .font(.system(size: size, weight: .bold, design: .serif))
            
    }
}

extension View{
    
    func largeTitle( size: CGFloat) -> some View{
        modifier(LargeText(size: size))
    }
}

struct ContentView: View {
    
    @State private var options = ["Rock", "Paper", "Scissors"].shuffled()
    @State private var winOrLossChoice = Bool.random()
    @State private var random = Int.random(in: 0...2)
    var gameChoice : String{
        options[random]
    }
   
    
    @State private var showAlert = false
    @State private var showFinalAlert = false
    var correctChoice : String{
        if gameChoice == "Rock" && winOrLossChoice == true{
            return "Paper"
        }else if gameChoice == "Rock" && winOrLossChoice == false{
            return "Scissors"
        }else if gameChoice == "Paper" && winOrLossChoice == true{
            return "Scissors"
        }else if gameChoice == "Paper" && winOrLossChoice == false{
            return "Rock"
        }else if gameChoice == "Scissors" && winOrLossChoice == true{
            return "Rock"
        }else{
            return "Paper"
        }
    }
    
    @State private var alertTitle = "Game Over"
    @State private var score = 0
    @State private var round = 0
    @State private var userChoice = "Rock"
    
    var body: some View {
            ZStack {
                Color.blue.opacity(0.3).ignoresSafeArea()
                VStack{
                    Text("Rock, Paper, Scissors").largeTitle(size: 25)
                    Spacer()
                    VStack( spacing: 20){
                        Text("The game chooses: \(gameChoice)").largeTitle(size: 20)
                            .multilineTextAlignment(.leading)
                        ShouldWinText(shouldWin: winOrLossChoice).largeTitle(size: 15)
                        Text("score: \(score)").largeTitle(size: 24)
                        Text("Round: \(round)").largeTitle(size: 20)
                    }
                    Spacer()
                    VStack( spacing: 20){
                        ForEach(options, id: \.self) { text in
                            Button{userSelected(text)}
                        label: {Text(text)}
                                .padding()
                                .foregroundColor(.white)
                                .frame(width: 200, height: 50)
                        }
                        .background(.blue)
                        .clipShape(Capsule())
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 20)
                    .background(.regularMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    
                    Spacer()
                    
                    
                    Spacer()
                }.padding()
                    .navigationTitle("Rock, Paper, Scissors!")
                    .navigationBarTitleDisplayMode(.inline)
//                    .alert(scoreTitle, isPresented: $showAlert, actions: {Button(action: Continue, label: {Text("Continue")})}, message: {Text("your score is \(score)")})
                    .alert(alertTitle, isPresented: $showFinalAlert, actions: {Button(action: End, label: {Text("Start Over")})}, message: {Text("Your Final Score is: \(score)")})
            }
            
    }
    
    func userSelected(_ text: String){
        round += 1
        userChoice = text;
        
        random = Int.random(in: 0...2)
        if userChoice == correctChoice{
            score += 1
        }else{
            score -= 1
        }
        
        if round == 10 {
            showFinalAlert = true
        }
        
        winOrLossChoice.toggle()
        options.shuffled()
        
    }
    
//    func Continue (){
//        options.shuffled()
//        random = Int.random(in: 0...2)
//    }
    
    func End (){
        options.shuffled()
        random = Int.random(in: 0...2)
        score = 0
        round = 0
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
