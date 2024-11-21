//
//  CollectionView.swift
//  CollectIndex
//
//  Created by Violet Chaffee on 10/9/24.
//

import SwiftUI

struct CollectionView: View {
    @EnvironmentObject var collections: Collections
    @EnvironmentObject var settings: SettingsManager
    @State var collection: Collection
    @State private var showingDetail = false
    @State private var showingDeleteAlert = false
    @State private var itemToDelete: Item?

    var body: some View {
        NavigationStack {
            //this may be bad -- force unwrapping
            ForEach(
                collections.collectionArray[
                    collections.collectionArray.firstIndex(where: {
                        $0.id == collection.id
                    })!
                ].items
            ) { item in
                VStack {
                    NavigationLink {
                        ItemView(item: item)
                    } label: {
                        HStack {
                            Image(uiImage: UIImage(data: item.image.photo)!)
                                .resizable()
                                .frame(width: 60, height: 60)
                                .clipShape(
                                    RoundedRectangle(
                                        cornerSize: CGSize(
                                            width: 10, height: 10)))
                            Text(item.name)
                                .font(.custom(settings.fontChoice, size: 24))
                                .foregroundStyle(Color(settings.textColor))
                            Spacer()
                            Button {
                                itemToDelete = item
                                showingDeleteAlert = true
                            } label: {
                                Image(systemName: "trash")
                                    .foregroundStyle(.red)
                            }
                            .alert(isPresented: $showingDeleteAlert) {
                                Alert(
                                    title: Text("Confirm Delete"),
                                    message: Text(
                                        "You cannot undo this action"),
                                    primaryButton: .destructive(Text("Delete"))
                                    {
                                        if let item = itemToDelete {
                                            deleteItem(item: item)
                                        }
                                        itemToDelete = nil
                                    },
                                    secondaryButton: .cancel {
                                        itemToDelete = nil
                                    }
                                )
                            }
                        }
                        .padding()
                    }
                }
                .frame(width: 320, height: 80, alignment: .topLeading)
                .foregroundColor(Color(settings.textColor))
            }
            NavigationLink {
                NewItemView(collection: collection)
            } label: {
                HStack {
                    Image(systemName: "plus.square")
                        .font(.system(size: 65))
                        .frame(width: 65, height: 65, alignment: .topLeading)
                        .foregroundStyle(Color(settings.textColor))
                    Text("New Item")
                        .font(.custom(settings.fontChoice, size:24))
                        .foregroundStyle(Color(settings.textColor))
                    Spacer()
                    }
                }
            .padding(.leading, 50)
            Spacer()
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        VStack {
                            Text("Collection: " + collection.name)
                                .font(
                                    .custom(
                                        settings.fontChoice, size: 16,
                                        relativeTo: .headline)
                                )
                                .bold()
                                .foregroundStyle(Color(settings.textColor))
                        }
                    }
                }
                .navigationDestination(for: Item.self) { item in
                    ItemView(item: item)
                }
        }
        .containerRelativeFrame([.horizontal, .vertical])
        .background(Color(settings.backgroundColor))
    }

    func deleteItem(item: Item) {
        collections.collectionArray[
            collections.collectionArray.firstIndex(where: {
                $0.id == collection.id
            })!
        ].items.remove(
            at: collections.collectionArray[
                collections.collectionArray.firstIndex(where: {
                    $0.id == collection.id
                })!
            ].items.firstIndex(where: { $0.id == item.id })!)
    }
}
