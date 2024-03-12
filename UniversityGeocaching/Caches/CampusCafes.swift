//
//  CampusCafes.swift
//  UniversityGeocaching
//
//  Created by Tia Merheb on 2/14/23.
//  Continued by Maria Varriale Gomez, David Amano, Natalie Nguyen, Michael Gallagher, and Sean Limqueco in Spring 2024.
//

import Foundation
import SwiftUI

struct CampusCafes : View{
    var body : some View{
        Text("Campus Cafes")
            .font(.largeTitle)
        .navigationBarBackButtonHidden()
    }
}

struct CampusCafesView_Previews: PreviewProvider {
    static var previews: some View {
        CampusCafes()
    }
}
