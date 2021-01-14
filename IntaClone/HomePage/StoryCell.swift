//
//  StoryCell.swift
//  Intaclone
//
//  Created by Viet Anh on 12/12/2020.
//

import SwiftUI

struct StoryCell: View {
    @State var show = false
    var body: some View {
        VStack(alignment: .leading, spacing: /*@START_MENU_TOKEN@*/nil/*@END_MENU_TOKEN@*/, content: {
            ScrollView(.horizontal, showsIndicators: false, content: {
                HStack{
                    ForEach(imageStory) { item in
                        Button(action: {
                            self.show.toggle()
                        }, label: {
                            Image(item.avatar)
                                .resizable()
                                .overlay(ImageOverlay(username: item.username), alignment: .bottom)
                                .frame(width: 90, height: 100, alignment: .center)
                                .cornerRadius(7)
                                .padding(2.5)
                                .background(LinearGradient(gradient: Gradient(colors: [Color("pink"),Color("purple")]), startPoint: .topLeading, endPoint: .bottomTrailing))
                                .cornerRadius(10)
                        })
                        .fullScreenCover(isPresented: $show, content: {
                            InStory.init(storyDetail: item)
                        })
                        
                    }
                }.padding(.horizontal)
            })
        })
    }
}

struct StoryCell_Previews: PreviewProvider {
    static var previews: some View {
        StoryCell()
    }
}
struct ImageOverlay: View {
    var username: String
    var body: some View {
        ZStack {
            Text(username)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
                .lineLimit(1)
                .padding(3)
                .foregroundColor(.white)
        }
    }
}
struct Story : Hashable, Identifiable {
    var id: Int
    var avatar: String
    var username: String
    var story: String
}
struct Loader : View {
    
    @State var width : CGFloat = 100
    @Binding var show : Bool
    var time = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    @State var secs : CGFloat = 0
    
    var body : some View{
        
        ZStack(alignment: .leading){
            
            Rectangle()
                .fill(Color.white.opacity(0.6))
                .frame(height: 3)
            
            Rectangle()
                .fill(Color.white)
                .frame(width: self.width, height: 3)
        }
        .onReceive(self.time) { (_) in
            
            self.secs += 0.1
            
            if self.secs <= 6{//6 seconds.....
                
                let screenWidth = UIScreen.main.bounds.width
                
                self.width = screenWidth * (self.secs / 6)
            }
            else{
                
                self.show = false
            }

        }
    }
}
struct InStory: View {
    @State var show = false
    @State var storyDetail: Story 
    @Environment(\.presentationMode) var presentationMode
    var body : some View {
        GeometryReader { reader in
            Text(storyDetail.avatar)
            ZStack{
                Color.black.edgesIgnoringSafeArea(.all)
                ZStack(alignment: .topLeading) {
                    VStack{
                        Image(storyDetail.story)
                        .resizable()
                        .frame(width: reader.size.width, height: reader.size.height)
                            .cornerRadius(10)
                    }
                    VStack(spacing: 15){
                        Loader(show: self.$show)
                        HStack(spacing: 15){
                            Image(storyDetail.avatar)
                            .resizable()
                            .frame(width: 55, height: 55)
                            .clipShape(Circle())

                            Text(storyDetail.username)
                                .foregroundColor(.white)
                                .font(.system(size: 21))
                                .bold()
                            Spacer()
                            Button(action: {
                                presentationMode.wrappedValue.dismiss()
                                show.toggle()
                            }, label: {
                                Image(systemName: "xmark")
                                    .resizable()
                                    .frame(width: 20, height: 20, alignment: .center)
                                    .foregroundColor(.white).opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
                            })
                        }
                        .padding(.leading)
                    }
                    .padding(.top)
                }
            }
            .transition(.move(edge: .trailing))
            .onTapGesture {
                presentationMode.wrappedValue.dismiss()
                show.toggle()
            }
        }
    }
}
var imageStory = [
    Story(id: 0, avatar: "avata", username: "avc", story: "post2"),
    Story(id: 1, avatar: "post2", username: "vietanh", story: "avata"),
    Story(id: 2, avatar: "post", username: "pnvanh", story: "post2"),
    Story(id: 3, avatar: "post3", username: "pnvanh", story: "post3"),
    Story(id: 4, avatar: "post", username: "pnvanh1", story: "post"),
    Story(id: 5, avatar: "avata", username: "deptrai", story: "post3")
]
