//
//  ProfileUser.swift
//  IntaClone
//
//  Created by Viet Anh on 22/01/2021.
//

import SwiftUI
import WaterfallGrid
import SDWebImageSwiftUI

//struct ProfileUser: View {
//    @State var show = false
//    var body: some View {
//        NavigationView {
//            VStack {
//                ZStack (alignment: .leading) {
//                    Rectangle().fill(Color("Color")).frame(width: UIScreen.main.bounds.width, height: 40, alignment: .center)
//                    HStack {
//                        Text("Profile").font(Font.custom("Lobster-Regular", size: 28)).padding(.leading)
//                        Spacer()
//                    }
//                }
//                ProfileUserView()
//            }
//        }
//    }
//}

//struct Profile_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileUser()
//    }
//}
struct ProfileUserView: View {
    @ObservedObject var LoadImageByUserOBS = LoadListPostByUser()
    @ObservedObject var LoadUserOBS = LoadUserDetail()
    @State private var showEditView = false
    @State var idUser:Int
    let girdTag = [
        GridItem(.flexible(minimum: 160, maximum: 180)),
        GridItem(.flexible(minimum: 160, maximum: 180))
    ]
    var body: some View {
        GeometryReader { reader in
            ScrollView {
                ForEach(LoadUserOBS.dataUserOther) { item in
                    ZStack {
                        Image("post").resizable().frame(width: reader.size.width, height: reader.size.height, alignment: .center)
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
                                        FollowView(isFollow: item.followStatus, idUser: item.id)
//                                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
//                                            Text("Edit profile")
//                                                .frame(minWidth: 0, maxWidth: .infinity)
//                                                .foregroundColor(Color("Color2"))
//                                        })
//                                        .frame(width: reader.size.width - 130, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
//                                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color("Color2"), lineWidth: 2))
//                                            .cornerRadius(10)
//                                        Spacer()
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
                                                Text("Followers")
                                                    .font(.system(size: 18))
                                                    .lineLimit(1)
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
                .onAppear{
                    LoadUserOBS.loadProfileInfo(id: idUser)
                    LoadImageByUserOBS.loadImage(id: idUser)
                    LoadUserOBS.dataUserOther.removeAll()
    //                LoadImageByUserOBS.dataImage.removeAll()
                }

            }
        }
    }
}

