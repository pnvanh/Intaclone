//
//  ActivityContent.swift
//  Intaclone
//
//  Created by Viet Anh on 18/12/2020.
//

import SwiftUI

struct ActivityContent: View {
    var body: some View {
        NavigationView {
            VStack {
                ZStack (alignment: .leading) {
                    Rectangle().fill(Color("Color")).frame(width: UIScreen.main.bounds.width, height: 40, alignment: .center)
                    HStack {
                        Text("Activity").font(Font.custom("Lobster-Regular", size: 28)).padding(.leading)
                    }
                }
                Notification()
            }
            .navigationBarHidden(true)
        }
    }
}

struct ActivityContent_Previews: PreviewProvider {
    static var previews: some View {
        ActivityContent()
    }
}

struct Notification: View {
//    @State var dataNoti: [DataNotification]
    var body: some View {
        ScrollView(showsIndicators: false){
            VStack(alignment: .leading) {
                Text("Notification").bold().font(.system(size: 20))
                ForEach(dataNoti) { item in
                    HStack{
                        Image("\(item.avata)")
                            .resizable()
                            .frame(width: 50, height: 50, alignment: .center)
                            .clipShape(Circle())
                        VStack(alignment: .leading){
                            Text("\(item.username)" + ": \(item.content)")
                                .font(Font.system(size: 18))
                                .multilineTextAlignment(.leading)
                                .lineLimit(2)
                            Text("\(item.time)")
                                .font(Font.system(size: 13.5))
                                .multilineTextAlignment(.leading)
                                .lineLimit(1)
                        }
                        Spacer()
                        Image("\(item.image)")
                            .resizable()
                            .frame(width: 50, height: 50, alignment: .center)
                            .cornerRadius(10)
                    }
                }
                Text("Recomment for you").bold().font(.system(size: 20))
                ForEach(dataFR) { item in
                    HStack{
                        Image("\(item.avata)")
                            .resizable()
                            .frame(width: 50, height: 50, alignment: .center)
                            .clipShape(Circle())
                        Text("\(item.username)" + ": \(item.content)")
                            .font(Font.system(size: 18))
                            .multilineTextAlignment(.leading)
                            .lineLimit(2)
                        Spacer()
                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                            Text("Follow")
                                .bold()
                                .foregroundColor(.white)
                        })
                        .frame(width: 65, height: 35, alignment: .center)
                        .background(Color("Bluesky"))
                        .cornerRadius(5)
                    }
                }
            }
        }.padding(.horizontal)
    }
}
struct DataNotification: Identifiable {
    var id = UUID()
    var avata: String
    var image: String
    var username: String
    var content: String
    var time: String
}
struct DataFollowRecomment: Identifiable {
    var id = UUID()
    var avata: String
    var username: String
    var content: String
}
var dataNoti = [
    DataNotification(avata: "avata", image: "post", username: "congchuabuoito", content: "like your post: tap dem a chu", time: "3 minutes ago"),
    DataNotification(avata: "avata", image: "post2", username: "pnvanh", content: "commented your post: mot hai ba bon nam sau bay tam", time: "13 minutes ago"),
    DataNotification(avata: "avata", image: "post3", username: "pnvanh", content: "mentioned you in a comment:  ahihi do ngoc", time: "34 minutes ago"),
    DataNotification(avata: "avata", image: "bg", username: "pnvchi", content: "commented your post: mot hai ba bon nam sau bay tam", time: "3 hours ago"),
    DataNotification(avata: "avata", image: "test", username: "pnvem", content: "mentioned you in a comment:  ahihi do ngoc", time: "4 hours ago"),
]
var dataFR = [
    DataFollowRecomment(avata: "avata", username: "pnvchi", content: "who you might know, on Intaclone"),
    DataFollowRecomment(avata: "avata", username: "pnvchi", content: "who you might know, on Intaclone"),
    DataFollowRecomment(avata: "avata", username: "pnvchi", content: "who you might know, on Intaclone")
]
