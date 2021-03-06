//
//  TabBar.swift
//  Intaclone
//
//  Created by Viet Anh on 17/12/2020.
//

import SwiftUI
import GoogleSignIn
struct TabBar: View {
    @ObservedObject var GoogleLoginOBS = GoogleLogin()
    @State var current = "Home"
    @State var user = GIDSignIn.sharedInstance()?.currentUser
//    @State var checkLogin:Bool = false
    var check:Bool = false
    var body: some View {
//        VStack {
//            if user != nil {
//                ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom), content: {
//                    TabView(selection: $current) {
//                        PostCell()
//                            .tag("Home")
//                        DiscoveryContent()
//                            .tag("Discover")
//                        ActivityContent()
//                            .tag("Activity")
//                        ProfileContent()
//                            .tag("Profile")
//                    }
//                    .navigationBarTitle("", displayMode: .inline)
//                    .navigationTitle("")
//                    .navigationBarHidden(true)
//                    HStack(spacing: 0){
//                        TabButton(title: "Home", image: "home", selected: $current)
//                        Spacer(minLength: 0)
//                        TabButton(title: "Discover", image: "search", selected: $current)
//                        Spacer(minLength: 0)
//                        TabButton(title: "Activity", image: "favorite", selected: $current)
//                        Spacer(minLength: 0)
//                        TabButton(title: "Profile", image: "person", selected: $current)
//                        Spacer(minLength: 0)
//                                    }
//                    .padding(.vertical, 5)
//                    .padding(.horizontal)
//                    .background(Color("Color"))
//                })
//            }
//            else{
//
//                StartUpLogin()
//                    // for light status bar...
//                    .preferredColorScheme(.dark)
//
//            }
//        }
//        .onAppear {
////            self.tokenSV = UserDefaults.standard.string(forKey: "tokenSV")
//            GIDSignIn.sharedInstance()?.restorePreviousSignIn()
//            self.user = GIDSignIn.sharedInstance()?.currentUser
//            NotificationCenter.default.addObserver(forName: NSNotification.Name("SIGNIN"), object: nil, queue: .main) { (_) in
//                self.user = GIDSignIn.sharedInstance()?.currentUser
//            }
//        }
        VStack {
            ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom), content: {
                TabView(selection: $current) {
                    PostCell()
                        .tag("Home")
                    DiscoveryContent()
                        .tag("Discover")
                    ActivityContent()
                        .tag("Activity")
                    ProfileContent()
                        .tag("Profile")
                }
                .navigationBarTitle("", displayMode: .inline)
                .navigationTitle("")
                .navigationBarHidden(true)
                HStack(spacing: 0){
                    TabButton(title: "Home", image: "home", selected: $current)
                    Spacer(minLength: 0)
                    TabButton(title: "Discover", image: "search", selected: $current)
                    Spacer(minLength: 0)
                    TabButton(title: "Activity", image: "favorite", selected: $current)
                    Spacer(minLength: 0)
                    TabButton(title: "Profile", image: "person", selected: $current)
                    Spacer(minLength: 0)
                                }
                .padding(.vertical, 5)
                .padding(.horizontal)
                .background(Color("Color"))
            }).ignoresSafeArea(.keyboard, edges: .bottom)
        }
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
    }
}

struct TabButton: View {
    var title: String
    var image: String
    @Binding var selected: String
    var body: some View {
        Button(action: {
            withAnimation(.spring()){
                selected = title
            }
        }) {
            HStack(spacing: nil) {
                Image(image)
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(selected == title ? .white : .gray)
                    .frame(width: 25, height: 25)
                if selected == title {
                    Text(title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
            }
            .padding(.vertical, 8)
            .padding(.horizontal)
            .background(Color("Bluesky").opacity(title == "Home" && selected == "Home" ? 0.9 : 0 ))
            .background(Color("purple").opacity(title == "Discover" && selected == "Discover" ? 0.9 : 0 ))
            .background(Color("Like").opacity(title == "Activity" && selected == "Activity" ? 0.9 : 0 ))
            .background(Color("Organe").opacity(title == "Profile" && selected == "Profile" ? 0.9 : 0 ))
            .clipShape(Capsule())

        }
    }
}
