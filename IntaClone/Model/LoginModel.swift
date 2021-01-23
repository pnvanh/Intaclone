//
//  LoginModel.swift
//  IntaClone
//
//  Created by Viet Anh on 15/01/2021.
//

import SwiftUI
import Alamofire
import SwiftyJSON
import GoogleSignIn

class GoogleLogin: ObservableObject {
    @Published var dataGoogleLogin = [GoogleLoginModel]()
    let userDefaults = UserDefaults.standard
    let glParam = GoogleLoginModel(pushToken: "muaaccountAppleDevdi", deviceId: UIDevice.current.identifierForVendor!.uuidString, deviceType: "IOS", accessToken: UserDefaults.standard.string(forKey: "idToken")!)
    init() {
        AF.request("http://congchuabuoito.southeastasia.cloudapp.azure.com/google", method: .post, parameters: glParam, encoder: JSONParameterEncoder.default).response { [self] response in
            if let json = response.data {
                let data = try! JSON(data: json)
                if data["user"].isEmpty != true {
//                    print(data)
                    self.userDefaults.set(data["user"]["id"].int, forKey: "idUser")
                    self.userDefaults.set(data["user"]["fullname"].string, forKey: "fullname")
                    self.userDefaults.set(data["user"]["username"].string, forKey: "username")
                    self.userDefaults.set(data["user"]["email"].string, forKey: "email")
                    self.userDefaults.set(data["user"]["avatar"].string, forKey: "avatar")
                    self.userDefaults.set(data["token"].string, forKey: "tokenSV")
                }
                else {
                    print("isEmpty")
                }
            }
        }
    }
}
func DoUserLogin(_ username: String, _ password: String){
    let userDefaults = UserDefaults.standard
    let ulParam = UserLoginModel(pushToken: "muaaccountAppleDevdi", deviceId: UIDevice.current.identifierForVendor!.uuidString, deviceType: "IOS", username: username, password: password)
    AF.request("http://congchuabuoito.southeastasia.cloudapp.azure.com/login", method: .post, parameters: ulParam, encoder: JSONParameterEncoder.default).response{ response in
        if let json = response.data {
            switch response.result {
            case .success:
                let data = try! JSON(data: json)
//                print(data)
                userDefaults.set(data["user"]["id"].int, forKey: "idUser")
                userDefaults.set(data["user"]["fullname"].string, forKey: "fullname")
                userDefaults.set(data["user"]["username"].string, forKey: "username")
                userDefaults.set(data["user"]["email"].string, forKey: "email")
                userDefaults.set(data["user"]["avatar"].string, forKey: "avatar")
                userDefaults.set(data["token"].string, forKey: "tokenSV")
            case let .failure(error):
                print(error)
            }
        }
    }.resume()
}
struct GoogleLoginModel: Encodable {
    var pushToken: String
    var deviceId: String
    var deviceType: String
    var accessToken: String
}
struct UserLoginModel: Encodable {
    var pushToken: String
    var deviceId: String
    var deviceType: String
    var username: String
    var password: String
}
