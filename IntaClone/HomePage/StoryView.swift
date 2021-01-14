//
//  StoryView.swift
//  Intaclone
//
//  Created by Viet Anh on 21/12/2020.
//
//
//import SwiftUI
//
//struct StoryView: View {
//    var body: some View {
//        StoryCellView()
//    }
//}
//
//struct StoryView_Previews: PreviewProvider {
//    static var previews: some View {
//        StoryCellView()
//    }
//}
//struct StoryCellView : View {
//    
//    @State var show = false
//    @State var current : DataStory!
//    
//    @State var data = [
//
//        DataStory(id: 0, name: "pnvanh", url: "post", seen: false, proPic: "post", loading: false),
//        DataStory(id: 1, name: "pnvchi", url: "post2", seen: false, proPic: "post2", loading: false),
//        DataStory(id: 2, name: "pnvem", url: "post3", seen: false, proPic: "post3", loading: false),
//        DataStory(id: 3, name: "pmvmma", url: "bg", seen: false, proPic: "test", loading: false),
//        DataStory(id: 4, name: "pmvanh", url: "test", seen: false, proPic: "bg", loading: false)
//    ]
//    
//    var body: some View{
//        
//        ZStack{
//            
//            Color.black.opacity(0.05).edgesIgnoringSafeArea(.all)
//            
//            ZStack{
//                
//                VStack{
//                    
//                    ScrollView(.horizontal, showsIndicators: false) {
//                        
//                        HStack(spacing: 22){
//                            
//                            Button(action: {
//                                
//                            }) {
//                                
//                                VStack(spacing: 8){
//                                    
//                                    ZStack(alignment: .bottomTrailing){
//                                        
//                                        Image("avata")
//                                        .renderingMode(.original)
//                                        .resizable()
//                                        .frame(width: 65, height: 65)
//                                        .clipShape(Circle())
//                                        
//                                        
//                                        Image(systemName: "plus")
//                                        .resizable()
//                                        .frame(width: 12, height: 12)
//                                        .padding(8)
//                                        .background(Color.white)
//                                        .clipShape(Circle())
//                                        .offset(x: 6)
//                                    }
//                                    
//                                    Text("You")
//                                        .foregroundColor(.black)
//                                }
//                            }
//                            
//                            ForEach(0..<self.data.count){i in
//                                
//                                VStack(spacing: 8){
//                                    
//                                    ZStack{
//                                        
//                                        Image(self.data[i].proPic)
//                                        .resizable()
//                                        .frame(width: 65, height: 65)
//                                        .clipShape(Circle())
//                                        
//                                        if !self.data[i].seen{
//                                            
//                                            Circle()
//                                            .trim(from: 0, to: 1)
//                                                .stroke(AngularGradient(gradient: .init(colors: [.red,.orange,.red]), center: .center), style: StrokeStyle(lineWidth: 4, dash: [self.data[i].loading ? 7 : 0]))
//                                            .frame(width: 74, height: 74)
//                                            .rotationEffect(.init(degrees: self.data[i].loading ? 360 : 0))
//                                        }
//
//                                    }
//                                    
//                                    Text(self.data[i].name)
//                                        .foregroundColor(.black)
//                                        .lineLimit(1)
//                                }
//                                .frame(width: 75)
//                                .onTapGesture {
//                                    withAnimation(Animation.default.speed(0.35).repeatForever(autoreverses: false)){
//                                        
//                                        self.data[i].loading.toggle()
//                                        
//                                        DispatchQueue.main.asyncAfter(deadline: .now() + (self.data[i].seen ? 0 : 1.2)) {
//                                            
//                                            self.current = self.data[i]
//                                            
//                                            withAnimation(.default){
//                                               self.show.toggle()
//                                            }
//                                            self.data[i].loading = false
//                                            self.data[i].seen = true
//                                        }
//                                    }
//                                }
//                                .fullScreenCover(isPresented: $show, content: {
//                                    InSideStoy()
//                                })
//                            }
//                        }
//                        .padding(.horizontal)
//                        .padding(.top)
//                    }
//                    Spacer()
//                }
//                
//                if self.show{
//
//                    ZStack{
//
//                        Color.black.edgesIgnoringSafeArea(.all)
//
//                        ZStack(alignment: .topLeading) {
//
//                            GeometryReader{_ in
//
//                                VStack{
//
//                                    Image(self.current.url)
//                                    .resizable()
//                                    .aspectRatio(contentMode: .fit)
//                                }
//                            }
//
//                            VStack(spacing: 15){
//
//                                Loader(show: self.$show)
//
//                                HStack(spacing: 15){
//
//                                    Image(self.current.proPic)
//                                    .resizable()
//                                    .frame(width: 55, height: 55)
//                                    .clipShape(Circle())
//
//                                    Text(self.current.name)
//                                        .foregroundColor(.white)
//
//                                    Spacer()
//
//                                }
//                                .padding(.leading)
//                            }
//                            .padding(.top)
//                        }
//                    }
//                    .transition(.move(edge: .trailing))
//                    .onTapGesture {
//
//                        self.show.toggle()
//                    }
//                }
//            }
//        }
//        .navigationBarTitle(self.show ? "" : "Instagram",displayMode: .inline)
//        .navigationBarHidden(self.show ? true : false)
//    }
//}
//
//struct Loader : View {
//    
//    @State var width : CGFloat = 100
//    @Binding var show : Bool
//    var time = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
//    @State var secs : CGFloat = 0
//    
//    var body : some View{
//        
//        ZStack(alignment: .leading){
//            
//            Rectangle()
//                .fill(Color.white.opacity(0.6))
//                .frame(height: 3)
//            
//            Rectangle()
//                .fill(Color.white)
//                .frame(width: self.width, height: 3)
//        }
//        .onReceive(self.time) { (_) in
//            
//            self.secs += 0.1
//            
//            if self.secs <= 6{//6 seconds.....
//                
//                let screenWidth = UIScreen.main.bounds.width
//                
//                self.width = screenWidth * (self.secs / 6)
//            }
//            else{
//                
//                self.show = false
//            }
//
//        }
//    }
//}
//
//struct DataStory : Identifiable {
//    
//    var id : Int
//    var name : String
//    var url : String
//    var seen : Bool
//    var proPic : String
//    var loading : Bool
//}
//
//
