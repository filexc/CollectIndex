//
//  Collection.swift
//  CollectIndex
//
//  Created by Violet Chaffee on 10/1/24.
//

import Foundation
import PhotosUI

struct Collection: Identifiable, Hashable, Codable {
    let id: UUID
    let name: String
    var items: [Item]
    let coverImage: CodableImage
    let itemName: String
    let photoName: String
    let otherKey1: String
    let otherKey2: String
    let otherKey3: String
    let otherKey4: String
    let otherKey5: String

    mutating func add(item: Item) {
        items.append(item)
    }

    static let example = Collection(
        id: UUID(), name: "collection", items: [Item](),
        coverImage: CodableImage(photo: UIImage(systemName: "square.fill")!),
        itemName: "item name", photoName: "photo name", otherKey1: "1",
        otherKey2: "2", otherKey3: "", otherKey4: "", otherKey5: "")
}
