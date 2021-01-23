//
//  DiscoveryContent.swift
//  Intaclone
//
//  Created by Viet Anh on 13/12/2020.
//

import SwiftUI

struct DiscoveryContent: View {
    @State private var textSearch = ""
    @State private var isEditing = false
    @State private var isPresented = false
    @State private var viewSelected = false
    @State private var showingModel = false
    var body: some View {
        NavigationView {
            VStack {
                ZStack (alignment: .leading) {
                    Rectangle().fill(Color("Color")).frame(width: UIScreen.main.bounds.width, height: 40, alignment: .center)
                    HStack {
                        Text("Discover").font(Font.custom("Lobster-Regular", size: 28)).padding(.leading)
                        Spacer()
                        Button(action: {
                            self.showingModel.toggle()
                        }, label: {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.white)
                                .frame(width: 26, height: 26, alignment: .center)
                                .padding(.all,5)
                        })
                        .background(Color("Bluesky"))
                        .clipShape(Capsule())
                        .padding(.horizontal)
                        .sheet(isPresented: $showingModel, content: {
                            SearchUser.init(nameTitle: "", typeLoad: true, idLoad: 36)
                        })
                    }
                }
                ScrollView(.vertical, showsIndicators: false, content: {
                    VStack{
                        DiscoveryScroll()
                    }
                })
            }
            .navigationBarHidden(true)
        }

        
    }
}

struct DiscoveryContent_Previews: PreviewProvider {
    static var previews: some View {
        DiscoveryContent()
    }
}

