//
//  CollectionView.swift
//  CollectIndex
//
//  Created by Violet Chaffee on 10/9/24.
//

import SwiftUI

struct CollectionView: View {
    @EnvironmentObject var collections: Collections
    @State var collection: Collection
    @State private var showingDetail = false
    
    
    var body: some View {
        //this may be bad -- force unwrapping
        ForEach(collections.collectionArray[collections.collectionArray.firstIndex(where: {$0.id == collection.id})!].items) {item in
            VStack{
                NavigationLink(value: item){
                    ItemRow(item: item)
                }
            }
            .frame(width: 320, height: 80, alignment: .topLeading)
            .foregroundColor(.black)
        }
        Button{
            showingDetail = true
        } label: {
            Image(systemName: "plus.square")
                .font(.system(size: 60))
                .frame(width: 300, height: 60, alignment: .topLeading)
        }
        .sheet(isPresented: $showingDetail){
            NewItemView(collection: collection)
        }
        Spacer()
            .navigationTitle("Collection: " + collection.name)
    }
    
}

#Preview {
    CollectionView(collection: Collection.example)
        .environmentObject(Collections())
}
