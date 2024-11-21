//
//  NewItemView.swift
//  CollectIndex
//
//  Created by Violet Chaffee on 10/15/24.
//

import SwiftUI
import PhotosUI

struct NewItemView: View {
    @State private var keyboardHeight: CGFloat = 0

    @State private var selectedItem: PhotosPickerItem?
    @State private var iName: String = ""
    @State private var iImage: UIImage? = nil
    @State var collection: Collection
    @State private var otherFields: [Other] = [Other]()
    @EnvironmentObject var collections: Collections
    @EnvironmentObject var settings: SettingsManager
    @Environment(\.dismiss) var dismiss
    
    @State private var otherValue1: String = ""
    @State private var otherValue2: String = ""
    @State private var otherValue3: String = ""
    @State private var otherValue4: String = ""
    @State private var otherValue5: String = ""
    
    var photoPicker = PhotoPicker()
    
    var body: some View {
        ScrollView{
//            VStack{
                Spacer()
                Text("New Item")
                    .bold()
                    .font(.custom(settings.fontChoice, size:30))
                    .foregroundStyle(Color(settings.textColor))
                HStack{
                    Text(collection.itemName)
                        .foregroundStyle(Color(settings.textColor))
                        .font(.custom(settings.fontChoice, size:16, relativeTo:.body))
                    TextField("", text:$iName, prompt: Text(collection.itemName).foregroundStyle(Color(settings.textColor).opacity(0.5)))
                        .font(.custom(settings.fontChoice, size:16, relativeTo:.body))
                        .padding(5)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10.0)
                                .strokeBorder(Color(settings.textColor))
                        )
                        .padding(5)
                        .foregroundStyle(Color(settings.textColor))
                }
                .padding()
                
//                VStack{
                    HStack{
                        Text(collection.photoName)
                            .foregroundStyle(Color(settings.textColor))
                            .font(.custom(settings.fontChoice, size:16, relativeTo:.body))
                        Spacer()
                        PhotosPicker("Select an image", selection: $selectedItem, matching:.images)
                            .font(.custom(settings.fontChoice, size:16, relativeTo:.body))
                            .onChange(of: selectedItem){
                                Task{
                                    if let data = try? await selectedItem?.loadTransferable(type: Data.self){
                                        iImage = UIImage(data: data)
                                    }
                                    print("Failed to load the image")
                                }
                            }
                    }
                    .padding()
                    if let iImage{
                        Image(uiImage: iImage)
                            .resizable()
                            .scaledToFit()
                    }
//                }
//                .padding()
                
                if (collection.otherKey1 != ""){
                    HStack{
                        Text(collection.otherKey1)
                            .foregroundStyle(Color(settings.textColor))
                            .font(.custom(settings.fontChoice, size:16, relativeTo:.body))
                        TextField("", text:$otherValue1, prompt: Text(collection.otherKey1).foregroundStyle(Color(settings.textColor).opacity(0.5)))
                            .font(.custom(settings.fontChoice, size:16, relativeTo:.body))
                            .padding(5)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10.0)
                                    .strokeBorder(Color(settings.textColor))
                            )
                            .padding(5)
                            .foregroundStyle(Color(settings.textColor))
                    }
                    .padding()
                }
                if (collection.otherKey2 != ""){
                    HStack{
                        Text(collection.otherKey2)
                            .foregroundStyle(Color(settings.textColor))
                            .font(.custom(settings.fontChoice, size:16, relativeTo:.body))
                        TextField("", text:$otherValue2, prompt: Text(collection.otherKey2).foregroundStyle(Color(settings.textColor).opacity(0.5)))
                            .font(.custom(settings.fontChoice, size:16, relativeTo:.body))
                            .padding(5)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10.0)
                                    .strokeBorder(Color(settings.textColor))
                            )
                            .padding(5)
                            .foregroundStyle(Color(settings.textColor))
                    }
                    .padding()
                }
                if (collection.otherKey3 != ""){
                    HStack{
                        Text(collection.otherKey3)
                            .foregroundStyle(Color(settings.textColor))
                            .font(.custom(settings.fontChoice, size:16, relativeTo:.body))
                        TextField("", text:$otherValue3, prompt: Text(collection.otherKey3).foregroundStyle(Color(settings.textColor).opacity(0.5)))
                            .font(.custom(settings.fontChoice, size:16, relativeTo:.body))
                            .padding(5)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10.0)
                                    .strokeBorder(Color(settings.textColor))
                            )
                            .padding(5)
                            .foregroundStyle(Color(settings.textColor))
                    }
                    .padding()
                }
                if (collection.otherKey4 != ""){
                    HStack{
                        Text(collection.otherKey4)
                            .foregroundStyle(Color(settings.textColor))
                            .font(.custom(settings.fontChoice, size:16, relativeTo:.body))
                        TextField("", text:$otherValue4, prompt: Text(collection.otherKey4).foregroundStyle(Color(settings.textColor).opacity(0.5)))
                            .font(.custom(settings.fontChoice, size:16, relativeTo:.body))
                            .padding(5)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10.0)
                                    .strokeBorder(Color(settings.textColor))
                            )
                            .padding(5)
                            .foregroundStyle(Color(settings.textColor))
                    }
                    .padding()
                }
                if (collection.otherKey5 != ""){
                    HStack{
                        Text(collection.otherKey5)
                            .foregroundStyle(Color(settings.textColor))
                            .font(.custom(settings.fontChoice, size:16, relativeTo:.body))
                        TextField("", text:$otherValue5, prompt: Text(collection.otherKey5).foregroundStyle(Color(settings.textColor).opacity(0.5)))
                            .font(.custom(settings.fontChoice, size:16, relativeTo:.body))
                            .padding(5)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10.0)
                                    .strokeBorder(Color(settings.textColor))
                            )
                            .padding(5)
                            .foregroundStyle(Color(settings.textColor))
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
                .font(.custom(settings.fontChoice, size:16, relativeTo:.body))
                .background(Color(settings.textColor).opacity(0.3))
                .foregroundStyle(Color(settings.textColor))
                .buttonStyle(.bordered)
                .cornerRadius(10)
                .disabled(iName == "" || iImage == nil || (collection.otherKey1 != "" && otherValue1 == "") || (collection.otherKey2 != "" && otherValue2 == "") || (collection.otherKey3 != "" && otherValue3 == "") || (collection.otherKey4 != "" && otherValue4 == "") || (collection.otherKey5 != "" && otherValue5 == ""))
//            }
        }
        .keyboardHeight($keyboardHeight)
//        .containerRelativeFrame([.horizontal, .vertical])
        .background(Color(settings.backgroundColor))
        .toolbarBackground(Color(settings.backgroundColor))
    }
    
    func createItem(){
        if(collection.otherKey1 != ""){
            self.otherFields.append(Other(id:UUID(), key: collection.otherKey1, value:otherValue1))
        }
        if(collection.otherKey2 != ""){
            self.otherFields.append(Other(id:UUID(), key: collection.otherKey2, value:otherValue2))
        }
        if(collection.otherKey3 != ""){
            self.otherFields.append(Other(id:UUID(), key: collection.otherKey3, value:otherValue3))
        }
        if(collection.otherKey4 != ""){
            self.otherFields.append(Other(id:UUID(), key: collection.otherKey4, value:otherValue4))
        }
        if(collection.otherKey5 != ""){
            self.otherFields.append(Other(id:UUID(), key: collection.otherKey5, value:otherValue5))
        }
        if let index = collections.collectionArray.firstIndex(where: {$0.id == collection.id}){
            collections.collectionArray[index].items.append(Item(id:UUID(), name: iName, image: CodableImage(photo: iImage!), otherFields: otherFields))
        }
    }
    
}

#Preview {
    NewItemView(collection:Collection.example)
        .environmentObject(SettingsManager())
}
