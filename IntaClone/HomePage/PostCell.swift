//
//  PostCell.swift
//  Intaclone
//
//  Created by Viet Anh on 12/12/2020.
//

import SwiftUI
import GoogleSignIn
import Alamofire
import SwiftyJSON
import SDWebImageSwiftUI
import ToastUI
import SimpleToast
struct PostCell: View {
    @ObservedObject var NewFeedOBS = NewFeed()
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
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
//                        NewFeedOBS.dataNewFeedFeed
                        ForEach(NewFeedOBS.dataNewFeedFeed) { item in
                            NavigationLink(destination: DetailPost(dataDetail: item)) {
                                WebImage(url: URL(string: item.postImage))
                                .resizable()
                                .frame(width: UIScreen.main.bounds.width - 30, height: 450, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                    .overlay(InfoView(idOfPost: item.id, avatar: item.avata, username: item.username, place: item.place, countlike: (item.like), caption: item.caption , isLike: item.userLike), alignment: .leading).cornerRadius(15).padding(.top, 10)
                            }.navigationBarTitle("Home")
                        }
                    }
                }
            }
            .navigationBarHidden(true)
        }
        .onAppear{
            NewFeedOBS.loadRecomment()
            NewFeedOBS.dataNewFeedFeed.removeAll()
            NewFeedOBS.reloadData()
        }
        .onDisappear{
            
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
    @State var idOfPost: Int
    @State var avatar: String
    @State var username: String
    @State var place: String
    @State var countlike: Int
    @State var caption: String
    @State var isLike:Bool
    @State var showActionSheet = false
    @State var showToast = false
    @State var showToastSelf = false
    
    private let toastOptions = SimpleToastOptions(
        alignment: .center ,
        hideAfter: 1.0,
        backdrop: true,
        backdropColor: Color.black.opacity(0.2),
        animation: .linear,
        modifierType: .fade)
    var body: some View {
        VStack{
            HStack(alignment: .center){
                WebImage(url: URL(string: avatar))
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
                Button(action: {
                    let user = UserDefaults.standard
                    user.synchronize()
                    guard let userPostCheck = user.string(forKey: "username") else {return}
                    if username != userPostCheck {
                        self.showActionSheet.toggle()
                    }
                    else{
                        self.showToastSelf.toggle()
                    }
                }) {
                    Image(systemName: "ellipsis")
                        .frame(width: 26, height: 26, alignment: .top)
                        .foregroundColor(.white)
                }
                .actionSheet(isPresented: $showActionSheet) {
                    ActionSheet(title: Text("Report"), message: Text("Report this post"), buttons: [
                        .default(Text("Nudity or sexual activity"), action: {
                            reportPost(idPost: idOfPost, titleReport: "Nudity_or_sexual_activity")
                            self.showToast.toggle()
                        }),
                        .default(Text("Spam"), action: {
                            reportPost(idPost: idOfPost, titleReport: "Spam")
                            self.showToast.toggle()
                        }),
                        .default(Text("Inappropriate language"), action: {
                            reportPost(idPost: idOfPost, titleReport: "Inappropriate_Language")
                            self.showToast.toggle()
                        }),
                        .cancel()
                    ])
                }
                
            }.padding(.all, 10)
            Spacer()
            ZStack{
                HStack{
                    Button(action: {
                        self.isLike.toggle()
                        isLikePost(id: idOfPost)
                        if !isLike {
                            self.countlike = countlike - 1
                        }
                        else {
                            self.countlike = countlike + 1
                        }
                    }) {
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
                        .background(isLike ? Color("Like") : Color.gray)
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
        .simpleToast(isShowing: $showToast, options: toastOptions, completion: onToastComplete) {
            HStack {
                Image(systemName: "checkmark.circle.fill")
                Text("This is post has been report !")
            }
            .padding()
            .background(Color.green.opacity(0.8))
            .foregroundColor(Color.white)
            .cornerRadius(10)
        }
        .simpleToast(isShowing: $showToastSelf, options: toastOptions, completion: onToastComplete) {
            HStack {
                Image(systemName: "exclamationmark.triangle")
                Text("You can not report yourself !")
            }
            .padding()
            .background(Color.yellow.opacity(0.8))
            .foregroundColor(Color.white)
            .cornerRadius(10)
        }

    }
    
//    var actionSheet: ActionSheet {
//        ActionSheet(title: Text("Report"), message: Text("Report this post"), buttons: [
//            .default(Text("Nudity or sexual activity"), action: {
//
//            }),
//            .default(Text("Racism"), action: {
//                print("racism")
//            }),
//            .default(Text("Spam"), action: {
//                print("Spam")
//            }),
//            .default(Text("Verbal insults"), action: {
//                print("")
//            }),
//            .cancel()
//        ])
//    }
    // This will be called on toast completion
        func onToastComplete() -> Void {
            print("The toast did disappear")
        }
}

struct Card : Identifiable, Hashable {
    var id: Int
    var avata: String
    var postImage: String
    var username: String
    var place: String
    var like: Int
    var caption: String
    var show: Bool
    var userLike: Bool
}

