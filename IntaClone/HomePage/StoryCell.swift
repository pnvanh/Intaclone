//
//  StoryCell.swift
//  Intaclone
//
//  Created by Viet Anh on 12/12/2020.
//

import SwiftUI

struct StoryCell: View {
    @State var imageStory = [
        Story(id: 0, avata: "avata", username:  "avata"),
        Story(id: 1, avata: "post2", username:  "vietanh"),
        Story(id: 2, avata: "post", username:  "pnvanh"),
        Story(id: 3, avata: "post3", username:  "pnvanh"),
        Story(id: 4, avata: "post", username:  "pnvanh1"),
        Story(id: 5, avata: "avata", username:  "deptrai")
    ]
    var body: some View {
        VStack(alignment: .leading, spacing: /*@START_MENU_TOKEN@*/nil/*@END_MENU_TOKEN@*/, content: {
            ScrollView(.horizontal, showsIndicators: false, content: {
                HStack{
                    ForEach(imageStory, id: \.self){item in
                        Image(item.avata)
                            .resizable()
                            .overlay(ImageOverlay(username: item.username), alignment: .bottom)
                            .frame(width: 90, height: 100, alignment: .center)
                            .cornerRadius(7)
                            .padding(2.5)
                            .background(LinearGradient(gradient: Gradient(colors: [Color("pink"),Color("purple")]), startPoint: .topLeading, endPoint: .bottomTrailing))
                            .cornerRadius(10)
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
struct Story : Hashable {
    var id: Int
    var avata: String
    var username: String
}
