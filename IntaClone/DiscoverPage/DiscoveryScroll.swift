//
//  DiscoveryScroll.swift
//  Intaclone
//
//  Created by Viet Anh on 13/12/2020.
//

import SwiftUI

var dataArray:Array<CardDiscovery> = [CardDiscovery(id: 0, image: "post")]

//struct DiscoverySubView: View {
//    var body: some View {
//        ScrollView(.vertical, showsIndicators: false, content: {
//            DiscoveryScroll()
//        })
//    }
//}

struct DiscoveryScroll: View {
    @State var tagSelected = 0
    let tags = [
        TagDiscovery(id: 0, name: "Travel", image: "airplane", color: "Bluesky"),
        TagDiscovery(id: 1, name: "Style", image: "camera", color: "purple"),
        TagDiscovery(id: 2, name: "Shopping", image: "shopping", color: "Yellow"),
        TagDiscovery(id: 3, name: "Style", image: "camera", color: "purple"),
        TagDiscovery(id: 4, name: "Shopping", image: "shopping", color: "Bluesky")
    ]
    var body: some View {
        ScrollView(.vertical,showsIndicators: false){
            VStack{
                ScrollView(.horizontal,showsIndicators: false){
                    HStack{
                        ForEach(tags, id: \.self) { tag in
                            VStack{
                                Image("\(tag.image)")
                                    .resizable()
                                    .frame(width: 50, height: 50, alignment: .center).colorInvert()
                                Text("\(tag.name)")
                                    .fontWeight(.bold).font(.system(size: 18))
                                    .foregroundColor(.white)
                                    .lineLimit(1)
                                    .fixedSize(horizontal: false, vertical: true)
                            }.frame(width: 90, height: 100, alignment: .center)
                            .background(Color("\(tag.color)"))
                            .cornerRadius(15)
                            .opacity(tagSelected == tag.id ? 100 : 0.8)
                            .onTapGesture(count: 1, perform: {
                                tagSelected = tag.id
                            })
                        }
                    }.padding(.horizontal)
                }
            }
            TabView(selection: self.$tagSelected){
                DiscoveryCardTag(dataCard: dataCard).tag(0)
                DiscoveryCardTag(dataCard: dataCard1).tag(1)
                DiscoveryCardTag(dataCard: dataCard2).tag(2)
            }.tabViewStyle(PageTabViewStyle(indexDisplayMode: .never)).disabled(true)
        }
    }

}
//TabView(selection: self.$tagSelected){
//    DiscoveryCardTag(dataCard: dataCard).tag(0)
//}.tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
//struct DiscoveryScroll_Previews: PreviewProvider {
//    static var previews: some View {
//        DiscoverySubView()
//    }
//}
var dataCard = [
    CardDiscovery(id: 0, image: "post"),
    CardDiscovery(id: 1, image: "post3"),
    CardDiscovery(id: 2, image: "post2"),
    CardDiscovery(id: 3, image: "bg"),
    CardDiscovery(id: 4, image: "test")
]
var dataCard1 = [
    CardDiscovery(id: 0, image: "post"),
    CardDiscovery(id: 1, image: "post3"),
    CardDiscovery(id: 2, image: "post2")
]
var dataCard2 = [
    CardDiscovery(id: 0, image: "post2"),
    CardDiscovery(id: 1, image: "post3"),
    CardDiscovery(id: 2, image: "post"),
    CardDiscovery(id: 3, image: "bg"),
    CardDiscovery(id: 4, image: "avata")
]
