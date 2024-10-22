//
//  CodableImage.swift
//  CollectIndex
//
//  Created by Violet Chaffee on 10/22/24.
//


import SwiftUI
import PhotosUI

public struct CodableImage: Codable, Hashable {

    public let photo: Data
    
    public init(photo: UIImage) {
        self.photo = photo.pngData()!
    }
}

//UIImage(data: instanceOfSomeImage.photo)!
