//
//  Item.swift
//  CollectIndex
//
//  Created by Violet Chaffee on 10/1/24.
//

import Foundation
import PhotosUI
import SwiftUI

struct Item : Identifiable, Hashable, Codable{
    let id: UUID
    let name: String
    let image: CodableImage
    let otherFields: [Other]
    
    static let example = Item(id: UUID(), name: "item 1", image: CodableImage(photo: UIImage(systemName: "square.fill")!), otherFields:[Other(id: UUID(), description: "description", descriptor: "descriptor")])
}
