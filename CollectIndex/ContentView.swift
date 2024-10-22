//
//  ContentView.swift
//  CollectIndex
//
//  Created by Violet Chaffee on 9/30/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var collections: Collections
    @State private var showingDetail = false
    var body: some View {
        NavigationStack{
            ScrollView{
                ForEach(collections.collectionArray) {collection in
                    VStack{
                        NavigationLink {
                              CollectionView(collection: collection)
                         } label: {
                             HStack{
                                 Image(uiImage: UIImage(data: collection.coverImage.photo)!)
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
                    NewCollectionView()
                }
                Spacer()
                    .navigationBarBackButtonHidden(true)
            }
            .navigationDestination(for: Collection.self){ collection in
                CollectionView(collection: collection)
            }
        }
    }

}

#Preview {
    ContentView()
        .environmentObject(Collections())
}
