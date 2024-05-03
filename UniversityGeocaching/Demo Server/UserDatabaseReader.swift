//
//  verifyUser.swift
//  UniversityGeocaching
//
//  Created by Mikey Gallagher on 4/26/24.
//

import Foundation

func readUserCSV() -> [User]? {
    
    let fileName = "UserDatabase"
    if let filePath = Bundle.main.path(forResource: fileName, ofType: "csv") {
        do {
            let content = try String(contentsOfFile: filePath)
            let rows = content.components(separatedBy: .newlines)
            var csvUsers: [User] = []
            for row in rows {
                if row != "" {
                    let columns = row.components(separatedBy: ",")
                    let user = User(Email: columns[0], Password: columns[1], Access: columns[2], Name: columns[3])
                    csvUsers.append(user)
                }
            }
            return csvUsers
        } catch {
            print("Error reading CSV file:", error)
            return nil
        }
    } else {
        print("File not found:", fileName)
        return nil
    }
}


func VerifyUser(email: String, password: String, access: Bool) -> Bool {
    var UserList: [User] = []
    UserList = readUserCSV() ?? []
    for user in UserList{
        if email.lowercased() == user.Email.lowercased() {
            if password == user.Password{
                return true
            }
            else{
                return false
            }
        }
    }
    return false
}

func returnUserName(email:String) -> String {
    var UserList: [User] = []
    var name: String = ""
    UserList = readUserCSV() ?? []
    for user in UserList{
        if email == user.Email {
            name = user.Name
        }
    }
    return name
}
