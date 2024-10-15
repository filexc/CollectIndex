//
//  Collection.swift
//  CollectIndex
//
//  Created by Violet Chaffee on 10/1/24.
//

import Foundation
import PhotosUI

struct Collection : Identifiable, Hashable {
    let id: UUID
    let name: String
    var items: [Item]
    let coverImage: UIImage?
    let itemName: String
    let photoName: String
    
    static let example = Collection(id: UUID(), name: "a", items: [Item](), coverImage: UIImage(systemName: "square.fill"), itemName: "a", photoName: "a")
}
