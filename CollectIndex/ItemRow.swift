//
//  ItemRow.swift
//  CollectIndex
//
//  Created by Violet Chaffee on 10/15/24.
//

import SwiftUI

struct ItemRow: View {
    let item: Item
    
    var body: some View {
        HStack{
            Image(uiImage: item.image!)
                .resizable()
                .frame(width: 60, height: 60)
                .clipped()
            Text(item.name)
                .font(.system(size: 24))
            Spacer()
        }
        .padding()
    }
}

#Preview {
    ItemRow(item: Item.example)
}


//import SwiftUI
//
//struct CollectionRow: View {
//    let collection: Collection
//    
//    var body: some View {
//        HStack{
//            Image(uiImage: collection.coverImage!)
//                .resizable()
//                .frame(width: 60, height: 60)
//                .clipped()
//            Text(collection.name)
//                .font(.system(size: 24))
//            Spacer()
//        }
//        .padding()
//    }
//}
//
//#Preview{
//    CollectionRow(collection: Collection.example)
//}
