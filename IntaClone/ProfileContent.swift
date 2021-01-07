//
//  ProfileContent.swift
//  Intaclone
//
//  Created by Viet Anh on 18/12/2020.
//

import SwiftUI

struct ProfileContent: View {
    var body: some View {
        NavigationView {
            VStack {
                ZStack (alignment: .leading) {
                    Rectangle().fill(Color("Color")).frame(width: UIScreen.main.bounds.width, height: 40, alignment: .center)
                    HStack {
                        Text("Profile").font(Font.custom("Lobster-Regular", size: 28)).padding(.leading)
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
                                        .frame(width: 120, height: 120, alignment: .center).padding(.top, -60)
                                    Spacer()
                                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                                        Text("Edit profile")
                                            .frame(minWidth: 0, maxWidth: .infinity)
                                            .foregroundColor(Color("Gray"))
                                    })
                                    .frame(width: reader.size.width - 150, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color("Gray"), lineWidth: 2))
                                        .cornerRadius(10)
                                    Spacer()
                                }.frame(width: reader.size.width)
                                Text("Phan Ngoc Viet Anh")
                                    .font(.system(size: 28))
                                    .lineLimit(1)
                                Text("@pnvanh")
                                    .font(.system(size:20))
                                    .lineLimit(1)
                                Text("Đẹp trai thanh lịch vô địch vũ trụ")
                                    .font(.system(size:20))
                                    .lineLimit(1)
                                HStack() {
                                    
                                }
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
