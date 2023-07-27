//
//  appConstant.swift
//  TMDBAli
//
//  Created by Ali Moustafa on 03/07/2023.
//

import Foundation



class UserStatus{
    
    static func getApplicationLanguage()->String{
        return UserStatus.applicationLanguage
    }

    
static var applicationLanguage: String{
        get{
            return UserDefaults.standard.value(forKey: "applicationLanguage") as? String ?? "en-US"
        }
        set{
            UserDefaults.standard.set(newValue, forKey: "applicationLanguage")
        }
    }
    
   

}


