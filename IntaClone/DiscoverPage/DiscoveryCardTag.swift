//
//  DiscoveryCardTag.swift
//  Intaclone
//
//  Created by Viet Anh on 13/12/2020.
//

import SwiftUI
import SDWebImageSwiftUI
import WaterfallGrid
struct DiscoveryCardTag: View {
//    @State var dataCard: [Card]
    let girdTag = [
        GridItem(.flexible(minimum: 160, maximum: 180)),
        GridItem(.flexible(minimum: 160, maximum: 180))
    ]
    var body: some View {
        ScrollView{
            VStack {
                WaterfallGrid(dataCard11, id: \.self){ item in
//                        WebImage(url: URL(string: item.postImage))
                    WebImage(url: URL(string: item.postImage))
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(15)
                }
                .gridStyle(columns: 2)
                .padding(.horizontal)

            }
        }

    }
}




struct DiscoveryCardTagHome: View {
//    @State var dataCard: [Card]
    var body: some View {
        ScrollView{
            VStack {
                WaterfallGrid(dataCard11, id: \.self){ item in
//                        WebImage(url: URL(string: item.postImage))
                    WebImage(url: URL(string: item.postImage))
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(15)
                }
                .gridStyle(columns: 2)
                .padding(.horizontal)

            }
        }

    }
}
