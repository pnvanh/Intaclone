//
//  AddNewContent.swift
//  Intaclone
//
//  Created by Viet Anh on 19/12/2020.
//

import SwiftUI
import Photos

struct ContentView: View {
    var body: some View {
       
        AddView()
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView()
    }
}

struct AddView : View {
    
    @State private var selected : [SelectedImages] = []
    @State var show = true
    @Environment(\.presentationMode) var presentationMode
    @State private var caption:String = ""
    @State private var textHeight: CGFloat = 8
    var body: some View{
        ZStack{
            VStack(alignment: .leading){
                HStack(alignment: .center) {
                    Image("avata")
                        .resizable()
                        .clipShape(Circle())
                        .frame(width: 50, height: 50, alignment: .center)
                    VStack(alignment: .leading) {
                        Text("Phan Ngoc Viet Anh")
                            .font(.system(size: 18))
                            .lineLimit(1)
                        Text("@pnvanh")
                            .font(.system(size: 17))
                            .lineLimit(1)
                    }
                    Spacer()
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        Text("Post")
                            .foregroundColor(.white)
                            .padding(.vertical,10)
                            .frame(width: 60)
                    })
                    .background(Color("Bluesky"))
                    .clipShape(Capsule())
                }.padding(.horizontal)
                if !self.selected.isEmpty{
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        
                        HStack(spacing: 20){
                            
                            ForEach(self.selected,id: \.self){i in
        
                                Image(uiImage: i.image)
                                .resizable()
                                .frame(width: UIScreen.main.bounds.width - 40, height: 250)
                                    .cornerRadius(15)
                                
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                MultiLineText(txt: $caption, height: $textHeight)
                    .frame(height: 80)
                    .padding(.horizontal)
                    .background(RoundedRectangle(cornerRadius: 15).stroke(Color("Gray"), lineWidth: 1))
                    .padding(.horizontal)
                Spacer()
//                Button(action: {
//                    self.selected.removeAll()
//                    self.show.toggle()
//                }) {
//                    Text("Image Picker")
//                        .foregroundColor(.white)
//                        .padding(.vertical,10)
//                        .frame(width: UIScreen.main.bounds.width / 2)
//                }
//                .background(Color.red)
//                .clipShape(Capsule())
//                .padding(.top, 25)
            }
            .padding(.top, 25)
            if self.show{
                CustomPicker(selected: self.$selected, show: self.$show)
            }
        }
    }
}


struct CustomPicker : View {
    
    @Binding var selected : [SelectedImages]
    @State var grid : [[Images]] = []
    @Binding var show : Bool
    @State var disabled = false
    
    var body: some View{
        
        GeometryReader{_ in
            
            VStack(alignment: .center){
                if !self.grid.isEmpty{
                    
                    HStack{
                        
                        Text("Pick a Image")
                            .fontWeight(.bold)
                        
                        Spacer()
                    }
                    .padding(.leading)
                    .padding(.top)
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        
                        VStack(alignment: .center,spacing: 20){
                            
                            ForEach(self.grid,id: \.self){i in
                                
                                HStack{
                                    
                                    ForEach(i,id: \.self){j in
                                        
                                        CardAddNew(data: j, selected: self.$selected)
                                    }
                                }
                            }
                        }
                        .padding(.bottom)
                    }
                    
                    Button(action: {

                        self.show.toggle()
                    }) {
                        Text("Select")
                            .foregroundColor(.white)
                            .padding(.vertical,10)
                            .frame(width: UIScreen.main.bounds.width * (2/3))
                    }
                    .background(Color.red.opacity((self.selected.count != 0) ? 1 : 0.5))
                    .clipShape(Capsule())
                    .padding(.bottom)
                    .disabled((self.selected.count != 0) ? false : true)
                    
                }
                else{
                    
                    if self.disabled{
                        
                        Text("Enable Storage Access In Settings !!!")
                    }
                    if self.grid.count == 0{
                        
                        Indicator()
                    }
                }
            }
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * (2/3))
            .background(Color.white)
            .cornerRadius(12)
            .padding(.top, (UIScreen.main.bounds.width * (2/3)) / 2 )
        }
        .background(Color.black.opacity(0.1).edgesIgnoringSafeArea(.all)
        .onTapGesture {
        
            self.show.toggle()
            
        })
        .onAppear {
            
            PHPhotoLibrary.requestAuthorization { (status) in
                
                if status == .authorized{
                    
                    self.getAllImages()
                    self.disabled = false
                }
                else{
                    
                    print("not authorized")
                    self.disabled = true
                }
            }
        }
    }
    
    func getAllImages(){
        
        let opt = PHFetchOptions()
        opt.includeHiddenAssets = false
        
        let req = PHAsset.fetchAssets(with: .image, options: .none)
        
        DispatchQueue.global(qos: .background).async {

           let options = PHImageRequestOptions()
           options.isSynchronous = true
                
        // New Method For Generating Grid Without Refreshing....
            
          for i in stride(from: 0, to: req.count, by: 3){
                    
                var iteration : [Images] = []
                    
                for j in i..<i+3{
                    
                    if j < req.count{
                        
                        PHCachingImageManager.default().requestImage(for: req[j], targetSize: CGSize(width: 150, height: 150), contentMode: .default, options: options) { (image, _) in
                            
                            let data1 = Images(image: image!, selected: false, asset: req[j])
                            
                            iteration.append(data1)

                        }
                    }
                }
                    
                self.grid.append(iteration)
            }
            
        }
    }
}

struct CardAddNew : View {
    
    @State var data : Images
    @Binding var selected : [SelectedImages]
    
    var body: some View{
        
        ZStack{
            
            Image(uiImage: self.data.image)
            .resizable()
            
            if self.data.selected{
                
                ZStack{
                    
                    Color.black.opacity(0.5)
                    
                    Image(systemName: "checkmark")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.white)
                        .cornerRadius(15)
                }
            }
            
        }
        .frame(width: (UIScreen.main.bounds.width - 80) / 3, height: 90)
        .onTapGesture {
            
            
            if !self.data.selected{

                
                self.data.selected = true
                
                // Extracting Orginal Size of Image from Asset
                
                DispatchQueue.global(qos: .background).async {
                    
                    let options = PHImageRequestOptions()
                    options.isSynchronous = true
                    
                    // You can give your own Image size by replacing .init() to CGSize....
                    
                    PHCachingImageManager.default().requestImage(for: self.data.asset, targetSize: .init(), contentMode: .default, options: options) { (image, _) in

                        self.selected.append(SelectedImages(asset: self.data.asset, image: image!))
                    }
                }

            }
            else{
                
                for i in 0..<self.selected.count{
                    
                    if self.selected[i].asset == self.data.asset{
                        
                        self.selected.remove(at: i)
                        self.data.selected = false
                        return
                    }
                    
                }
            }
        }
        
    }
}

struct Indicator : UIViewRepresentable {
    
    func makeUIView(context: Context) -> UIActivityIndicatorView  {
        
        let view = UIActivityIndicatorView(style: .large)
        view.startAnimating()
        return view
    }
    
    func updateUIView(_ uiView:  UIActivityIndicatorView, context: Context) {
        
        
    }
}

struct Images: Hashable {
    
    var image : UIImage
    var selected : Bool
    var asset : PHAsset
}

struct SelectedImages: Hashable{
    
    var asset : PHAsset
    var image : UIImage
}

struct MyView: View {
    @State var caption:String = ""
    @State var textHeight: CGFloat = 80
    @State var selected : [SelectedImages] = []
    @State var show = true
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image("avata")
                    .resizable()
                    .clipShape(Circle())
                    .frame(width: 50, height: 50, alignment: .center)
                VStack(alignment: .leading) {
                    Text("Phan Ngoc Viet Anh")
                        .font(.system(size: 18))
                        .lineLimit(1)
                    Text("@pnvanh")
                        .font(.system(size: 17))
                        .lineLimit(1)
                }
            }.padding(.horizontal)
            ScrollView{
                MultiLineText(txt: $caption, height: $textHeight)
                    .frame(height: 80)
                    .padding(.horizontal)
                    .background(RoundedRectangle(cornerRadius: 15).stroke(Color("Gray"), lineWidth: 1))
                    .padding(.horizontal)
            }
            Spacer()
        }
    }
}
