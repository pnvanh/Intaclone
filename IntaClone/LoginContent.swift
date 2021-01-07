//
//  LoginContent.swift
//  Intaclone
//
//  Created by Viet Anh on 19/12/2020.
//

import SwiftUI

struct LoginContent: View {
    var body: some View {
        VStack {
            Spacer()
            SignInView()
        }
    }
}

struct LoginContent_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
struct MainView: View {
    @State var isShowSign = false
    var body: some View {
        GeometryReader { reader in
            ZStack(alignment: .bottom) {
                Image("bg").resizable()
                VStack(spacing: 15) {
                    Button(action: {
                        self.isShowSign.toggle()
                    }, label: {
                        Text("SIGN IN")
                            .bold()
                            .font(.system(size: 22))
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .foregroundColor(Color.white)
                    })
                    .frame(width: reader.size.width - 50 , height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .background(Color("Gray"))
                    .cornerRadius(30)
                    Button(action: {
                        
                    }, label: {
                        Text("SIGN UP")
                            .bold()
                            .font(.system(size: 22))
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .foregroundColor(Color.white)
                    })
                    .frame(width: reader.size.width - 50 , height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .background(Color.black)
                    .cornerRadius(30)
                }.padding(.bottom , 15)
                if isShowSign {
                    VStack {
                        Spacer()
                        SignInView()
                    }
                }
            }
            .frame(width: reader.size.width, height: reader.size.height, alignment: .center)
            .onTapGesture {
                self.isShowSign.toggle()
            }
        }
    }
}

struct SignInView: View {
    @State var username: String = ""
    @State var password: String = ""
    var body: some View {
        VStack(spacing: 15) {
            Capsule()
                .fill(Color("Gray"))
                .frame(width: 100, height: 5, alignment: .center)
                .padding(.top, 5)
            Text("SIGN IN")
                .bold()
                .font(.system(size: 24))
                .foregroundColor(.white)
            HStack {
                Image(systemName: "person.fill")
                    .resizable()
                    .foregroundColor(Color.white)
                    .frame(width: 18, height: 18, alignment: .center).padding(.leading, 10)
                TextField("Email", text: $username).font(.system(size: 18))
            }.frame(width: UIScreen.main.bounds.width - 30,height: 45)
            .overlay(RoundedRectangle(cornerRadius: 25)
                        .stroke(Color.white, lineWidth: 1))
            HStack {
                Image(systemName: "lock.fill")
                    .resizable()
                    .foregroundColor(Color.white)
                    .frame(width: 15, height: 18, alignment: .center).padding(.leading, 10)
                TextField("Password", text: $username).font(.system(size: 18))
            }.frame(width: UIScreen.main.bounds.width - 30,height: 45)
            .overlay(RoundedRectangle(cornerRadius: 25)
                        .stroke(Color.white, lineWidth: 1))
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                Text("SIGN IN")
                    .bold()
                    .font(.system(size: 20))
                    .foregroundColor(.white)
            }).frame(width: UIScreen.main.bounds.width - 30, height: 45, alignment: .center)
            .background(Color("Gray"))
            .cornerRadius(25)
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                Text("Forget password?").font(.system(size: 13))
            })
            Text("OR").font(.system(size: 22)).foregroundColor(.white)
            Rectangle().fill(Color.white).frame(width: 100, height: 2, alignment: .center)
            HStack(spacing: 15) {
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Image("google")
                        .resizable()
                        .frame(width: 50, height: 50, alignment: .center)
                        .cornerRadius(25)
                })
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Image("facebook")
                        .resizable()
                        .frame(width: 50, height: 50, alignment: .center)
                        .cornerRadius(25)
                })
//                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
//                    Image("Apple")
//                        .resizable()
//                        .frame(width: 50, height: 50, alignment: .center)
//                        .cornerRadius(25)
//                })
            }
            HStack {
                Text("Don't have an acoount?").font(.system(size: 13)).foregroundColor(.white)
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Text("Sign up").font(.system(size: 13))
                })
            }.padding(.bottom, 10)
        }
        .frame(width: UIScreen.main.bounds.width)
        .background(Color("Dark"))
        
    }
}
