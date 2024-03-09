//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Álvaro Gascón on 8/3/24.
//

import SwiftUI

struct ContentView: View {
    
    
    
    @State private var countries = ["Estonia", "Francia", "Alemania", "Irlanda", "Italia", "Nigeria", "Polonia", "España", "Reino Unido", "Ucrania", "Estados Unidos"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var restartPlay = false
    @State private var scoreTitle = ""
    @State private var finalTitle = ""
    @State private var finalSubtitle = ""
    @State private var score = 0
    @State private var scoreSubtitle = ""
    @State private var counter = 0
    @State private var showFinalScore = false
    
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correcto!"
            scoreSubtitle = "+10 puntos"
            score += 10
        } else {
            scoreTitle = "Incorrecto!"
            if score >= 10 {
                scoreSubtitle = "-10 puntos"
                score -= 10
            }else{
                score = 0
            }
        }
        showingScore = true
        counter += 1
    }
        
    
    func askQuestion() {
        if counter < 8 {
            countries.shuffle()
            correctAnswer = Int.random(in: 0...2)
        }else{
            finalTitle = "Puntuación final: \(score) puntos."
            finalSubtitle = "Volver a jugar?"
            showFinalScore = true
        }
    }
    
    func restartGame() {
            countries.shuffle()
            correctAnswer = Int.random(in: 0...2)
            counter = 0
            score = 0
        }

    
    
    var body: some View {
        ZStack{
            LinearGradient(colors: [.blue,.green], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack {
                Text("Adivina la bandera")
                    .font(.largeTitle.weight(.bold))
                    .foregroundStyle(.white)
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Toca la bandera de")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .cornerRadius(5)
                                .shadow(radius: 5)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                Text("Puntuación: \(score)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continuar", action: askQuestion)
        } message: {
            Spacer()
            Spacer()
            Text("\(scoreSubtitle)")
            Spacer()
        }
        .alert(finalTitle, isPresented: $showFinalScore) {
            Button("Continuar", action: restartGame)
        } message: {
            Spacer()
            Spacer()
            Text("\(finalSubtitle)")
            Spacer()
        }
    }
}

#Preview {
    ContentView()
}
