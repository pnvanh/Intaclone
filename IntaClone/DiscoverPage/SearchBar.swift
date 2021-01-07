//
//  SearchBar.swift
//  Intaclone
//
//  Created by Viet Anh on 17/12/2020.
//

import SwiftUI

struct SearchBar: View {
    @Binding var textSearch:String
    @State private var isEditing = false
    @State private var isPresented = false
    @State private var viewSelected = false
    var body: some View {
        HStack {
            TextField("Search...", text: $textSearch)
                .padding(15)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .foregroundColor(.black)
                .cornerRadius(10)
                .overlay(
                    HStack{
                        Image("search")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 15)
                        
                        if isEditing{
                            Button(action: {
                                self.textSearch = ""
                            }, label: {
                                Image("cancel")
                                    .foregroundColor(.gray)
                                    .padding(.leading, 8)
                            })
                            

                        }
                    }).onTapGesture {
                        self.isEditing.toggle()
                        self.isPresented.toggle()
                    }
            if isEditing {
                Button(action: {
                    self.isEditing.toggle()
                    self.isPresented.toggle()
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }){
                    Text("Cancel")
                }
                .padding(.trailing, 20)
                .transition(.move(edge: .trailing))
                .animation(.default)
            }
            
        }.padding(.horizontal, 15)
    }
}
//
//struct SearchBar_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchBar()
//    }
//}
