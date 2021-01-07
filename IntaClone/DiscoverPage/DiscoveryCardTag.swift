//
//  DiscoveryCardTag.swift
//  Intaclone
//
//  Created by Viet Anh on 13/12/2020.
//

import SwiftUI

struct DiscoveryCardTag: View {
    @State var dataCard: [CardDiscovery]
    let girdTag = [
        GridItem(.flexible(minimum: 160, maximum: 180)),
        GridItem(.flexible(minimum: 160, maximum: 180))
    ]
    var body: some View {
        LazyVGrid(columns: girdTag, spacing: 16){
            ForEach(dataCard){item in
                VStack{
                    Image("\(item.image)").resizable()
                }.cornerRadius(15)
                .frame(width: UIScreen.main.bounds.width / 2 - 20, height: 200, alignment:.center)
            }
        }.padding(.horizontal, 15)
    }
}

//struct DiscoveryCardTag_Previews: PreviewProvider {
//    static var previews: some View {
//        DiscoveryCardTag(isPrensented: .constant(false), dataForCard: .constant(<#[CardDiscovery]#>))
//    }
//}
