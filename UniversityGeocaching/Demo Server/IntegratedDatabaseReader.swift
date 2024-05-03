//
//  IntegratedDatabaseReader.swift
//  UniversityGeocaching
//
//  Created by Natalie A. Nguyen on 4/30/24.
//

import Foundation
import Combine

func readUserDataCSV() -> [UserData] {
    var userDataList: [UserData] = []
    
    let fileName = "IntegratedUserCacheDatabase"
    if let filePath = Bundle.main.path(forResource: fileName, ofType: "csv") {
        do {
            let content = try String(contentsOfFile: filePath)
            let rows = content.components(separatedBy: .newlines)
            var cacheCompletions: [(String,Bool)] = []
            var email: String = ""
            let header = rows[0].components(separatedBy: ",")
            for row in rows {
                if row != "" {
                    let columns = row.components(separatedBy: ",")
                    email = columns[0]
                    cacheCompletions = []
                    for col in 0..<columns.count{
                        if let boolValue = Bool(columns[col]) {
                            let cacheData = (header[col], boolValue)
                            cacheCompletions.append(cacheData)
                        }
                    }
                }
                
                let userData = UserData()
                userData.userEmail = email
                userData.userCaches = cacheCompletions
                userDataList.append(userData)
            }
        }catch {
            print("Error reading CSV file: \(error)")
        }
    } else {
        print("CSV file not found.")
    }
    
    return userDataList
}

func getUserStats(email: String) -> [Cache] {
    let allCaches = readCacheCSV()
    let userDataList = readUserDataCSV()
    var userCacheData:[(String,Bool)] = []
    var completedCaches:[Cache] = []
    
    for data in userDataList{
        print(email)
        if email == data.userEmail {
            userCacheData = data.userCaches
            print(userCacheData)
            break
        }
    }
    var index:Int = 0
    for cacheBool in userCacheData{
        if let allCaches = allCaches, index < allCaches.count {
            let cacheSerial = allCaches[index].serial
            print(cacheBool.0, cacheBool.1)
            if cacheBool.0 == cacheSerial && cacheBool.1 {
                completedCaches.append(allCaches[index])
            }
        }
        index+=1
    }
    return completedCaches
}

func getCacheStatus(cacheID: String) -> [String] {
    var usersCompleted: [String] = []
    let userDataList = readUserDataCSV()
        print(userDataList)
        for user in userDataList {
            for cache in user.userCaches{
                print(cache.0, cacheID)
                if cache.0 == cacheID && cache.1 {
                    usersCompleted.append(returnUserName(email: user.userEmail))
                }
            }
        }
        print(cacheID, usersCompleted)
        return usersCompleted
    }
