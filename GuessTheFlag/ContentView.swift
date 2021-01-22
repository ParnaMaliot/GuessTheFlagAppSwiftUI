//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Igor Parnadziev on 9/27/20.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["US", "UK", "Estonia", "France", "Germany", "Ireland", "Italy", "Monaco", "Nigeria", "Poland", "Russia", "Spain"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var showResult = ""
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.blue, Color.black]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag to select the counry").foregroundColor(.white)
                    
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                    
                    ForEach(0..<3) {number in
                        Button("Select the flag", action: {
                            self.showAnswer(number)
                        })
                        .foregroundColor(.white)
                        .shadow(color: .black, radius: 3)
                        
                        Image(self.countries[number])
                            .renderingMode(.original)
                            .clipShape(Capsule())
                            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
                            .shadow(color: .black, radius: 2)
                    }
                }
                Spacer()
            }
        }
        .alert(isPresented: $showingScore) {
            Alert(title: Text(showResult), message: Text("Your score is ???"), dismissButton: .default(Text("Countinue")) {
                self.askQuestion()
            })
        }
    }
    
    func showAnswer(_ number: Int) {
        if number == correctAnswer {
            showResult = "Correct answer"
        } else {
            showResult = "Wrong answer"
        }
        showingScore = true    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
