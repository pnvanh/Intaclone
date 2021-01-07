//
//  DetailPost.swift
//  Intaclone
//
//  Created by Viet Anh on 20/12/2020.
//

import SwiftUI

struct DetailPost: View {
    @State var dataDetail: Card
    @State var commentText:String  = ""
    @State var height:CGFloat = 0
    @State var keyboardHeight: CGFloat = 0
    var body: some View {
        ScrollView {
            VStack {
                Image("post")
                .resizable()
                    .frame(width: UIScreen.main.bounds.width, height: 550, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .overlay(InfoView(avatar: "\(dataDetail.avata)", username: "\(dataDetail.username)", place: "\(dataDetail.username)", countlike: "\(dataDetail.like)", caption: "\(dataDetail.caption)"), alignment: .leading)
                HStack {
                    Image("\(dataDetail.postImage)")
                        .resizable()
                        .frame(width: 50, height: 50, alignment: .center)
                        .clipShape(Circle())
                    HStack {
                        MultiLineText(txt: $commentText, height: $height)
                            .frame(height: self.height < 80  ? self.height : 80)
                            .padding(.horizontal)
                            .background(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/).stroke(Color("Gray"), lineWidth: 1))
                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                            Image(systemName: "location.circle.fill")
                                .resizable()
                                .frame(width: 30, height: 30).foregroundColor(Color("Gray"))
                        })
                    }
                }.padding(.horizontal)
                ForEach(dataComment) { item in
                    VStack {
                        HStack(alignment: .top){
                            Image("\(item.avatar)")
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
            }
        }.navigationBarTitle("", displayMode: .inline)
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
        view.text = "Enter Comment"
        view.textColor = UIColor.gray.withAlphaComponent(0.3)
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
            textView.textColor = .black
        }
        func textViewDidChange(_ textView: UITextView) {
            DispatchQueue.main.async {
                self.parent.height = textView.contentSize.height
                self.parent.txt = textView.text
            }
        }
    }
}
struct DataComment: Identifiable {
    var id = UUID()
    var avatar: String
    var username: String
    var comment: String
    var time: String
}
var dataComment = [
    DataComment(avatar: "avata", username: "pnvanh", comment: "tren chan anh la doi nike nike low ahihihi", time: "10m"),
    DataComment(avatar: "avata", username: "pnvanh1", comment: "tren chan anh la doi nike nike low ahihihi ahihi", time: "21m"),
    DataComment(avatar: "avata", username: "pnvanh2", comment: "tren chan anh la doi nike dep vai", time: "1h"),
    DataComment(avatar: "avata", username: "pnvanh2", comment: "tren chan anh la doi nike", time: "5h")
]
