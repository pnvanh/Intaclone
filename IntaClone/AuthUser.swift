//
//  AuthUser.swift
//  IntaClone
//
//  Created by Viet Anh on 15/01/2021.
//

import SwiftUI
import Combine
import Foundation
import Alamofire
import SwiftyJSON

class AuthUser: ObservableObject {
    
    var didChange = PassthroughSubject<AuthUser, Never>()
    
    @Published var isCorrect : Bool = true
    @Published var isConnected : Bool = true
    
    @Published var isLoggedin : Bool = false {
           didSet {
               didChange.send(self)
           }
    }
    func LoginWithUsername(username: String, password: String) {
        let ulParam = UserLoginModel(pushToken: "muaaccountAppleDevdi", deviceId: UIDevice.current.identifierForVendor!.uuidString, deviceType: "IOS", username: username, password: password)
        AF.request("http://congchuabuoito.southeastasia.cloudapp.azure.com/login", method: .post, parameters: ulParam, encoder: JSONParameterEncoder.default).response { response in
            if let json = response.data {
                let data = try! JSON(data: json)
                if data["user"].isEmpty != true {
                    print(data["user"])
//                    self.userDefaults.set(data["user"]["id"].string, forKey: "idUser")
//                    self.userDefaults.set(data["user"]["fullname"].string, forKey: "fullname")
//                    self.userDefaults.set(data["user"]["email"].string, forKey: "email")
//                    self.userDefaults.set(data["user"]["avatar"].string, forKey: "avatar")
//                    self.userDefaults.set(data["user"]["avatar"].string, forKey: "avatar")
//                    self.userDefaults.set(data["token"].string, forKey: "tokenSV")
                }
                else {
                    print("isEmpty")
                }
            }
        }
        
    }
}
