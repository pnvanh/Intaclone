//
//  ProfileContent.swift
//  Intaclone
//
//  Created by Viet Anh on 18/12/2020.
//

import SwiftUI
import SDWebImageSwiftUI
import Alamofire
import SwiftyJSON
import WaterfallGrid
struct ProfileContent: View {
    @State var showingModal = false
    var body: some View {
        NavigationView {
            VStack {
                ZStack (alignment: .leading) {
                    Rectangle().fill(Color("Color")).frame(width: UIScreen.main.bounds.width, height: 40, alignment: .center)
                    HStack {
                        Text("Profile").font(Font.custom("Lobster-Regular", size: 28)).padding(.leading)
                        Spacer()
                        Button(action: {
                            self.showingModal.toggle()
                        }, label: {
                            Image(systemName: "plus")
                                .foregroundColor(.white)
                                .frame(width: 26, height: 26, alignment: .center)
                                .padding(.all,5)
                        })
                        .background(Color("Bluesky"))
                        .clipShape(Capsule())
                        .padding(.horizontal)
                        .sheet(isPresented: $showingModal, content: {
                            AddView.init(showingModal: self.$showingModal, userAvatar: "\(UserDefaults.standard.string(forKey: "avatar")!)", username: "\(UserDefaults.standard.string(forKey: "username")!)", fullName: "\(UserDefaults.standard.string(forKey: "fullname")!)")
                        })
                    }
                }
                ProfileView()
            }
            .navigationBarHidden(true)
        }
        .onAppear{
      
        }
    }
}

struct ProfileContent_Previews: PreviewProvider {
    static var previews: some View {
        ProfileContent()
    }
}
struct ProfileView: View {
    @ObservedObject var LoadImageByUserOBS = LoadListPostByUser()
    @ObservedObject var LoadUserOBS = LoadUser()
    @State private var showEditView = false
    
    let girdTag = [
        GridItem(.flexible(minimum: 160, maximum: 180)),
        GridItem(.flexible(minimum: 160, maximum: 180))
    ]

    var body: some View {
        GeometryReader { reader in
            ScrollView {
                ForEach(LoadUserOBS.dataUserProfile) { item in
                    ZStack {
                        Image("post")
                            .resizable()
                            .frame(width: reader.size.width, height: reader.size.height, alignment: .center)
                        VStack {
                            Spacer()
                            ZStack(alignment: .topLeading) {
                                Rectangle()
                                    .fill(Color("Color"))
                                    .frame(width: reader.size.width, height: 250, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                VStack(alignment: .leading) {
                                    HStack {
                                        WebImage(url: URL(string: item.avatar))
                                            .resizable()
                                            .clipShape(Circle())
                                            .frame(width: 100, height: 100, alignment: .center).padding(.top, -50)
                                        Spacer()
//                                        FollowView(isFollow: item.check, idUser: item.id)
                                        .frame(width: reader.size.width - 130, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 2))
                                            .cornerRadius(10)
                                        Spacer()
                                    }.padding(.horizontal)
                                    .frame(width: reader.size.width)
                                    VStack(alignment: .leading, spacing: 5) {
                                        Text("\(item.fullname)")
                                            .font(.system(size: 20))
                                            .lineLimit(1)
                                        Text("@\(item.username)")
                                            .font(.system(size: 18))
                                            .lineLimit(1)
                                        Text("\(item.bio)")
                                            .font(.system(size: 18))
                                            .lineLimit(1)
                                    }.padding(.horizontal)
                                    HStack(spacing: 0) {
                                        NavigationLink(
                                            destination: SearchList(LoadFollowingOBS: LoadFollow(), text: "", nameTitle: "Following", typeLoad: false, idLoad: item.id) ) {
                                            VStack{
                                                Text("\(item.numOfFollowings)")
                                                    .font(.system(size: 20))
                                                    .lineLimit(1)
                                                    .foregroundColor(Color("CColor"))
                                                Text("Following")
                                                    .font(.system(size: 18))
                                                    .lineLimit(1)
                                                    .foregroundColor(Color("CColor"))
                                            }.frame(width: reader.size.width / 2)
                                        }
                                        NavigationLink(
                                            destination: SearchList(LoadFollowingOBS: LoadFollow(), text: "", nameTitle: "Followers", typeLoad: true, idLoad: item.id) ) {
                                            VStack{
                                                Text("\(item.numOfFollowers)")
                                                    .font(.system(size: 20))
                                                    .lineLimit(1)
                                                    .foregroundColor(Color("CColor"))
                                                Text("Followers")
                                                    .font(.system(size: 18))
                                                    .lineLimit(1)
                                                    .foregroundColor(Color("CColor"))
                                            }.frame(width: reader.size.width / 2)
                                        }

                                    }.frame(width: reader.size.width)
                                    .padding(.top, 10)
                                }

                            }
                        }.frame(width: reader.size.width, height: reader.size.height, alignment: .center)
                    }
                    VStack {
                        WaterfallGrid(LoadImageByUserOBS.dataImage, id: \.self){ item in
                            NavigationLink(destination: DetailPost(dataDetail: item)) {
                                WebImage(url: URL(string: item.postImage))
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .cornerRadius(15)
                            }
                        }
                        .gridStyle(columns: 2)
                        .padding(.horizontal)
                        .onAppear{
                            LoadImageByUserOBS.loadImage(id: item.id)
                        }
                    }
                }
            }
            .onAppear{
                LoadImageByUserOBS.dataImage.removeAll()
            }
        }
    }
}

struct DataUser: Codable, Identifiable, Hashable {
    var id: Int
    var avatar: String
    var username:String
    var fullname:String
    var numOfFollowings: Int
    var numOfFollowers: Int
    var cover:String
    var bio:String
    var followStatus:Bool
}

//                    VStack(alignment: .center,spacing: 15) {
//                        ForEach(LoadImageByUserOBS.dataImage ,id: \.self){item in
//                            HStack{
//                               NavigationLink(destination: DetailPost(dataDetail: item)) {
//                                    WebImage(url: URL(string: item.postImage))
//                                        .resizable()
//                                }
//                            }
//                            .frame(height: 300, alignment:.center)
//                        }
//                    }
//                    .onAppear{
//                        LoadImageByUserOBS.loadImage(id: item.id)
//                    }
//                    .padding(.horizontal, 15)
//                    .cornerRadius(15)
//                    LazyVGrid(columns: girdTag){
//                        ForEach(LoadImageByUserOBS.dataImage){item in
//                            VStack{
//                                NavigationLink(destination: DetailPost(dataDetail: item)) {
//                                    WebImage(url: URL(string: item.postImage))
//                //                    Image("\(item.postImage)")
//                                        .resizable()
//                                }
//                            }.cornerRadius(15)
//                            .frame(width: UIScreen.main.bounds.width / 2 - 30, height: 200, alignment:.center)
//                        }
//                    }.padding(.horizontal, 15)
//                    .onAppear{
//                        LoadImageByUserOBS.loadImage(id: item.id)
//                    }
