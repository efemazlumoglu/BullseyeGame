//
//  ContentView.swift
//  Bullseye
//
//  Created by Efe Mazlumoğlu on 13.10.2020.
//

import SwiftUI

struct ContentView: View {
    @State var isAlerting: Bool = false
    @State var winAlert: Bool = false
    @State var sliderValue: Double = 50.0
    @State var randomInt = Int.random(in: 1..<101)
    @State var score: Int = 0
    @State var round: Int = 0
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Text("Put the bullseye as close as you can to: ")
                Text(String(self.randomInt))
            }
            Spacer()
            HStack {
                Text("1")
                Slider(value: self.$sliderValue, in: 1...100)
                Text("100")
            }
            Button(action: {
                print("button is pressed")
                let roundedValue: Int = Int(self.sliderValue.rounded())
                if (roundedValue - self.randomInt > 0) {
                    self.isAlerting = true
                    let newScore = 100 - (roundedValue - self.randomInt)
                    self.score = newScore
                    self.round += 1
                } else if (roundedValue - self.randomInt == 0) {
                    self.score = 100
                    self.winAlert = true
                } else if (roundedValue - self.randomInt < 0) {
                    self.isAlerting = true
                    let newScore = 100 - (self.randomInt - roundedValue)
                    self.score = newScore
                    self.round += 1
                }
                
            }, label: {
                Text("Hit me!")
            })
            Spacer()
            .alert(isPresented: self.$winAlert) {
                () -> Alert in
                let roundedValue: Int = Int(self.sliderValue.rounded())
                return Alert(title: Text("Result"), message: Text("The slider value is \(roundedValue) and your score is \(self.score) Congrulationsss !!!!! You win"), dismissButton: .default(Text("Start Over")))
            }
            .alert(isPresented: self.$isAlerting) {
                () -> Alert in
                let roundedValue: Int = Int(self.sliderValue.rounded())
                return Alert(title: Text("Result"), message: Text("The slider value is \(roundedValue) and your score is \(self.score)"), dismissButton: .default(Text("Try Again")))
            }
            HStack {
                Button(action: {
                    self.score = 0
                    self.round = 0
                    self.randomInt = Int.random(in: 1..<101)
                    self.sliderValue = 50.0
                }) {
                    Text("Start Over")
                }
                Spacer()
                Text("Score: ")
                Text(String(self.score))
                Spacer()
                Text("Round: ")
                Text(String(self.round))
                Spacer()
                Button(action: {
                    
                }) {
                    Text("Info")
                }
            }.padding(.bottom, 50)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView().previewLayout(.fixed(width: 896, height: 414))
        }
    }
}
