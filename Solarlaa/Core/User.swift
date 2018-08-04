//
//  User.swift
//  Solarlaa
//
//  Created by GISC on 4/8/2561 BE.
//  Copyright © 2561 Nortisgroup. All rights reserved.
//

import Foundation

struct User{
    var userId: String?
    var imageProfile: String?
    var firstname: String?
    var lastname: String?
    var email: String?
    var address: String?
}

class UserSingleton {
    static let shared = UserSingleton()
    var user = User(userId: "", imageProfile: "", firstname: "", lastname: "", email: "", address: "")
    
    func updateToUserDefault() {
        UserDefaults.standard.set(UserSingleton.shared.user.userId, forKey: "USER_ID")
        UserDefaults.standard.set(UserSingleton.shared.user.imageProfile, forKey: "CID")
        UserDefaults.standard.set(UserSingleton.shared.user.firstname, forKey: "PROFILE_IMG")
        UserDefaults.standard.set(UserSingleton.shared.user.lastname, forKey: "NAME")
        UserDefaults.standard.set(UserSingleton.shared.user.email, forKey: "POINT")
        UserDefaults.standard.set(UserSingleton.shared.user.address, forKey: "TELNO")
    }
    
    func updateFromUserDefault(){
        UserSingleton.shared.user.userId = UserDefaults.standard.object(forKey: "USER_ID") as? String
        UserSingleton.shared.user.imageProfile = UserDefaults.standard.object(forKey: "CID") as? String
        UserSingleton.shared.user.firstname = UserDefaults.standard.object(forKey: "PROFILE_IMG") as? String
        UserSingleton.shared.user.lastname = UserDefaults.standard.object(forKey: "NAME") as? String
        UserSingleton.shared.user.email = UserDefaults.standard.object(forKey: "POINT") as? String
        UserSingleton.shared.user.address = UserDefaults.standard.object(forKey: "TELNO") as? String
    }
}
