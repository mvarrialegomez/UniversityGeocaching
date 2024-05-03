//
//  CacheDatabase.swift
//  UniversityGeocaching
//
//  Created by Natalie A. Nguyen on 4/26/24.
//

import Foundation
import CoreLocation

var PushedCaches: [Cache] = []
// Function to read CSV file and return an array of Cache objects
func readCacheCSV() -> [Cache]? {
    let fileName = "CacheDatabase"
    if let filePath = Bundle.main.path(forResource: fileName, ofType: "csv") {
        do {
            let content = try String(contentsOfFile: filePath)
            let rows = content.components(separatedBy: .newlines)
            var csvCaches: [Cache] = []
            for row in rows {
                if row != ""{
                    let columns = row.components(separatedBy: ",")
                    if columns.count >= 3 {
                        if let latitude = Double(columns[2]), let longitude = Double(columns[3]) {
                            let cache = Cache(serial: columns[0], name: columns[1], coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), question: columns[4], correctAnswer: columns[5], answer2: columns[6], answer3: columns[7], answer4: columns[8])
                            csvCaches.append(cache)
                        }
                    }
                }
            }
            if !PushedCaches.isEmpty {
                for cache in PushedCaches {
                    csvCaches.append(cache)
                }
            }
            return csvCaches
        } catch {
            print("Error reading CSV file:", error)
            return nil
        }
    } else {
        print("File not found:", fileName)
        return nil
    }
}
func NextID() -> String{
    let CacheList = readCacheCSV()
    let lastID = CacheList?.last?.serial
    if var intID = Int(lastID!){
        intID += 1
        let nextID = String(format: "%04d", intID)
        return nextID
    }
    else{
        print("int cast fail")
        return ""
    }
    
}
func WriteCache(NewCache: Cache){
    let newID = NextID()
    PushedCaches.append(Cache(serial: newID, name: NewCache.name, coordinate: NewCache.coordinate, question: NewCache.question, correctAnswer: NewCache.correctAnswer, answer2: NewCache.answer2, answer3: NewCache.answer3, answer4: NewCache.answer4))
    print("pushed")
    addCache(cacheID: newID)
}

