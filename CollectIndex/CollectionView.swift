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
        NavigationStack{
            //this may be bad -- force unwrapping
            ForEach(collections.collectionArray[collections.collectionArray.firstIndex(where: {$0.id == collection.id})!].items) {item in
                VStack{
                    NavigationLink {
                          ItemView(item: item)
                     } label: {
                         HStack{
                             Image(uiImage: UIImage(data: item.image.photo)!)
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
                .navigationDestination(for: Item.self){item in
                    ItemView(item: item)
                }
        }
        
        
    }
}

//#Preview {
//    CollectionView(collection: Collection.example)
//        .environmentObject(Collections())
//}
