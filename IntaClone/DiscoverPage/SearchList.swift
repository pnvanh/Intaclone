//
//  SearchList.swift
//  Intaclone
//
//  Created by Viet Anh on 14/12/2020.
//

import SwiftUI
import SDWebImageSwiftUI
struct SearchList: View {
    @ObservedObject var LoadFollowingOBS = LoadFollow()
    @State var text:String = ""
    @State var nameTitle:String
    @State var typeLoad:Bool
    @State var idLoad:Int
    var body: some View {
        ScrollView{
            VStack{
                SearchView(text: $text).padding(.bottom, 10)
                ForEach(typeLoad == true ? LoadFollowingOBS.dataUserFollowers : LoadFollowingOBS.dataUserFollowing.filter ({ text.isEmpty || "\($0)".contains(text.lowercased())})) { item in
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
            .onAppear{
                LoadFollowingOBS.LoadFollowing(id: self.idLoad)
                LoadFollowingOBS.LoadFollowers(id: self.idLoad)
                LoadFollowingOBS.dataUserFollowers.removeAll()
                LoadFollowingOBS.dataUserFollowing.removeAll()
            }
            .onDisappear{
                
            }
            
        }.padding(.top, 20)
        .navigationBarTitle(self.nameTitle, displayMode: .inline)
        .navigationTitle("")
    }
}

//struct SearchList_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchList()
//    }
//}
struct SearchData: Identifiable, Hashable {
    var id: Int
    var image: String
    var username: String
    var name: String
    var check: Bool
}
//var dataSearch = [
//    SearchData(id: 0 ,image: "avata", username: "userName", name: "VietAnh", check: true),
//    SearchData(id: 1 ,image: "avata", username: "vietanh", name: "daulun", check: false),
//    SearchData(id: 2 ,image: "avata", username: "deptrai", name: "ahihi", check: true),
//    SearchData(id: 3 ,image: "avata", username: "vietchi", name: "codelang", check: false),
//    SearchData(id: 4 ,image: "avata", username: "chiviet", name: "dmm", check: false)
//]

struct SearchView: View {
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
struct SearchDataFollow: Identifiable, Hashable, Codable {
    var id = UUID()
    var nameTitle:String
    var isFollow:Bool
    var typeLoad:Bool
    var idLoad:Int
}

