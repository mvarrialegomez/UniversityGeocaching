//  Geocaches.swift
//  UniversityGeocaching
//
//  Created by Tia Merheb on 3/14/23.
//  Continued by Maria Varriale Gomez, David Amano, Natalie Nguyen, Michael Gallagher, and Sean Limqueco in Spring 2024.
//
import SwiftUI
import UIKit

// Function to shuffle an array and return a new shuffled list
func shuffle<T>(_ array: [T]) -> [T] {
    var shuffledArray = array
    for i in 0..<(shuffledArray.count - 1) {
        let j = Int(arc4random_uniform(UInt32(shuffledArray.count - i))) + i
        shuffledArray.swapAt(i, j)
    }
    return shuffledArray
}

struct CacheQuestionsPageView: View {
    let question: String
    let correctAnswer: String
    let answer2: String
    let answer3: String
    let answer4: String
    @State private var selectedOptionIndex: Int?
    @State private var backgroundColors: [Color]

    init(question: String, correctAnswer: String, answer2: String, answer3: String, answer4: String) {
        self.question = question
        self.correctAnswer = correctAnswer
        self.answer2 = answer2
        self.answer3 = answer3
        self.answer4 = answer4
        self._backgroundColors = State(initialValue: Array(repeating: .clear, count: 4))
    }

    // Function to vibrate the phone
    func vibrate() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.error)
    }
    
    var body: some View {
        var options = [correctAnswer, answer2, answer3, answer4]
        var shuffledOptions = shuffle(options)
        VStack(alignment: .leading, spacing: 20) {
            Text(question)
                .font(.system(size: 30))
                .bold()
                .padding(.horizontal)

            ForEach(options.indices, id: \.self) { index in
                Button(action: {
                    selectedOptionIndex = index
                    backgroundColors[index] = shuffledOptions[index] == correctAnswer ? .green : .red
                    if shuffledOptions[index] != correctAnswer {
                        vibrate() // Vibrate if incorrect answer is chosen
                    }
                }) {
                    Text(shuffledOptions[index])
                        .font(.headline)
                        .foregroundColor(.primary)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(backgroundColors[index])
                        .cornerRadius(10)
                        .padding()
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
    }
}

struct CacheQuestionsPageView_Previews: PreviewProvider {
    static var previews: some View {
        CacheQuestionsPageView(question: "What is your favorite color?", correctAnswer: "Red", answer2: "Blue", answer3: "Green", answer4: "Yellow")
    }
}
