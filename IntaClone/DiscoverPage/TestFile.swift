//
//  TestFile.swift
//  IntaClone
//
//  Created by Viet Anh on 23/01/2021.
//

import SwiftUI
import WaterfallGrid
import SDWebImageSwiftUI
struct TestFile: View {
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

struct TestFile_Previews: PreviewProvider {
    static var previews: some View {
        TestFile()
    }
}
var dataPlaces = [
    Card(id: 0, avata: "post", postImage: "https://static.toiimg.com/photo/72975551.cms", username: "post", place: "https://images.unsplash.com/photo-1541963463532-d68292c34b19?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxleHBsb3JlLWZlZWR8Mnx8fGVufDB8fHw%3D&w=1000&q=80", like: 1, caption: "fad", show: false, userLike: false),
    Card(id: 1, avata: "post", postImage: "https://images.unsplash.com/photo-1494548162494-384bba4ab999?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MXx8ZGF3bnxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&w=1000&q=80", username: "post", place: "post", like: 1, caption: "fad", show: false, userLike: false),
    Card(id: 2, avata: "post", postImage: "https://images.unsplash.com/photo-1494548162494-384bba4ab999?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MXx8ZGF3bnxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&w=1000&q=80", username: "post", place: "post", like: 1, caption: "fad", show: false, userLike: false),
    Card(id: 3, avata: "post", postImage: "https://images.unsplash.com/photo-1541963463532-d68292c34b19?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxleHBsb3JlLWZlZWR8Mnx8fGVufDB8fHw%3D&w=1000&q=80", username: "post", place: "post", like: 1, caption: "fad", show: false, userLike: false),
    Card(id: 4, avata: "post", postImage: "https://images.unsplash.com/photo-1494548162494-384bba4ab999?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MXx8ZGF3bnxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&w=1000&q=80", username: "post", place: "post", like: 1, caption: "fd", show: false, userLike: false),
    Card(id: 5, avata: "post", postImage: "https://images.unsplash.com/photo-1541963463532-d68292c34b19?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxleHBsb3JlLWZlZWR8Mnx8fGVufDB8fHw%3D&w=1000&q=80", username: "post", place: "post", like: 1, caption: "fad", show: false, userLike: false),
]

var dataPlants = [
    Card(id: 0, avata: "post", postImage: "https://static.toiimg.com/photo/72975551.cms", username: "post", place: "https://images.unsplash.com/photo-1541963463532-d68292c34b19?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxleHBsb3JlLWZlZWR8Mnx8fGVufDB8fHw%3D&w=1000&q=80", like: 1, caption: "fad", show: false, userLike: false),
    Card(id: 1, avata: "post", postImage: "https://images.unsplash.com/photo-1494548162494-384bba4ab999?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MXx8ZGF3bnxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&w=1000&q=80", username: "post", place: "post", like: 1, caption: "fad", show: false, userLike: false),
    Card(id: 2, avata: "post", postImage: "https://images.unsplash.com/photo-1494548162494-384bba4ab999?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MXx8ZGF3bnxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&w=1000&q=80", username: "post", place: "post", like: 1, caption: "fad", show: false, userLike: false),
    Card(id: 3, avata: "post", postImage: "https://images.unsplash.com/photo-1541963463532-d68292c34b19?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxleHBsb3JlLWZlZWR8Mnx8fGVufDB8fHw%3D&w=1000&q=80", username: "post", place: "post", like: 1, caption: "fad", show: false, userLike: false),
    Card(id: 4, avata: "post", postImage: "https://images.unsplash.com/photo-1494548162494-384bba4ab999?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MXx8ZGF3bnxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&w=1000&q=80", username: "post", place: "post", like: 1, caption: "fd", show: false, userLike: false),
    Card(id: 5, avata: "post", postImage: "https://images.unsplash.com/photo-1541963463532-d68292c34b19?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxleHBsb3JlLWZlZWR8Mnx8fGVufDB8fHw%3D&w=1000&q=80", username: "post", place: "post", like: 1, caption: "fad", show: false, userLike: false),
]

var dataHome = [
    Card(id: 0, avata: "post", postImage: "https://static.toiimg.com/photo/72975551.cms", username: "post", place: "https://images.unsplash.com/photo-1541963463532-d68292c34b19?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxleHBsb3JlLWZlZWR8Mnx8fGVufDB8fHw%3D&w=1000&q=80", like: 1, caption: "fad", show: false, userLike: false),
    Card(id: 1, avata: "post", postImage: "https://images.unsplash.com/photo-1494548162494-384bba4ab999?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MXx8ZGF3bnxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&w=1000&q=80", username: "post", place: "post", like: 1, caption: "fad", show: false, userLike: false),
    Card(id: 2, avata: "post", postImage: "https://images.unsplash.com/photo-1494548162494-384bba4ab999?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MXx8ZGF3bnxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&w=1000&q=80", username: "post", place: "post", like: 1, caption: "fad", show: false, userLike: false),
    Card(id: 3, avata: "post", postImage: "https://images.unsplash.com/photo-1541963463532-d68292c34b19?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxleHBsb3JlLWZlZWR8Mnx8fGVufDB8fHw%3D&w=1000&q=80", username: "post", place: "post", like: 1, caption: "fad", show: false, userLike: false),
    Card(id: 4, avata: "post", postImage: "https://images.unsplash.com/photo-1494548162494-384bba4ab999?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MXx8ZGF3bnxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&w=1000&q=80", username: "post", place: "post", like: 1, caption: "fd", show: false, userLike: false),
    Card(id: 5, avata: "post", postImage: "https://images.unsplash.com/photo-1541963463532-d68292c34b19?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxleHBsb3JlLWZlZWR8Mnx8fGVufDB8fHw%3D&w=1000&q=80", username: "post", place: "post", like: 1, caption: "fad", show: false, userLike: false),
]
var dataFood = [
    Card(id: 0, avata: "post", postImage: "https://static.toiimg.com/photo/72975551.cms", username: "post", place: "https://images.unsplash.com/photo-1541963463532-d68292c34b19?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxleHBsb3JlLWZlZWR8Mnx8fGVufDB8fHw%3D&w=1000&q=80", like: 1, caption: "fad", show: false, userLike: false),
    Card(id: 1, avata: "post", postImage: "https://images.unsplash.com/photo-1494548162494-384bba4ab999?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MXx8ZGF3bnxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&w=1000&q=80", username: "post", place: "post", like: 1, caption: "fad", show: false, userLike: false),
    Card(id: 2, avata: "post", postImage: "https://images.unsplash.com/photo-1494548162494-384bba4ab999?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MXx8ZGF3bnxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&w=1000&q=80", username: "post", place: "post", like: 1, caption: "fad", show: false, userLike: false),
    Card(id: 3, avata: "post", postImage: "https://images.unsplash.com/photo-1541963463532-d68292c34b19?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxleHBsb3JlLWZlZWR8Mnx8fGVufDB8fHw%3D&w=1000&q=80", username: "post", place: "post", like: 1, caption: "fad", show: false, userLike: false),
    Card(id: 4, avata: "post", postImage: "https://images.unsplash.com/photo-1494548162494-384bba4ab999?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MXx8ZGF3bnxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&w=1000&q=80", username: "post", place: "post", like: 1, caption: "fd", show: false, userLike: false),
    Card(id: 5, avata: "post", postImage: "https://images.unsplash.com/photo-1541963463532-d68292c34b19?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxleHBsb3JlLWZlZWR8Mnx8fGVufDB8fHw%3D&w=1000&q=80", username: "post", place: "post", like: 1, caption: "fad", show: false, userLike: false),
]
var dataFashion = [
    Card(id: 0, avata: "post", postImage: "https://static.toiimg.com/photo/72975551.cms", username: "post", place: "https://images.unsplash.com/photo-1541963463532-d68292c34b19?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxleHBsb3JlLWZlZWR8Mnx8fGVufDB8fHw%3D&w=1000&q=80", like: 1, caption: "fad", show: false, userLike: false),
    Card(id: 1, avata: "post", postImage: "https://images.unsplash.com/photo-1494548162494-384bba4ab999?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MXx8ZGF3bnxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&w=1000&q=80", username: "post", place: "post", like: 1, caption: "fad", show: false, userLike: false),
    Card(id: 2, avata: "post", postImage: "https://images.unsplash.com/photo-1494548162494-384bba4ab999?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MXx8ZGF3bnxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&w=1000&q=80", username: "post", place: "post", like: 1, caption: "fad", show: false, userLike: false),
    Card(id: 3, avata: "post", postImage: "https://images.unsplash.com/photo-1541963463532-d68292c34b19?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxleHBsb3JlLWZlZWR8Mnx8fGVufDB8fHw%3D&w=1000&q=80", username: "post", place: "post", like: 1, caption: "fad", show: false, userLike: false),
    Card(id: 4, avata: "post", postImage: "https://images.unsplash.com/photo-1494548162494-384bba4ab999?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MXx8ZGF3bnxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&w=1000&q=80", username: "post", place: "post", like: 1, caption: "fd", show: false, userLike: false),
    Card(id: 5, avata: "post", postImage: "https://images.unsplash.com/photo-1541963463532-d68292c34b19?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxleHBsb3JlLWZlZWR8Mnx8fGVufDB8fHw%3D&w=1000&q=80", username: "post", place: "post", like: 1, caption: "fad", show: false, userLike: false),
]
var dataCard11 = [
    Card(id: 0, avata: "post", postImage: "https://static.toiimg.com/photo/72975551.cms", username: "post", place: "https://images.unsplash.com/photo-1541963463532-d68292c34b19?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxleHBsb3JlLWZlZWR8Mnx8fGVufDB8fHw%3D&w=1000&q=80", like: 1, caption: "fad", show: false, userLike: false),
    Card(id: 1, avata: "post", postImage: "https://images.unsplash.com/photo-1494548162494-384bba4ab999?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MXx8ZGF3bnxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&w=1000&q=80", username: "post", place: "post", like: 1, caption: "fad", show: false, userLike: false),
    Card(id: 2, avata: "post", postImage: "https://images.unsplash.com/photo-1494548162494-384bba4ab999?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MXx8ZGF3bnxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&w=1000&q=80", username: "post", place: "post", like: 1, caption: "fad", show: false, userLike: false),
    Card(id: 3, avata: "post", postImage: "https://images.unsplash.com/photo-1541963463532-d68292c34b19?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxleHBsb3JlLWZlZWR8Mnx8fGVufDB8fHw%3D&w=1000&q=80", username: "post", place: "post", like: 1, caption: "fad", show: false, userLike: false),
    Card(id: 4, avata: "post", postImage: "https://images.unsplash.com/photo-1494548162494-384bba4ab999?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MXx8ZGF3bnxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&w=1000&q=80", username: "post", place: "post", like: 1, caption: "fd", show: false, userLike: false),
    Card(id: 5, avata: "post", postImage: "https://images.unsplash.com/photo-1541963463532-d68292c34b19?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxleHBsb3JlLWZlZWR8Mnx8fGVufDB8fHw%3D&w=1000&q=80", username: "post", place: "post", like: 1, caption: "fad", show: false, userLike: false),
]
