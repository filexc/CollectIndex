//
//  NewItemView.swift
//  CollectIndex
//
//  Created by Violet Chaffee on 10/15/24.
//

import SwiftUI
import PhotosUI

struct NewItemView: View {
    @State private var selectedItem: PhotosPickerItem?
    @State private var iName: String = ""
    @State private var iImage: UIImage? = nil
    @State var collection: Collection
//    @State var oDescriptions: [String] = [String]()
    
    @State private var otherFields: [Other] = [Other]()
    @EnvironmentObject var collections: Collections
    //TODO: iterate through Other descriptor array and make an otherFields array through this
    
    @Environment(\.dismiss) var dismiss
    
    var photoPicker = PhotoPicker()
    
    var body: some View {
        VStack{
            Spacer()
            
            Text("New Item")
                .bold()
                .font(.system(size:30))
            HStack{
                Text(collection.itemName)
                TextField(collection.itemName, text:$iName)
                    .textFieldStyle(.roundedBorder)
            }
            .padding()
            
            VStack{
                HStack{
                    Text(collection.photoName)
                    Spacer()
                    PhotosPicker("Select an image", selection: $selectedItem, matching:.images)
                        .onChange(of: selectedItem){
                            Task{
                                if let data = try? await selectedItem?.loadTransferable(type: Data.self){
                                    iImage = UIImage(data: data)
                                }
                                print("Failed to load the image")
                            }
                        }
                }
                if let iImage{
                    Image(uiImage: iImage)
                        .resizable()
                        .scaledToFit()
                }
            }
            .padding()
            
            ForEach(collection.otherDescriptors.indices, id: \.self){index in
                NewFieldRow(collection: collection, index: index, description: "")
//                HStack{
//                    Text(collection.otherDescriptors[index])
//                    Spacer()
//                    // TODO: figure out how to bind a text field to a new array :)
////                    TextField(text:)
////                        .textFieldStyle(.roundedBorder)
//                }
//                .padding()
            }
            
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            
            Button("Create Item"){
                createItem()
                dismiss()
            }
            .buttonStyle(.bordered)
            .disabled(iName == "" || iImage == nil)
        }
    }
    
    func createItem(){
//        ForEach(collection.otherDescriptors.indices, id: \.self){index in
//            otherFields.append(Other(id:UUID(), description: String, descriptor: collection.otherDescriptors[index]))
//        }
        if let index = collections.collectionArray.firstIndex(where: {$0.id == collection.id}){
            collections.collectionArray[index].items.append(Item(id:UUID(), name: iName, image: CodableImage(photo: iImage!), otherFields: [Other]()))
            print("")
        }
//        collection.add(item: Item(id:UUID(), name: iName, image: iImage))
//        print(collection.items)
    }
    
}

#Preview {
    NewItemView(collection:Collection.example)
}
