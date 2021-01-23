//
//  AddNewContent.swift
//  Intaclone
//
//  Created by Viet Anh on 19/12/2020.
//

import SwiftUI
import Photos
import SDWebImageSwiftUI
import FirebaseMLVisionObjectDetection
import SwiftyJSON
struct AddView : View {
    
    @State private var selected : [SelectedImages] = []
    @State var show = true
    @Environment(\.presentationMode) var presentationMode
    @State private var caption:String = ""
    @State private var textHeight: CGFloat = 8
    @Binding var showingModal:Bool
    @State var userAvatar:String
    @State var username:String
    @State var fullName:String
    var body: some View{

        ZStack{
            VStack(alignment: .leading){
                HStack(alignment: .center) {
                    WebImage(url: URL(string: userAvatar))
                        .resizable()
                        .clipShape(Circle())
                        .frame(width: 50, height: 50, alignment: .center)
                    VStack(alignment: .leading) {
                        Text("\(fullName)")
                            .font(.system(size: 18))
                            .lineLimit(1)
                        Text("@\(username)")
                            .font(.system(size: 17))
                            .lineLimit(1)
                    }
                    Spacer()
                    Button(action: {
                        let b64:String = convertImageToBase64( image: selected[0].image)!
                        getLable(imageData: selected[0].image)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) { // Change `2.0` to the desired number of seconds.
                           // Code you want to be delayed
                            getLable(imageData: selected[0].image)
                            detectionImage.forEach({item in
                                detectionImageLable.append((item.tagsname))
                            })
                            
                            NewPost(image: "data:image/jpeg;base64,\(b64)", caption: caption, hashtag: detectionImage[0].tagsname)
                            self.showingModal = false
                        }
                        
                    }, label: {
                        Text("Post")
                            .foregroundColor(.white)
                            .padding(.vertical,10)
                            .frame(width: 60)
                    })
                    .disabled(caption.isEmpty)
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
            }
            .padding(.top, 25)
            if self.show{
                CustomPicker(selected: self.$selected, show: self.$show)
            }
        }
        .onAppear{
//            DispatchQueue.main.async {
//                //Do UI Code here.
//                //Call Google maps methods.
////                getLable(imageData: selected[0].image)
//                print("Lable: \(detectionImage)")
//            }
            
        }
        .onDisappear{
           
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
                        
                        VStack(alignment: .center,spacing: 5){
                            
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
func convertImageToBase64(image: UIImage) -> String? {
    let imageData = image.jpegData(compressionQuality: 0.1)
    return imageData?.base64EncodedString(options:
                                            .endLineWithCarriageReturn)
}


func getLable(imageData: UIImage) {
    let categories = ["Unknown", "Home", "Fashion", "Food", "Places", "Plants"]
    // Multiple object detection in static images
    let options = VisionObjectDetectorOptions()
    options.detectorMode = .singleImage
    options.shouldEnableMultipleObjects = true
    options.shouldEnableClassification = true  // Optional

    let objectDetector = Vision.vision().objectDetector(options: options)
    let image = VisionImage(image: imageData)

    objectDetector.process(image) { detectedObjects, error in
      guard error == nil else {
        // Error.
        return
      }
      guard let detectedObjects = detectedObjects, !detectedObjects.isEmpty else {
        print("adasdasdasda")
        // No objects detected.
        return
      }
      // Success. Get object info here.
      // ...
        for obj in detectedObjects {

            let category = obj.classificationCategory.rawValue
          
           
//            print("\(categories[category])")
//            detectionImageLable.append(categories[category])
            detectionImage.append(LableName(tagsname: categories[category]))
        }

    }
}
//var vision = Vision.vision()
struct LableName: Codable {
    var tagsname:String
}
var detectionImage = [LableName]()
var detectionImageLable:Array<String> = []

var listTags:[AnyObject] = []
