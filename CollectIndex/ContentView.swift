//
//  ContentView.swift
//  CollectIndex
//
//  Created by Violet Chaffee on 9/30/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var collections: Collections
    @EnvironmentObject var settings: SettingsManager
    @State private var showingDetail = false
    @State private var collectionToDelete: Collection?
    @State private var showingDeleteAlert = false

    var body: some View {
        NavigationStack {
            ScrollView {
                ForEach(collections.collectionArray) { collection in
                    VStack {
                        NavigationLink {
                            CollectionView(collection: collection)
                        } label: {
                            HStack {
                                Image(
                                    uiImage: UIImage(
                                        data: collection.coverImage.photo)!
                                )
                                .resizable()
                                .frame(width: 60, height: 60)
                                .clipShape(
                                    RoundedRectangle(
                                        cornerSize: CGSize(
                                            width: 10, height: 10)))
                                Text(collection.name)
                                    .font(
                                        .custom(settings.fontChoice, size: 24)
                                    )
                                    .foregroundStyle(Color(settings.textColor))
                                Spacer()
                                Button {
                                    collectionToDelete = collection
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
                                        primaryButton: .destructive(
                                            Text("Delete")
                                        ) {
                                            if let collection =
                                                collectionToDelete
                                            {
                                                deleteCollection(
                                                    collection: collection)
                                            }
                                            collectionToDelete = nil
                                        },
                                        secondaryButton: .cancel {
                                            collectionToDelete = nil
                                        }
                                    )
                                }
                            }
                            .padding()
                        }
                    }
                    .frame(width: 320, height: 80, alignment: .topLeading)
                    .foregroundColor(Color(settings.textColor))
                    .background(Color(settings.backgroundColor))
                }
                NavigationLink(destination: NewCollectionView()) {
                    Image(systemName: "plus.square")
                        .font(.system(size: 60))
                        .frame(width: 300, height: 60, alignment: .topLeading)
                        .foregroundStyle(Color(settings.textColor))
                }
                Spacer()
                    .navigationBarBackButtonHidden(true)

            }
            .navigationDestination(for: Collection.self) { collection in
                CollectionView(collection: collection)
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("CollectIndex: Collections")
                        .font(
                            .custom(
                                settings.fontChoice, size: 16,
                                relativeTo: .headline)
                        )
                        .bold()
                        .foregroundStyle(Color(settings.textColor))

                }
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        SettingsView(
                            backgroundColor: settings.$backgroundColor,
                            textColor: settings.$textColor,
                            fontChoice: settings.$fontChoice)
                    } label: {
                        Image(systemName: "gear")
                            .foregroundStyle(Color(settings.textColor))
                    }
                }
            }
            .containerRelativeFrame([.horizontal, .vertical])
            .background(Color(settings.backgroundColor))
            .toolbarBackground(Color(settings.backgroundColor))
        }

    }

    func deleteCollection(collection: Collection) {
        collections.collectionArray.remove(
            at: collections.collectionArray.firstIndex(where: {
                $0.id == collection.id
            })!)
    }
}
