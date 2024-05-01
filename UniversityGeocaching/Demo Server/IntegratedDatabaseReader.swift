//
//  IntegratedDatabaseReader.swift
//  UniversityGeocaching
//
//  Created by Natalie A. Nguyen on 4/30/24.
//

import Foundation
import Combine

func readUserDataFromCSV() -> [UserData] {
    var userDataList: [UserData] = []
    
    if let filepath = Bundle.main.path(forResource: "IntegratedUserCacheDatabase", ofType: "csv") {
        do {
            let contents = try String(contentsOfFile: filepath)
            let lines = contents.components(separatedBy: .newlines)
            
            guard let headerLine = lines.first else {
                print("CSV file is empty.")
                return userDataList
            }
            
            let cacheNames = headerLine.components(separatedBy: ",")
            
            for line in lines.dropFirst() {
                let data = line.components(separatedBy: ",")
                
                guard data.count == cacheNames.count + 1, // +1 for the email column
                      let email = data.first?.trimmingCharacters(in: .whitespacesAndNewlines) else {
                    continue // Skip invalid lines
                }
                
                var cacheCompletions: [(String, Bool)] = []
                for (index, cacheName) in cacheNames.dropFirst().enumerated() {
                    if let access = Bool(data[index + 1]) {
                        cacheCompletions.append((cacheName, access))
                    }
                }
                
                let userData = UserData()
                userDataList.append(userData)
            }
        } catch {
            print("Error reading CSV file: \(error)")
        }
    } else {
        print("CSV file not found.")
    }
    
    return userDataList
}
