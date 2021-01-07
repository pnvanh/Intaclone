//
//  PostCell.swift
//  Intaclone
//
//  Created by Viet Anh on 12/12/2020.
//

import SwiftUI

struct PostCell: View {
 
    var body: some View {
        NavigationView {
            VStack {
                ZStack (alignment: .leading) {
                    Rectangle().fill(Color("Color")).frame(width: UIScreen.main.bounds.width, height: 40, alignment: .center)
                    HStack {
                        Text("Instaclone").font(Font.custom("Lobster-Regular", size: 28)).padding(.leading)
                    }
                }
                ScrollView(showsIndicators: false) {
                    VStack {
                        StoryCell()
                        ForEach(data) { item in
                            NavigationLink(destination: DetailPost(dataDetail: item)) {
                                Image("\(item.postImage)")
                                .resizable()
                                .frame(width: UIScreen.main.bounds.width - 30, height: 450, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                    .overlay(InfoView(avatar: item.avata, username: item.username, place: item.place, countlike: item.like, caption: item.caption), alignment: .leading).cornerRadius(15).padding(.top, 10)
                            }.navigationBarTitle("Home")
                        }
                    }
                }
            }
            .navigationBarHidden(true)
        }
    }
      

}

struct PostCell_Previews: PreviewProvider {
    static var previews: some View {
        PostCell()
    }
}
//
//struct Post : View {
//
//    @State var x : CGFloat = 0
//    @State var count : CGFloat = 0
//    @State var screen = UIScreen.main.bounds.width - 30
//    @State var op : CGFloat = 0
//    var body : some View{
//            VStack{
//                HStack(spacing: 15){
//                    ForEach(data){i in
//                        CardView(data: i)
//                        .offset(x: self.x)
//                        .highPriorityGesture(DragGesture()
//                            .onChanged({ (value) in
//                                if value.translation.width > 0{
//                                    self.x = value.location.x
//                                }
//                                else{
//                                    self.x = value.location.x - self.screen
//                                }
//
//                            })
//                            .onEnded({ (value) in
//                                if value.translation.width > 0{
//                                    if value.translation.width > ((self.screen - 80) / 2) && Int(self.count) != 0{
//
//                                        self.count -= 1
//                                        self.updateHeight(value: Int(self.count))
//                                        self.x = -((self.screen + 15) * self.count)
//                                    }
//                                    else{
//
//                                        self.x = -((self.screen + 15) * self.count)
//                                    }
//                                }
//                                else{
//
//
//                                    if -value.translation.width > ((self.screen - 80) / 2) && Int(self.count) !=  (self.data.count - 1){
//
//                                        self.count += 1
//                                        self.updateHeight(value: Int(self.count))
//                                        self.x = -((self.screen + 15) * self.count)
//                                    }
//                                    else{
//
//                                        self.x = -((self.screen + 15) * self.count)
//                                    }
//                                }
//                            })
//                        )
//                    }
//                }
//                .frame(width: UIScreen.main.bounds.width)
//                .offset(x: self.op)
//            }
//            .animation(.spring())
//            .onAppear {
//
//                self.op = ((self.screen + 15) * CGFloat(self.data.count / 2)) - (self.data.count % 2 == 0 ? ((self.screen + 15) / 2) : 0)
//
//                self.data[0].show = true
//            }
//        }
//
//    func updateHeight(value : Int){
//
//
//        for i in 0..<data.count{
//
//            data[i].show = false
//        }
//
//        data[value].show = true
//    }
//}

//MARK:INFOVIEW
struct InfoView: View {
    @State var avatar: String
    @State var username: String
    @State var place: String
    @State var countlike: String
    @State var caption: String
    var body: some View {
        VStack{
            HStack(alignment: .top){
                Image("\(avatar)")
                    .resizable()
                    .frame(width: 50, height: 50, alignment: .center)
                    .clipShape(Circle())
                VStack(alignment: .leading){
                    Text("\(username)")
                        .font(Font.system(size: 18))
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                        .lineLimit(1)
                        .foregroundColor(.white)
                    Text("\(place)")
                        .font(Font.system(size: 13.5))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.leading)
                        .lineLimit(1)
                }
                Spacer()
                //co the bo button vao day
            }.padding(.all, 10)
            Spacer()
            ZStack{
                HStack{
                    Button(action: {}) {
                        HStack {
                            Image("favorite")
                                .resizable()
                                .frame(width: 26, height: 26, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .colorInvert()
                                .foregroundColor(.white)
                            Text("\(countlike)")
                                .foregroundColor(.white)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                        .padding(.all, 5)
                        .background(Color("Like"))
                        .cornerRadius(50)
                    }
                    Text("\(caption)")
                        .fontWeight(.regular)
                        .foregroundColor(Color.white)
                        .multilineTextAlignment(.leading)
                        .lineLimit(1)
                        .font(.system(size: 18))
                    Spacer()
                }
            }.padding(.all, 10)
        }
    }
}
//struct CardView : View {
//
//    var data : Card
//
//    var body : some View{
//
//        VStack(alignment: .leading, spacing: 0){
//
//            Image(data.post)
//            .resizable()
//                .overlay(InfoView(), alignment: .leading)
//        }
//        .frame(width: UIScreen.main.bounds.width - 30, height: data.show ? 450 : 400)
//        .background(Color.white)
//        .cornerRadius(25)
//    }
//}
struct Card : Identifiable, Hashable {
    var id: Int
    var avata: String
    var postImage: String
    var username: String
    var place: String
    var like: String
    var caption: String
    var show: Bool
}
var data = [
    Card(id: 0, avata: "avata", postImage: "post", username: "pnvanh", place: "Da Nang, Viet Nam", like: "1232", caption: "Chan mang doi nike low", show: false),
    Card(id: 1, avata: "avata", postImage: "post2", username: "pnvanh", place: "Da Nang, Viet Nam", like: "122", caption: "Chan mang doi nike low2", show: false),
    Card(id: 2, avata: "avata", postImage: "post3", username: "pnvanh", place: "Da Nang, Viet Nam", like: "12", caption: "Chan mang doi nike low3", show: false),
    Card(id: 3, avata: "avata", postImage: "test", username: "pnvanh", place: "Da Nang, Viet Nam", like: "1232", caption: "Chan mang doi nike low4", show: false),
]
