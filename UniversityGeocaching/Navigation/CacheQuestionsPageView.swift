//
//  CacheQuestionsPageView.swift
//  UniversityGeocaching
//
//  Created by Natalie A. Nguyen on 4/26/24.
//

import SwiftUI

struct CacheQuestionsPageView: View {
    let question: String
    let options: [String]
    @State private var selectedOption: String?

    var body: some View {
        VStack(alignment: .leading) {
            Text(question)
                .font(.headline)
                .padding(.bottom, 10)
            
            ForEach(options, id: \.self) { option in
                Button(action: {
                    selectedOption = option
                }) {
                    HStack {
                        if let selected = selectedOption, selected == option {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.blue)
                        } else {
                            Image(systemName: "circle")
                                .foregroundColor(.gray)
                        }
                        Text(option)
                            .font(.subheadline)
                    }
                }
                .padding(.bottom, 5)
            }
        }
        .padding()
    }
}

struct CacheQuestionsPageView_Previews: PreviewProvider {
    static var previews: some View {
        CacheQuestionsPageView(question: "What is your favorite color?", options: ["Red", "Blue", "Green", "Yellow"])
    }
}

