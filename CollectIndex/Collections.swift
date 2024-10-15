//
//  Collections.swift
//  CollectIndex
//
//  Created by Violet Chaffee on 10/8/24.
//

import Foundation

class Collections : ObservableObject{
    @Published var collectionArray = [Collection]() // make a container class thats observable object to add to
    
    func add(collection: Collection){
        collectionArray.append(collection)
    }
}
