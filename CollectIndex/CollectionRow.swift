//
//  CollectionRow.swift
//  CollectIndex
//
//  Created by Violet Chaffee on 10/9/24.
//

import SwiftUI

struct CollectionRow: View {
    let collection: Collection
    
    var body: some View {
        HStack{
            Image(uiImage: collection.coverImage!)
                .resizable()
                .frame(width: 60, height: 60)
                .clipped()
            Text(collection.name)
                .font(.system(size: 24))
            Spacer()
        }
        .padding()
    }
}

#Preview{
    CollectionRow(collection: Collection.example)
}
