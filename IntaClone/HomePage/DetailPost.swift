//
//  DetailPost.swift
//  Intaclone
//
//  Created by Viet Anh on 20/12/2020.
//

import SwiftUI
import SDWebImageSwiftUI
import Alamofire
import SwiftyJSON

struct DetailPost: View {
//    @State var cmt = dataComment
    @ObservedObject var cmt = LoadComment()
    @ObservedObject var likeList = LoadLikeList()
    @State var likeupdate: Int = 0
    @State var dataDetail: Card
    @State var commentText:String  = ""
    @State var height:CGFloat = 0
    @State var keyboardHeight: CGFloat = 0
    @State var userAvatar:String = UserDefaults.standard.string(forKey: "avatar")!
    @State var showListLike = false
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                WebImage(url: URL(string: dataDetail.postImage))
                .resizable()
                    .frame(width: UIScreen.main.bounds.width, height: 550, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .overlay(InfoView(idOfPost: dataDetail.id, avatar: "\(dataDetail.avata)", username: "\(dataDetail.username)", place: "\(dataDetail.username)", countlike: dataDetail.like , caption: "\(dataDetail.caption)", isLike: dataDetail.userLike), alignment: .leading)
                if likeList.dataLike.isEmpty {
                    Text("")
                }
                else{
                    Button {
                        self.showListLike.toggle()
                    } label: {
                        Text("\(likeList.dataLike.count) people liked is post").font(Font.system(size: 18)).padding(.horizontal)
                    }
                    .sheet(isPresented: $showListLike, content: {
                        SearchUser.init(nameTitle: "", typeLoad: false, idLoad: dataDetail.id)
                    })
                }
                
                HStack {
                    WebImage(url: URL(string: userAvatar))
                        .resizable()
                        .frame(width: 50, height: 50, alignment: .center)
                        .clipShape(Circle())
                    HStack {
                        MultiLineText(txt: $commentText, height: $height)
                            .frame(height: self.height < 80  ? self.height : 80)
                            .padding(.horizontal)
                            .background(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/).stroke(Color("Gray"), lineWidth: 1))
                        Button(action: {
                            cmt.AddComment(postID: dataDetail.id, content: commentText)
                        }, label: {
                            Image(systemName: "location.circle.fill")
                                .resizable()
                                .frame(width: 30, height: 30).foregroundColor(Color("Gray"))
                        })
                    }
                }.padding(.horizontal)
                .ignoresSafeArea(.keyboard, edges: .top)
                VStack {
                    ForEach(cmt.dataComment) { item in
                        VStack {
                            HStack(alignment: .top){
                                WebImage(url: URL(string: item.avatar))
                                    .resizable()
                                    .frame(width: 50, height: 50, alignment: .center)
                                    .clipShape(Circle())
                                VStack(alignment: .leading){
                                    Text("\(item.username): ")
                                        .bold()
                                        .font(Font.system(size: 18)) + Text("\(item.comment)").font(.system(size: 15))
                                    Text("\(item.time)")
                                        .font(Font.system(size: 14))
                                        .multilineTextAlignment(.leading)
                                        .lineLimit(1)
                                }
                                Spacer()
                                //co the bo button vao day
                            }
                        }.padding(.horizontal)
                    }
                }.onAppear{
                    cmt.loadCommentOfDetail(id: dataDetail.id)
                }
                .onDisappear{
                    cmt.dataComment.removeAll()
                }
            }
            .onAppear{
                likeList.LoadList(id: dataDetail.id)
            }
        }.navigationBarTitle("Detail", displayMode: .inline)
        
    }
}
//struct DetailPost_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailPost()
//    }
//}
struct MultiLineText: UIViewRepresentable {
    @Binding var txt: String
    @Binding var height: CGFloat
    func makeCoordinator() -> Coordinator {
        return MultiLineText.Coordinator(parent1: self)
    }
    
    func makeUIView(context: Context) -> UITextView {
        let view = UITextView()
        view.isEditable = true
        view.isScrollEnabled = true
        view.font = .systemFont(ofSize: 18)
        view.text = "Write some thing"
        view.textColor = UIColor(named: "CColor")
        view.backgroundColor = .clear
        view.delegate = context.coordinator
        return view
    }
    func updateUIView(_ uiView: UITextView, context: Context) {
        DispatchQueue.main.async {
            self.height = uiView.contentSize.height
        }
    }
    class Coordinator : NSObject, UITextViewDelegate {
        var parent: MultiLineText
        init(parent1: MultiLineText) {
            parent = parent1
        }
        func textViewDidBeginEditing(_ textView: UITextView) {
            textView.text = ""
            textView.textColor = UIColor(named: "CColor")
        }
        func textViewDidChange(_ textView: UITextView) {
            DispatchQueue.main.async {
                self.parent.height = textView.contentSize.height
                self.parent.txt = textView.text
            }
        }
    }
}
struct DataComment: Identifiable, Hashable {
    var id: Int
    var avatar: String
    var username: String
    var comment: String
    var time: String
}
var dataComment = [
    DataComment(id: 0, avatar: "avata", username: "pnvanh", comment: "tren chan anh la doi nike nike low ahihihi", time: "10m"),
]

