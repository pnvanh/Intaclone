//
//  DataDiscovery.swift
//  Intaclone
//
//  Created by Viet Anh on 13/12/2020.
//

import SwiftUI

struct TagDiscovery: Hashable {
    var id: Int
    var name: String
    var image: String
    var color: String
}
struct CardDiscovery: Identifiable, Hashable, Codable {
    var id: Int
    var image: String
}
