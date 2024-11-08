//
//  Collection.swift
//  CollectIndex
//
//  Created by Violet Chaffee on 10/1/24.
//

import Foundation
import PhotosUI

struct Collection : Identifiable, Hashable, Codable {
    let id: UUID
    let name: String
    var items: [Item]
    let coverImage: CodableImage
    let itemName: String
    let photoName: String
    let otherKeys: [Key]
    let numKeys: Int
    
    mutating func add(item: Item){
        items.append(item)
    }
    
    static let example = Collection(id: UUID(), name: "collection", items: [Item](), coverImage: CodableImage(photo: UIImage(systemName: "square.fill")!), itemName: "item name", photoName: "photo name", otherKeys: [Key("descriptor 1")], numKeys:1)
}
