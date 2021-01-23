//
//  MainContentView.swift
//  IntaClone
//
//  Created by Viet Anh on 16/01/2021.
//

import SwiftUI
import GoogleSignIn
struct MainContentView: View {
    @State var user = GIDSignIn.sharedInstance()?.currentUser
    var body: some View {
        VStack {
            if user != nil {
                TabBar()
            }
            else{
                
                StartUpLogin()
                    // for light status bar...
                    .preferredColorScheme(.dark)

            }
        }
        .onAppear {
//            self.tokenSV = UserDefaults.standard.string(forKey: "tokenSV")
            GIDSignIn.sharedInstance()?.restorePreviousSignIn()
            self.user = GIDSignIn.sharedInstance()?.currentUser
            NotificationCenter.default.addObserver(forName: NSNotification.Name("SIGNIN"), object: nil, queue: .main) { (_) in
                self.user = GIDSignIn.sharedInstance()?.currentUser
                
            }
        }
    }
}

