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
    @State private var otherFields: [Other] = [Other]()
    @EnvironmentObject var collections: Collections
    @Environment(\.dismiss) var dismiss
    
    @State private var otherValue1: String = ""
    @State private var otherValue2: String = ""
    @State private var otherValue3: String = ""
    @State private var otherValue4: String = ""
    @State private var otherValue5: String = ""
    
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
            
            ForEach(collection.otherKeys.indices, id: \.self){index in
                HStack{
                    Text(collection.otherKeys[index].value)
                    if (index == 0){
                        TextField(collection.otherKeys[index].value, text: $otherValue1)
                    } else if (index == 1){
                        TextField(collection.otherKeys[index].value, text: $otherValue2)
                    } else if (index == 2){
                        TextField(collection.otherKeys[index].value, text: $otherValue3)
                    } else if (index == 3){
                        TextField(collection.otherKeys[index].value, text: $otherValue4)
                    } else if (index == 4){
                        TextField(collection.otherKeys[index].value, text: $otherValue5)
                    }
                }
                .padding()
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
            .disabled(iName == "" || iImage == nil && (( collection.otherKeys.count == 0) ||
                      (collection.otherKeys.count == 1 && otherValue1 == "") || (collection.otherKeys.count == 2 && otherValue1 == "" || otherValue2 == "") || (collection.otherKeys.count == 3 && otherValue1 == "" || otherValue2 == "" || otherValue3 == "") || (collection.otherKeys.count == 4 && otherValue1 == "" || otherValue2 == "" || otherValue3 == "" || otherValue4 == "") || (collection.otherKeys.count == 5 && otherValue1 == "" || otherValue2 == "" || otherValue3 == "" || otherValue4 == "" || otherValue5 == "")))
        }
    }
    
    func createItem(){
        for index in collection.otherKeys.indices {
            if(index == 0 && otherValue1 != ""){
                self.otherFields.append(Other(id:UUID(), key:collection.otherKeys[index].value, value:otherValue1))
            }
            if(index == 1 && otherValue1 != ""){
                self.otherFields.append(Other(id:UUID(), key:collection.otherKeys[index].value, value:otherValue2))
            }
            if(index == 2 && otherValue1 != ""){
                self.otherFields.append(Other(id:UUID(), key:collection.otherKeys[index].value, value:otherValue3))
            }
            if(index == 3 && otherValue1 != ""){
                self.otherFields.append(Other(id:UUID(), key:collection.otherKeys[index].value, value:otherValue4))
            }
            if(index == 4 && otherValue1 != ""){
                self.otherFields.append(Other(id:UUID(), key:collection.otherKeys[index].value, value:otherValue5))
            }
        }
        if let index = collections.collectionArray.firstIndex(where: {$0.id == collection.id}){
            collections.collectionArray[index].items.append(Item(id:UUID(), name: iName, image: CodableImage(photo: iImage!), otherFields: otherFields))
            print("")
        }
    }
    
}

#Preview {
    NewItemView(collection:Collection.example)
}
