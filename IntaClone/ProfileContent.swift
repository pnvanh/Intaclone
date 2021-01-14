//
//  ProfileContent.swift
//  Intaclone
//
//  Created by Viet Anh on 18/12/2020.
//

import SwiftUI

struct ProfileContent: View {
    @State var show = false
    var body: some View {
        NavigationView {
            VStack {
                ZStack (alignment: .leading) {
                    Rectangle().fill(Color("Color")).frame(width: UIScreen.main.bounds.width, height: 40, alignment: .center)
                    HStack {
                        Text("Profile").font(Font.custom("Lobster-Regular", size: 28)).padding(.leading)
                        Spacer()
                        Button(action: {
                            self.show.toggle()
                        }, label: {
                            Text("Add")
                                .foregroundColor(.white)
                                .padding(.vertical, 5)
                                .frame(width: 60)
                        })
                        .background(Color("Bluesky"))
                        .clipShape(Capsule())
                        .padding(.horizontal)
                        .sheet(isPresented: $show, content: {
                            AddView.init()
                        })
                    }
                }
                ProfileView()
            }
            .navigationBarHidden(true)
        }
    }
}

struct ProfileContent_Previews: PreviewProvider {
    static var previews: some View {
        ProfileContent()
    }
}
struct ProfileView: View {
    var body: some View {
        GeometryReader { reader in
            ScrollView {
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
                                    Image("avata")
                                        .resizable()
                                        .clipShape(Circle())
                                        .frame(width: 100, height: 100, alignment: .center).padding(.top, -50)
                                    Spacer()
                                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                                        Text("Edit profile")
                                            .frame(minWidth: 0, maxWidth: .infinity)
                                            .foregroundColor(Color("Color2"))
                                    })
                                    .frame(width: reader.size.width - 130, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color("Color2"), lineWidth: 2))
                                        .cornerRadius(10)
                                    Spacer()
                                }.padding(.horizontal)
                                .frame(width: reader.size.width)
                                VStack(alignment: .leading, spacing: 5) {
                                    Text("Phan Ngoc Viet Anh")
                                        .font(.system(size: 20))
                                        .lineLimit(1)
                                    Text("@pnvanh")
                                        .font(.system(size: 18))
                                        .lineLimit(1)
                                    Text("Đẹp trai thanh lịch vô địch vũ trụ")
                                        .font(.system(size: 18))
                                        .lineLimit(1)
                                }.padding(.horizontal)
                                HStack(spacing: 0) {
                                    NavigationLink(
                                        destination: SearchList(text: "", nameTitle: "Following")) {
                                        VStack{
                                            Text("182")
                                                .font(.system(size: 20))
                                                .lineLimit(1)
                                            Text("Following")
                                                .font(.system(size: 18))
                                                .lineLimit(1)
                                        }.frame(width: reader.size.width / 2)
                                    }
                                    NavigationLink(
                                        destination: SearchList(text: "", nameTitle: "Followers")) {
                                        VStack{
                                            Text("18")
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
                DiscoveryCardTag(dataCard: dataCard)
            }
        }
    }
}
//var dataCardac = [
//    CardDiscovery(id: 0, image: "post"),
//    CardDiscovery(id: 1, image: "post3"),
//    CardDiscovery(id: 2, image: "post2"),
//    CardDiscovery(id: 3, image: "bg"),
//    CardDiscovery(id: 4, image: "test")
//]
