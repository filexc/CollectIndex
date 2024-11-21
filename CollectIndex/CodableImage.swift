//
//  CodableImage.swift
//  CollectIndex
//
//  Created by Violet Chaffee on 10/22/24.
//

import PhotosUI
import SwiftUI

public struct CodableImage: Codable, Hashable {

    public let photo: Data

    public init(photo: UIImage) {
        self.photo = photo.pngData()!
    }
}

//use this to call: UIImage(data: instanceOfSomeImage.photo)!
