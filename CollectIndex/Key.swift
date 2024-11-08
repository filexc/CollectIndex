//
//  Key.swift
//  CollectIndex
//
//  Created by Violet Chaffee on 11/7/24.
//

import Foundation

struct Key: Identifiable, Codable, Hashable{
    let id: UUID
    var value: String
    
    init(_ value: String) {
        self.id = UUID()
        self.value = value
    }
}
