//
//  EditProfileContent.swift
//  IntaClone
//
//  Created by Viet Anh on 14/01/2021.
//

import SwiftUI

struct EditProfileContent: View {
    @State var bio: String
    @State var username: String
    @State var fullName: String
    @State var day: String
    @State var month: String
    @State var year: String
    @State var image: Image? = nil
    @State var showPicker = false
    var body: some View {
        VStack() {
            if image == nil {
                Image("avata")
                    .resizable()
                    .clipShape(Circle())
                    .frame(width: 100, height: 100, alignment: .center)
                    .overlay(
                        Circle()
                    .trim(from: 0, to: 1)
                            .stroke(Color("Bluesky"),style: StrokeStyle(lineWidth: 3))
                    .frame(width: 110, height: 110))
            }
            else{
                image?
                    .resizable()
                    .clipShape(Circle())
                    .frame(width: 100, height: 100, alignment: .center)
                    .overlay(
                        Circle()
                    .trim(from: 0, to: 1)
                            .stroke(Color("Bluesky"),style: StrokeStyle(lineWidth: 3))
                    .frame(width: 110, height: 110))
            }
            Button(action: {
                self.showPicker.toggle()
            }, label: {
                Text("Change avatar").opacity(0.8)
            })
            .padding(.vertical, 15)
            VStack(spacing: 15) {
                VStack{
                    HStack(spacing: 15){
                        Image(systemName: "person.fill")
                        .foregroundColor(Color("Bluesky"))
                        TextField("Username", text: self.$username)
                    }.padding(.horizontal, 10)
                    
                }.padding(.vertical, 10)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color("Bluesky"), lineWidth: 2))
                .cornerRadius(10)
                .padding(.horizontal)
                VStack{
                    HStack(spacing: 15){
                        Image(systemName: "person.fill")
                        .foregroundColor(Color("Bluesky"))
                        TextField("Bio", text: self.$fullName)
                    }.padding(.horizontal, 10)
                    
                }.padding(.vertical, 10)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color("Bluesky"), lineWidth: 2))
                .cornerRadius(10)
                .padding(.horizontal)
                VStack{
                    HStack(spacing: 15){
                        Image(systemName: "pencil ")
                        .foregroundColor(Color("Bluesky"))
                        TextField("Location", text: self.$bio)
                    }.padding(.horizontal, 10)
                    
                }.padding(.vertical, 10)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color("Bluesky"), lineWidth: 2))
                .cornerRadius(10)
                .padding(.horizontal)
                HStack {
                    VStack{
                        HStack(spacing: 15){
                            Image(systemName: "calendar")
                            .foregroundColor(Color("Bluesky"))
                            TextField("Day", text: self.$day)
                        }.padding(.horizontal, 10)
                        
                    }.padding(.vertical, 10)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color("Bluesky"), lineWidth: 2))
                    .cornerRadius(10)
                    VStack{
                        HStack(spacing: 15){
                            Image(systemName: "calendar")
                            .foregroundColor(Color("Bluesky"))
                            TextField("Month", text: self.$month)
                        }.padding(.horizontal, 10)
                        
                    }.padding(.vertical, 10)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color("Bluesky"), lineWidth: 2))
                    .cornerRadius(10)
                    VStack{
                        HStack(spacing: 15){
                            Image(systemName: "calendar")
                            .foregroundColor(Color("Bluesky"))
                            TextField("Year", text: self.$year)
                        }.padding(.horizontal, 10)
                        
                    }.padding(.vertical, 10)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color("Bluesky"), lineWidth: 2))
                    .cornerRadius(10)
                }.padding(.horizontal)
                Button(action: {}, label: {
                    Text("Update profile")
                        .foregroundColor(.white)
                        .padding(.vertical, 5)
                        .frame(width: 150, height: 45, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                })
                .background(Color("Bluesky"))
                .clipShape(Capsule())
                .padding(.horizontal)
                Spacer()
            }
        }.padding(.top, UIScreen.main.bounds.height / (2*3))
        .sheet(isPresented: $showPicker, content: {
            ImagePicker.shared.view
        }).onReceive(ImagePicker.shared.$image){
            image in self.image = image
        }
    }
}

struct EditProfileContent_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileContent(bio: "", username: "", fullName: "", day: "", month: "", year: "")
    }
}
struct LineView: UIViewRepresentable {

    typealias UIViewType = UIView
    func makeUIView(context: UIViewRepresentableContext<LineView>) -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        return view
    }

    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<LineView>) {
    }
}
