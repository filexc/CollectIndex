//
//  Item.swift
//  CollectIndex
//
//  Created by Violet Chaffee on 10/1/24.
//

import Foundation
import PhotosUI

struct Item : Identifiable, Hashable{
    let id: UUID
    let name: String
    let image: UIImage?
//    let otherFields: [Other]
    
    static let example = Item(id: UUID(), name: "item 1", image: UIImage(systemName: "square.fill"))
}
