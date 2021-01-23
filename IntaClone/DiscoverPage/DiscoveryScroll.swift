//
//  DiscoveryScroll.swift
//  Intaclone
//
//  Created by Viet Anh on 13/12/2020.
//

import SwiftUI
import WaterfallGrid
import SDWebImageSwiftUI
struct DiscoveryScroll: View {
    @State var tagSelected = 0
    @ObservedObject var TagDiscoverOBS = LoadTagDiscover()
    let tags = [
        TagDiscovery(id: 0, name: "Popular", image: "favorite", color: "Like"),
        TagDiscovery(id: 1, name: "Places", image: "airplane", color: "Bluesky"),
        TagDiscovery(id: 2, name: "Fashion", image: "shopping", color: "purple"),
        TagDiscovery(id: 3, name: "Food", image: "food", color: "Yellow"),
        TagDiscovery(id: 4, name: "Plants", image: "spa", color: "green"),
        TagDiscovery(id: 5, name: "Home", image: "home", color: "Color1")
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
            if(tagSelected == 0) {
                VStack {
                    WaterfallGrid(TagDiscoverOBS.loadPopular, id: \.self){ item in
                        NavigationLink(destination: DetailPost(dataDetail: item)) {
                            WebImage(url: URL(string: item.postImage))
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .cornerRadius(15)
                        }
                    }
                    .gridStyle(columns: 2)
                    .padding(.horizontal)
                }
                .onAppear{
                    TagDiscoverOBS.loadPopular(name: "Popular")
                    TagDiscoverOBS.loadPopular.removeAll()
                }
            }
            else if (tagSelected == 1) {
                VStack {
                    WaterfallGrid(dataPlaces, id: \.self){ item in
                        NavigationLink(destination: DetailPost(dataDetail: item)) {
                            WebImage(url: URL(string: item.postImage))
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .cornerRadius(15)
                        }
                    }
                    .gridStyle(columns: 2)
                    .padding(.horizontal)
                }
            }
            else if (tagSelected == 2) {
                VStack {
                    WaterfallGrid(dataFashion, id: \.self){ item in
                        NavigationLink(destination: DetailPost(dataDetail: item)) {
                            WebImage(url: URL(string: item.postImage))
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .cornerRadius(15)
                        }
                    }
                    .gridStyle(columns: 2)
                    .padding(.horizontal)
                }
            }

            else if (tagSelected == 3) {
                VStack {
                    WaterfallGrid(dataFood, id: \.self){ item in
                        NavigationLink(destination: DetailPost(dataDetail: item)) {
                            WebImage(url: URL(string: item.postImage))
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .cornerRadius(15)
                        }
                    }
                    .gridStyle(columns: 2)
                    .padding(.horizontal)
                }
            }

            else if (tagSelected == 4) {
                VStack {
                    WaterfallGrid(dataPlants, id: \.self){ item in
                        NavigationLink(destination: DetailPost(dataDetail: item)) {
                            WebImage(url: URL(string: item.postImage))
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .cornerRadius(15)
                        }
                    }
                    .gridStyle(columns: 2)
                    .padding(.horizontal)
                }
            }
            else if (tagSelected == 5) {
                VStack {
                    WaterfallGrid(dataHome, id: \.self){ item in
                        NavigationLink(destination: DetailPost(dataDetail: item)) {
                            WebImage(url: URL(string: item.postImage))
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .cornerRadius(15)
                        }
                    }
                    .gridStyle(columns: 2)
                    .padding(.horizontal)
                }
            }


            

            
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
