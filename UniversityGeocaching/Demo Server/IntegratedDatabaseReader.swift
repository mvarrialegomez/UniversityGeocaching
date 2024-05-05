//
//  IntegratedDatabaseReader.swift
//  UniversityGeocaching
//
//  Created by Natalie A. Nguyen on 4/30/24.
//

import Foundation
import Combine
var UserUpdates: [(String, String)] = [] //stores (email, serial of cache)
var AddedCaches: [String] = [] //stores serial of cache

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
                    if !AddedCaches.isEmpty{
                        for cache in AddedCaches {
                            print("updated new cache")
                            let cacheData = (cache, false)
                            cacheCompletions.append(cacheData)
                        }
                    }
                }
                
                let userData = UserData()
                userData.userEmail = email
                userData.userCaches = cacheCompletions
                userDataList.append(userData)
            }
            if !UserUpdates.isEmpty{
                for update in UserUpdates{
                    for userData in userDataList{
                        if update.0.lowercased() == userData.userEmail.lowercased(){
                            for i in 0..<userData.userCaches.count {
                                if update.1 == userData.userCaches[i].0{
                                    userData.userCaches.remove(at: i)
                                    userData.userCaches.append((update.1, true))
                                }
                            }
                            print(userData.userCaches)
                        }
                    }
                }
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
        if email.lowercased() == data.userEmail.lowercased() {
            userCacheData = data.userCaches
            print(userCacheData)
            break
        }
    }
    for cacheBool in userCacheData{
        print(cacheBool)
        for i in 0..<allCaches!.count{
            if allCaches![i].serial == cacheBool.0 && cacheBool.1{
                completedCaches.append(allCaches![i])
                print("Found completed Cache")
            }
        }
    }
    return completedCaches
}

func getCacheStatus(cacheID: String) -> [String] {
    var usersCompleted: [String] = []
    let userDataList = readUserDataCSV()
        for user in userDataList {
            for cache in user.userCaches{
                if cache.0 == cacheID && cache.1 {
                    usersCompleted.append(returnUserName(email: user.userEmail))
                }
            }
        }
        print(usersCompleted)
        return usersCompleted
    }

func addCache(cacheID: String){
    AddedCaches.append(cacheID)
}
func CacheClaimed(email: String, cacheID: String){
    print("Claimed")
    UserUpdates.append((email, cacheID))
}

func CheckUserCache(email: String, cacheID: String) -> Bool{
    let userDataList = readUserDataCSV()
    var userCacheData:[(String,Bool)] = []
    
    for data in userDataList{
        if email.lowercased() == data.userEmail.lowercased() {
            userCacheData = data.userCaches
            break
        }
    }
    for cacheBool in userCacheData{
        if cacheID == cacheBool.0 {
            if cacheBool.1{
                return true
            }
            else{
                return false
            }
        }
    }
    return false
}
