//
//  SearchUser.swift
//  IntaClone
//
//  Created by Viet Anh on 20/01/2021.
//

//
//  SearchList.swift
//  Intaclone
//
//  Created by Viet Anh on 14/12/2020.
//

import SwiftUI
import SDWebImageSwiftUI
struct SearchUser: View {
    @ObservedObject var SearchUserOBS = FindUser()
    @ObservedObject var ListLikeOBS = LoadLikeList()
    @State var text:String = ""
    @State var nameTitle:String
    @State var typeLoad:Bool
    @State var idLoad:Int
    @State var showUseDetail:Bool = false
    var body: some View {
        NavigationView{
            ScrollView{
                VStack{
                    SearchView(text: $text).padding(.bottom, 10).colorMultiply(Color.gray)
                    ForEach(typeLoad ? SearchUserOBS.dataFindUser : ListLikeOBS.dataLike.filter({ text.isEmpty || "\($0)".contains(text.lowercased())})) { item in
                        NavigationLink(destination: ProfileUserView(idUser: item.id)) {
                            HStack(alignment: .center){
                                WebImage(url: URL(string: item.image))
                                    .resizable()
                                    .frame(width: 50, height: 50, alignment: .center)
                                    .clipShape(Circle())
                                VStack(alignment: .leading){
                                    Text("\(item.username)")
                                        .font(Font.system(size: 18))
                                        .fontWeight(.bold)
                                        .multilineTextAlignment(.leading)
                                        .lineLimit(1)
                                        .foregroundColor(Color("CColor"))
                                    Text("\(item.name)")
                                        .font(Font.system(size: 13.5))
                                        .multilineTextAlignment(.leading)
                                        .lineLimit(1)
                                        .foregroundColor(Color("CColor"))
                                }
                                Spacer()
                                FollowView(isFollow: item.check, idUser: item.id)
                            }.padding(.horizontal)
                        }
                    }
                }
            }.padding(.top, 20)
            .navigationBarTitle(self.nameTitle, displayMode: .inline)
            .navigationTitle("")
            .onAppear{
                ListLikeOBS.LoadList(id: self.idLoad)
            }
        }
    }
}
struct FollowView: View {
    @State var isFollow: Bool
    @State var idUser: Int
    var body: some View {
        Button(action: {
            FollowAndUnfollow(id: idUser)
            self.isFollow.toggle()
        }, label: {
            Text(isFollow ? "Unfollow" : "Follow")
                .foregroundColor(.white)
                .font(.system(size: 16))
                .padding(.all, 5)
                .frame(width: 78)
        })
        .background(isFollow ? Color.gray: Color("Bluesky"))
        .cornerRadius(5)
    }
}

//struct SearchUser_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchUser(text: "", nameTitle: "", isFollow: false)
//    }
//}
struct SearchUserViewView: View {
    @Binding var text: String
    @State private var isEditing = false
    var body: some View {
        HStack {
            TextField("Search ...", text: $text)
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal, 10)
                .onTapGesture {
                    self.isEditing = true
                }
            if isEditing {
                Button(action: {
                    self.isEditing = false
                    self.text = ""
 
                }) {
                    Text("Cancel")
                }
                .padding(.trailing, 10)
                .transition(.move(edge: .trailing))
                .animation(.default)
            }
        }
    }
}
