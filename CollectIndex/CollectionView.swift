//
//  CollectionView.swift
//  CollectIndex
//
//  Created by Violet Chaffee on 10/9/24.
//

import SwiftUI

struct CollectionView: View {
    @EnvironmentObject var collections: Collections
    let collection: Collection
    
    var body: some View {
        Text("Collection: " + collection.name)
            .font(.system(size:24))
    }
    
}

#Preview {
    CollectionView(collection: Collection.example)
        .environmentObject(Collections())
}
