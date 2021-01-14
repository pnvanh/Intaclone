//
//  SearchList.swift
//  Intaclone
//
//  Created by Viet Anh on 14/12/2020.
//

import SwiftUI

struct SearchList: View {
    @State var text:String
    @State var nameTitle:String
    var body: some View {
        ScrollView{
            VStack{
                SearchView(text: $text).padding(.bottom, 10)
                ForEach(dataSearch.filter({ text.isEmpty || "\($0)".contains(text.lowercased())})) { item in
                    HStack(alignment: .center){
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
                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                            Text("Following")
                                .foregroundColor(.white)
                                .font(.system(size: 16))
                                .padding(.all, 5)
                                .frame(width: 85)
                        })
                        .background(Color("Bluesky"))
                        .cornerRadius(10)
                    }.padding(.horizontal)
                }
            }
        }.padding(.top, 20)
        .navigationBarTitle(self.nameTitle, displayMode: .inline)
        .navigationTitle("")
    }
}

struct SearchList_Previews: PreviewProvider {
    static var previews: some View {
        SearchList(text: "", nameTitle: "")
    }
}
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
