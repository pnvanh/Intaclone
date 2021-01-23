//
//  Feed.swift
//  IntaClone
//
//  Created by Viet Anh on 16/01/2021.
//

import SwiftUI
import Alamofire
import SwiftyJSON
import SDWebImageSwiftUI
class NewFeed: ObservableObject {
    @Published var dataNewFeedFeed = [Card]()
    let user = UserDefaults.standard
    init() {
        user.synchronize()
        guard let accessToken = user.string(forKey: "tokenSV") else {return}
        print("token \(accessToken)")
        let headers: HTTPHeaders = [
            "Authorization": "\(accessToken)",
            "Content-Type": "application/json"
        ]
        AF.request("http://congchuabuoito.southeastasia.cloudapp.azure.com/feed?size=69&sortOrder=desc&sortBy=created", method: .get, headers: headers).response { response in
            if let json = response.data {
                let data = try! JSON(data: json)
//                print(data["content"])
                let content = data["content"].arrayValue
                
                content.forEach({ item in
                   // print(checkHTTP(check: item["user"]["avatar"].string!))
                    self.dataNewFeedFeed.append(Card(id: item["id"].int!, avata: "\(checkHTTP(check: item["user"]["avatar"].string!))", postImage: "\(checkHTTP(check: item["medias"][0]["media_url"].string!))", username: item["user"]["username"].string!, place: "Da Nang, Viet Nam", like: item["numOfLikes"].int!, caption: item["description"].string!, show: false , userLike: item["like"].boolValue))
                })
            }
        }
    }
    func reloadData(){
        user.synchronize()
        guard let accessToken = user.string(forKey: "tokenSV") else {return}
        print("token \(accessToken)")
        let headers: HTTPHeaders = [
            "Authorization": "\(accessToken)",
            "Content-Type": "application/json"
        ]
        AF.request("http://congchuabuoito.southeastasia.cloudapp.azure.com/feed?size=69&sortOrder=desc&sortBy=created", method: .get, headers: headers).response { response in
            if let json = response.data {
                let data = try! JSON(data: json)
//                print(data["content"])
                let content = data["content"].arrayValue
                
                content.forEach({ item in
                   // print(checkHTTP(check: item["user"]["avatar"].string!))
                    self.dataNewFeedFeed.append(Card(id: item["id"].int!, avata: "\(checkHTTP(check: item["user"]["avatar"].string!))", postImage: "\(checkHTTP(check: item["medias"][0]["media_url"].string!))", username: item["user"]["username"].string!, place: "Da Nang, Viet Nam", like: item["numOfLikes"].int!, caption: item["description"].string!, show: false , userLike: item["like"].boolValue))
                })
            }
        }
    }
    func loadRecomment(){
        user.synchronize()
        guard let accessToken = user.string(forKey: "tokenSV") else {return}
        print("token \(accessToken)")
        let headers: HTTPHeaders = [
            "Authorization": "\(accessToken)",
            "Content-Type": "application/json"
        ]
        AF.request("http://congchuabuoito.southeastasia.cloudapp.azure.com/postRecommend", method: .get, headers: headers).response { response in
            if let json = response.data {
                let data = try! JSON(data: json)
//                print(data["content"])
                let content = data["content"].arrayValue
                
                content.forEach({ item in
                   // print(checkHTTP(check: item["user"]["avatar"].string!))
                    self.dataNewFeedFeed.append(Card(id: item["id"].int!, avata: "\(checkHTTP(check: item["user"]["avatar"].string!))", postImage: "\(checkHTTP(check: item["medias"][0]["media_url"].string!))", username: item["user"]["username"].string!, place: "", like: item["numOfLikes"].int!, caption: item["description"].string!, show: false , userLike: item["like"].boolValue))
                })
            }
        }
    }
}

class LoadNotification: ObservableObject {
    @Published var dataNotification = [DataNotification]()
    @Published var detailOfNotification = [Card]()
    let user = UserDefaults.standard
    init() {
        user.synchronize()
        guard let accessToken = user.string(forKey: "tokenSV") else {return}
        print("token \(accessToken)")
        let headers: HTTPHeaders = [
            "Authorization": "\(accessToken)",
            "Content-Type": "application/json"
        ]
        AF.request("\(API.URL)/notification", method: .get, headers: headers).response { response in
            if let json = response.data {
                let data = try! JSON(data: json)
                let content = data["content"].arrayValue
                content.forEach({ item in
                    self.dataNotification.append(DataNotification(id: item["id"].int!, avata: checkHTTP(check: item["from"]["avatar"].string!), image: "\(checkHTTP(check: item["imageUrl"].string!))", username: item["from"]["username"].string!, content: item["message"].string!, time: toDate(dateString: item["created"].string!), destinationId: item["destinationId"].int!))
                })
            }
        }
    }
}

class FindUser: ObservableObject {
    @Published var dataFindUser = [SearchData]()
    let user = UserDefaults.standard
    init(){
        user.synchronize()
        guard let accessToken = user.string(forKey: "tokenSV") else {return}
        let headers: HTTPHeaders = [
            "Authorization": "\(accessToken)",
            "Content-Type": "application/json"
        ]
        AF.request("\(API.URL)/user?page=0", method: .get, headers: headers).response{ response in
            if let json = response.data {
                let data = try! JSON(data: json)
                let content = data.arrayValue
                content.forEach({item in
                    self.dataFindUser.append(SearchData(id: item["id"].int!, image: checkHTTP(check: item["avatar"].string!), username: item["username"].string!, name: item["fullname"].string!, check: item["following"].int! == 1 ? true : false))
                })
            }
        }.resume()
        
    }
}
class LoadUserDetail: ObservableObject {
    @Published var dataUserOther = [DataUser]()
    let user = UserDefaults.standard
    func loadProfileInfo(id: Int){
        user.synchronize()
        guard let accessToken = user.string(forKey: "tokenSV") else {return}
        let headers: HTTPHeaders = [
            "Authorization": "\(accessToken)",
            "Content-Type": "application/json"
        ]
        AF.request("\(API.URL)/user/\(id)", method: .get, headers: headers).response{ [self]response in
            if let json = response.data {
                let data = try! JSON(data: json)
                self.dataUserOther.append(DataUser(id: data["user"]["id"].int!,
                                                     avatar: checkHTTP(check: data["user"]["avatar"].string!),
                                                     username: data["user"]["username"].string!,
                                                     fullname: data["user"]["fullname"].string!,
                                                     numOfFollowings: data["user"]["numOfFollowings"].int!,
                                                     numOfFollowers: data["user"]["numOfFollowers"].int!,
                                                     cover: checkHTTP(check: data["user"]["cover"].string!),
                                                     bio: data["user"]["bio"].string!, followStatus: data["followStatus"].int! == 1 ? true : false))
            }
        }.resume()
    }
}

class LoadUser: ObservableObject {
    @Published var dataUserProfile = [DataUser]()
    let user = UserDefaults.standard
    init(){
        user.synchronize()
        guard let accessToken = user.string(forKey: "tokenSV") else {return}
        guard let idUser = user.string(forKey: "idUser") else {return}
        let headers: HTTPHeaders = [
            "Authorization": "\(accessToken)",
            "Content-Type": "application/json"
        ]
        AF.request("\(API.URL)/user/\(idUser)", method: .get, headers: headers).response{ [self]response in
            if let json = response.data {
                let data = try! JSON(data: json)
                self.dataUserProfile.append(DataUser(id: data["user"]["id"].int!,
                                                     avatar: checkHTTP(check: data["user"]["avatar"].string!),
                                                     username: data["user"]["username"].string!,
                                                     fullname: data["user"]["fullname"].string!,
                                                     numOfFollowings: data["user"]["numOfFollowings"].int!,
                                                     numOfFollowers: data["user"]["numOfFollowers"].int!,
                                                     cover: checkHTTP(check: data["user"]["cover"].string!),
                                                     bio: data["user"]["bio"].string!, followStatus: data["followStatus"].int! == 1 ? true : false))
            }
        }.resume()
    }
}
class LoadListPostByUser: ObservableObject {
    @Published var dataImage = [Card]()
    let user = UserDefaults.standard
    func loadImage(id: Int) {
        user.synchronize()
        guard let accessToken = user.string(forKey: "tokenSV") else {return}
        //guard let idUser = user.string(forKey: "idUser") else {return}
        let headers: HTTPHeaders = [
            "Authorization": "\(accessToken)",
            "Content-Type": "application/json"
        ]
        AF.request("\(API.URL)/user/\(id)/post", method: .get, headers: headers).response{ response in
            if let json = response.data {
                let data = try! JSON(data: json)
//                print(data["content"])
                let content = data["content"].arrayValue
                
                content.forEach({ item in
                    self.dataImage.append(Card(id: item["id"].int!, avata: "\(checkHTTP(check: item["author"]["avatar"].string!))", postImage: "\(checkHTTP(check: item["medias"][0]["media_url"].string!))", username: item["author"]["username"].string!, place: "Da Nang, Viet Nam", like: item["numoflikes"].int!, caption: item["description"].string!, show: false , userLike: item["like"].boolValue))
                })
            }
        }.resume()
    }
}
class LoadDetailPost: ObservableObject {
    @Published var loadDetailImage = [Card]()
    let user = UserDefaults.standard
    func loadDataDetail(id: Int) {
        user.synchronize()
        guard let accessToken = user.string(forKey: "tokenSV") else {return}
        //guard let idUser = user.string(forKey: "idUser") else {return}
        let headers: HTTPHeaders = [
            "Authorization": "\(accessToken)",
            "Content-Type": "application/json"
        ]
        AF.request("\(API.URL)/user/\(id)/post", method: .get, headers: headers).response{ response in
            if let json = response.data {
                let data = try! JSON(data: json)
//                print(data["content"])
                let content = data["content"].arrayValue
                
                content.forEach({ item in
                    self.loadDetailImage.append(Card(id: item["id"].int!, avata: "\(checkHTTP(check: item["author"]["avatar"].string!))", postImage: "\(checkHTTP(check: item["medias"][0]["media_url"].string!))", username: item["author"]["username"].string!, place: "Da Nang, Viet Nam", like: item["numoflikes"].int!, caption: item["description"].string!, show: false , userLike: item["like"].boolValue))
                })
            }
        }.resume()
    }
}
class LoadTagDiscover: ObservableObject {
    @Published var loadPopular = [Card]()
    let user = UserDefaults.standard
    func loadPopular(name: String) {
        user.synchronize()
        guard let accessToken = user.string(forKey: "tokenSV") else {return}
        //guard let idUser = user.string(forKey: "idUser") else {return}
        let headers: HTTPHeaders = [
            "Authorization": "\(accessToken)",
            "Content-Type": "application/json"
        ]
        AF.request("\(API.URL)/popular", method: .get, headers: headers).response { response in
            if let json = response.data {
                let data = try! JSON(data: json)
                let content = data["content"].arrayValue
                content.forEach({ item in
                    self.loadPopular.append(Card(id: item["id"].int!, avata: "\(checkHTTP(check: item["author"]["avatar"].string!))", postImage: "\(checkHTTP(check: item["medias"][0]["media_url"].string!))", username: item["author"]["username"].string!, place: "Da Nang, Viet Nam", like: item["numoflikes"].int!, caption: item["description"].string!, show: false , userLike: item["like"].boolValue))
                })
            }
        }.resume()
    }
}
//class LoadTagPlances: ObservableObject {
//    @Published var loadTag = [Card]()
//    let user = UserDefaults.standard
//    func loadTag(name:String){
//        user.synchronize()
//        guard let accessToken = user.string(forKey: "tokenSV") else {return}
//        //guard let idUser = user.string(forKey: "idUser") else {return}
//        let headers: HTTPHeaders = [
//            "Authorization": "\(accessToken)",
//            "Content-Type": "application/json"
//        ]
//        print("HDMM\(name)")
//        AF.request("\(API.URL)/tags/Places)", method: .get, headers: headers).response { response in
//            if let json = response.data {
//                let data = try! JSON(data: json)
//                let content = data["posts"].arrayValue
//                content.forEach({ item in
//                    self.loadTag.append(Card(id: item["id"].int!, avata: "\(checkHTTP(check: item["author"]["avatar"].string!))", postImage: "\(checkHTTP(check: item["medias"][0]["media_url"].string!))", username: item["author"]["username"].string!, place: "Da Nang, Viet Nam", like: item["numoflikes"].int!, caption: item["description"].string!, show: false , userLike: item["like"].boolValue))
//                })
//            }
//        }.resume()
//    }
//}
class LoadLikeList: ObservableObject {
    @Published var dataLike = [SearchData]()
    let user = UserDefaults.standard
    func LoadList(id: Int) {
        user.synchronize()
        guard let accessToken = user.string(forKey: "tokenSV") else {return}
        //guard let idUser = user.string(forKey: "idUser") else {return}
        let headers: HTTPHeaders = [
            "Authorization": "\(accessToken)",
            "Content-Type": "application/json"
        ]
        AF.request("\(API.URL)/likes/\(id)", method: .get, headers: headers).response{ response in
            if let json = response.data {
                let data = try! JSON(data: json)
                let content = data.arrayValue
                content.forEach({item in
                    self.dataLike.append(SearchData(id: item["id"].int!, image: checkHTTP(check: item["avatar"].string!), username: item["username"].string!, name: "cho update", check: item["following"].int! == 1 ? true : false))
                })
            }
        }.resume()
    }
}
class LoadComment: ObservableObject {
    @Published var dataComment = [DataComment]()
    let user = UserDefaults.standard
    func loadCommentOfDetail(id: Int){
        user.synchronize()
        guard let accessToken = user.string(forKey: "tokenSV") else {return}
        //guard let idUser = user.string(forKey: "idUser") else {return}
        let headers: HTTPHeaders = [
            "Authorization": "\(accessToken)",
            "Content-Type": "application/json"
        ]
        AF.request("\(API.URL)/comments/\(id)?sortBy=created", method: .get, encoding: JSONEncoding.default, headers: headers).response { [self] response in
        if let json = response.data {
            let data = try! JSON(data: json)
            let content = data["content"].arrayValue
            content.forEach({ item in
                dataComment.append(DataComment(id: item["id"].int!, avatar: "\(checkHTTP(check: item["author"]["avatar"].string!))", username: item["author"]["username"].string!, comment: item["content"].string!, time: toDate(dateString: item["created"].string!)))
            })
        }
        }.resume()
    }
    func AddComment(postID: Int,content: String) {
        user.synchronize()
        guard let accessToken = user.string(forKey: "tokenSV") else {return}
        let headers: HTTPHeaders = [
            "Authorization": "\(accessToken)",
            "Content-Type": "application/json"
        ]
        let parameters: [String: Any] = [
            "post": [
                "id": postID
            ],
            "content": content
        ]
        AF.request("\(API.URL)/comments/add", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).response { [self] response in
            if let json = response.data {
                let data = try! JSON(data: json)
//                print("Day la cmt\(data)")
                dataComment.insert(DataComment(id: data["id"].int!, avatar: "\(checkHTTP(check: data["author"]["avatar"].string!))", username: data["author"]["username"].string!, comment: data["content"].string!, time: toDate(dateString: data["created"].string!)), at: 0)
            }
        }

    }

}
class LoadFollow: ObservableObject {
    @Published var dataUserFollowing = [SearchData]()
    @Published var dataUserFollowers = [SearchData]()

    let user = UserDefaults.standard
    func LoadFollowing(id: Int) {
        user.synchronize()
        guard let accessToken = user.string(forKey: "tokenSV") else {return}
        //guard let idUser = user.string(forKey: "idUser") else {return}
        let headers: HTTPHeaders = [
            "Authorization": "\(accessToken)",
            "Content-Type": "application/json"
        ]
        AF.request("\(API.URL)/followings/\(id)", method: .get, headers: headers).response{ response in
            if let json = response.data {
                let data = try! JSON(data: json)
                let content = data.arrayValue
                content.forEach({item in
                    self.dataUserFollowing.append(SearchData(id: item["id"].int!, image: checkHTTP(check: item["avatar"].string!), username: item["username"].string!, name: "cho update", check: item["following"].int! == 1 ? true : false))
                })
            }
        }.resume()
    }
    func LoadFollowers(id: Int) {
        user.synchronize()
        guard let accessToken = user.string(forKey: "tokenSV") else {return}
        //guard let idUser = user.string(forKey: "idUser") else {return}
        let headers: HTTPHeaders = [
            "Authorization": "\(accessToken)",
            "Content-Type": "application/json"
        ]
        AF.request("\(API.URL)/followers/\(id)", method: .get, headers: headers).response{ response in
            if let json = response.data {
                let data = try! JSON(data: json)
                let content = data.arrayValue
                content.forEach({item in
                    self.dataUserFollowers.append(SearchData(id: item["id"].int!, image: checkHTTP(check: item["avatar"].string!), username: item["username"].string!, name: "cho update", check: item["following"].int! == 1 ? true : false))
                })
            }
        }.resume()
    }
}
func FollowAndUnfollow(id: Int) {
    let user = UserDefaults.standard
    user.synchronize()
    guard let accessToken = user.string(forKey: "tokenSV") else {return}
    let headers: HTTPHeaders = [
        "Authorization": "\(accessToken)",
        "Content-Type": "application/json"
    ]
//    let parameters: [String: Any] = [
//            "id": id
//    ]
    let parameters = ["id": id]
    AF.request("\(API.URL)/follow", method: .post, parameters: parameters,encoding: JSONEncoding.default, headers: headers).response {response in
        if let json = response.data {
            let data = try! JSON(data: json)
            print("follow \(data)")
        }
    }
}
func checkHTTP(check: String) -> String{
    if check.hasPrefix("http") {
        return check
    }
    else {
        return "\(IMG.URL)\(check)"
    }
}
func isLikePost(id: Int){
    let user = UserDefaults.standard
    user.synchronize()
    guard let accessToken = user.string(forKey: "tokenSV") else {return}
    let headers: HTTPHeaders = [
        "Authorization": "\(accessToken)",
        "Content-Type": "application/json"
    ]
    let parameters: [String: Any] = [
        "post": [
            "id": id
        ]
    ]

    AF.request("http://congchuabuoito.southeastasia.cloudapp.azure.com/likes/", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).response { response in
        if let json = response.data {
            let data = try! JSON(data: json)
            print(data)
        }
    }.resume()
}
class CMTMD: ObservableObject  {
    @Published var dataCMT = [DataComment]()
    let user = UserDefaults.standard
//    var itemID: Int = 11
    func setID(_ id: Int){
        user.synchronize()
        guard let accessToken = user.string(forKey: "tokenSV") else {return}
        let headers: HTTPHeaders = [
            "Authorization": "\(accessToken)",
            "Content-Type": "application/json"
        ]
        AF.request("http://congchuabuoito.southeastasia.cloudapp.azure.com/comments/\(id)?sortBy=created", method: .get, encoding: JSONEncoding.default, headers: headers).response { [self] response in
        if let json = response.data {
            let data = try! JSON(data: json)
            let content = data["content"].arrayValue
            print("dm\(content)")
            content.forEach({ item in
                dataCMT.append(DataComment(id: item["id"].int!, avatar: "\(IMG.URL)\(item["author"]["avatar"].string!)", username: item["author"]["username"].string!, comment: item["content"].string!, time: toDate(dateString: item["created"].string!)))
            })
        }
        }.resume()
    }
    
//    init(id: Int) {
//        user.synchronize()
//        guard let accessToken = user.string(forKey: "tokenSV") else {return}
//        let headers: HTTPHeaders = [
//            "Authorization": "\(accessToken)",
//            "Content-Type": "application/json"
//        ]
//        AF.request("http://congchuabuoito.southeastasia.cloudapp.azure.com/comments/11?sortBy=created", method: .get, encoding: JSONEncoding.default, headers: headers).response { [self] response in
//        if let json = response.data {
//            let data = try! JSON(data: json)
//            let content = data["content"].arrayValue
////            print("dm\(content)")
//            content.forEach({ item in
//                dataCMT.append(DataComment(id: item["id"].int!, avatar: "\(IMG.URL)\(item["author"]["avatar"].string!)", username: item["author"]["username"].string!, comment: item["content"].string!, time: toDate(dateString: item["created"].string!)))
//            })
//        }
//        }.resume()
//    }
}
struct IMG {
    static let URL:String = "http://congchuabuoito.southeastasia.cloudapp.azure.com/img/"
}
struct API {
    static let URL:String = "http://congchuabuoito.southeastasia.cloudapp.azure.com/"
}

func toDate(dateString:String) -> String {
    let formatter = ISO8601DateFormatter()
    formatter.formatOptions = [ .withInternetDateTime, .withFractionalSeconds, .withTime ]
    let date = formatter.date(from: dateString)
    let calendar = Calendar.current
    let hour = calendar.component(.hour, from: date!)
    let min = calendar.component(.minute, from: date!)
    return "\(hour)" + ":" + "\(min)"
}

func NewPost(image: String, caption: String, hashtag: String){
    let user = UserDefaults.standard
    user.synchronize()
    guard let accessToken = user.string(forKey: "tokenSV") else {return}
    let headers: HTTPHeaders = [
        "Authorization": "\(accessToken)",
        "Content-Type": "application/json"
    ]
   
    let parameters: [String: Any] = [
        "description": caption,
        "hashtags": [
            ["tagname": hashtag]
        ],
        "medias": [
            ["media_type":"jpeg",
            "media_url": image]
        ]
    ]
    print(parameters)
    AF.request("\(API.URL)add", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).response { response in
        if let json = response.data {
            let data = try! JSON(data: json)
            print(data)
        }
    }.resume()
}

func setID(_ id: Int){
    let user = UserDefaults.standard
    user.synchronize()
    guard let accessToken = user.string(forKey: "tokenSV") else {return}
    let headers: HTTPHeaders = [
        "Authorization": "\(accessToken)",
        "Content-Type": "application/json"
    ]
    AF.request("http://congchuabuoito.southeastasia.cloudapp.azure.com/comments/\(id)?sortBy=created", method: .get, encoding: JSONEncoding.default, headers: headers).response { response in
    if let json = response.data {
        let data = try! JSON(data: json)
        let content = data["content"].arrayValue
//        print("dm\(content)")
        content.forEach({ item in
            dataComment.append(DataComment(id: item["id"].int!, avatar: "\(IMG.URL)\(item["author"]["avatar"].string!)", username: item["author"]["username"].string!, comment: item["content"].string!, time: toDate(dateString: item["created"].string!)))
        })
    }
    }.resume()
}
func reportPost(idPost: Int, titleReport: String){
    let user = UserDefaults.standard
    user.synchronize()
    guard let accessToken = user.string(forKey: "tokenSV") else {return}
    let headers: HTTPHeaders = [
        "Authorization": "\(accessToken)",
        "Content-Type": "application/json"
    ]
    let parameters: [String: Any] = [
        "reportCriterias":[
            "criteriaName": titleReport
        ]
    ]
    AF.request("\(API.URL)/post/report/\(idPost)", method: .post, parameters: parameters,encoding: JSONEncoding.default, headers: headers).response{ response in
        if let json = response.data{
            let data = try! JSON(data: json)
            print(data)
        }
    }
}
