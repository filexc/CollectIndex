//
//  Item.swift
//  CollectIndex
//
//  Created by Violet Chaffee on 10/1/24.
//

import Foundation
import PhotosUI

struct Item : Hashable{
    let name: String
    let image: UIImage?
    let otherFields: [Other]
}
