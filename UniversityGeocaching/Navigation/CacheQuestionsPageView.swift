import SwiftUI
import UIKit

struct CacheQuestionsPageView: View {
    let question: String
    let options: [String]
    let correctOptionIndex: Int
    @State private var selectedOptionIndex: Int?
    @State private var backgroundColors: [Color]

    init(question: String, options: [String], correctOptionIndex: Int) {
        self.question = question
        self.options = options
        self.correctOptionIndex = correctOptionIndex
        self._backgroundColors = State(initialValue: Array(repeating: .clear, count: options.count))
    }

    // Function to vibrate the phone
    func vibrate() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.error)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(question)
                .font(.system(size: 30))
                .bold()
                .padding(.horizontal)

            ForEach(options.indices, id: \.self) { index in
                Button(action: {
                    selectedOptionIndex = index
                    backgroundColors[index] = index == correctOptionIndex ? .green : .red
                    if index != correctOptionIndex {
                        vibrate() // Vibrate if incorrect answer is chosen
                    }
                }) {
                    Text(options[index])
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
        CacheQuestionsPageView(question: "What is your favorite color?", options: ["Red", "Blue", "Green", "Yellow"], correctOptionIndex: 2)
    }
}
