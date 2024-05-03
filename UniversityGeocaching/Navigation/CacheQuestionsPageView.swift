//  Geocaches.swift
//  UniversityGeocaching
//
//  Created by Tia Merheb on 3/14/23.
//  Continued by Maria Varriale Gomez, David Amano, Natalie Nguyen, Michael Gallagher, and Sean Limqueco in Spring 2024.
//
import SwiftUI
import UIKit

// Function to shuffle an array in place
func shuffle<T>(_ array: inout [T]) {
    for i in 0..<(array.count - 1) {
        let j = Int(arc4random_uniform(UInt32(array.count - i))) + i
        array.swapAt(i, j)
    }
}

struct CacheQuestionsPageView: View {
    let cacheName: String
    let question: String
    let correctAnswer: String
    let answer2: String
    let answer3: String
    let answer4: String
    @State private var selectedOptionIndex: Int?
    @State private var backgroundColors: [Color]
    @State private var options: [String] = [] // Initialize options with default values

    init(cacheName: String, question: String, correctAnswer: String, answer2: String, answer3: String, answer4: String) {
        self.cacheName = cacheName
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
        VStack(alignment: .leading, spacing: 20) {
            Text(cacheName)
                .font(.system(size: 30))
                .bold()
                .padding(.horizontal)
                .padding(.top, 5)
                .foregroundColor(.blue)
            Text(question)
                .font(.system(size: 25))
                .bold()
                .padding(.horizontal)

            ForEach(options.indices, id: \.self) { index in
                Button(action: {
                    selectedOptionIndex = index
                    backgroundColors[index] = options[index] == correctAnswer ? .green : .red
                    if options[index] != correctAnswer {
                        vibrate() // Vibrate if incorrect answer is chosen
                    }
                }) {
                    Text(options[index])
                        .font(.system(size: 20))
                        .foregroundColor(.primary)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(backgroundColors[index])
                        .cornerRadius(10)
                        .padding(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.blue, lineWidth: 2)
                        )
                        .padding(.horizontal, 10)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
        .onAppear {
            options = [correctAnswer, answer2, answer3, answer4]
            shuffle(&options) // Shuffle the options array before using it
        }
    }
}

struct CacheQuestionsPageView_Previews: PreviewProvider {
    static var previews: some View {
        CacheQuestionsPageView(cacheName: "sample", question: "What is your favorite color?", correctAnswer: "Red", answer2: "Blue", answer3: "Green", answer4: "Yellow")
    }
}
