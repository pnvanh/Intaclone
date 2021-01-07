//
//  SearchList.swift
//  Intaclone
//
//  Created by Viet Anh on 14/12/2020.
//

import SwiftUI

struct SearchList: View {
    @Binding var text:String
    var body: some View {
        ScrollView{
            VStack{
                ForEach(dataSearch.filter({ text.isEmpty || "\($0)".contains(text.lowercased())})) { item in
                    HStack(alignment: .top){
                        Image("\(item.image)")
                            .resizable()
                            .frame(width: 50, height: 50, alignment: .center)
                            .clipShape(Circle())
                        VStack(alignment: .leading){
                            Text("\(item.username)")
                                .font(Font.system(size: 18))
                                .fontWeight(.bold)
                                .multilineTextAlignment(.leading)
                                .lineLimit(1)
                            Text("\(item.name)")
                                .font(Font.system(size: 13.5))
                                .multilineTextAlignment(.leading)
                                .lineLimit(1)
                        }
                        Spacer()
                    }.padding(.horizontal, 15)
                }
            }
        }
    }
}

//struct SearchList_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchList()
//    }
//}
struct SearchData: Identifiable {
    var id = UUID()
    var image: String
    var username: String
    var name: String
}
var dataSearch = [
    SearchData(image: "avata", username: "userName", name: "VietAnh"),
    SearchData(image: "avata", username: "vietanh", name: "daulun"),
    SearchData(image: "avata", username: "deptrai", name: "ahihi"),
    SearchData(image: "avata", username: "vietchi", name: "codelang"),
    SearchData(image: "avata", username: "chiviet", name: "dmm")
]
