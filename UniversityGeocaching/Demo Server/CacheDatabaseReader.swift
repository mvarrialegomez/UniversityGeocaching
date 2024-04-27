//
//  CacheDatabase.swift
//  UniversityGeocaching
//
//  Created by Natalie A. Nguyen on 4/26/24.
//

import Foundation
import CoreLocation

// Function to read CSV file and return an array of Cache objects
func readCacheCSV() -> [Cache]? {
    let fileName = "CacheDatabase"
    if let filePath = Bundle.main.path(forResource: fileName, ofType: "csv") {
        do {
            let content = try String(contentsOfFile: filePath)
            let rows = content.components(separatedBy: .newlines)
            var csvCaches: [Cache] = []
            for row in rows {
                let columns = row.components(separatedBy: ",")
                if columns.count >= 3 {
                    if let latitude = Double(columns[2]), let longitude = Double(columns[3]) {
                        let cache = Cache(name: columns[1], coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
                        csvCaches.append(cache)
                    }
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
