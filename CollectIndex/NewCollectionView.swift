//
//  NewCollectionView.swift
//  CollectIndex
//
//  Created by Violet Chaffee on 10/3/24.
//

import SwiftUI
import PhotosUI

struct NewCollectionView: View {
    @EnvironmentObject var collections: Collections
    
    @State private var selectedItem: PhotosPickerItem?
    @State private var cName: String = ""
    @State private var iName: String = ""
    @State private var pName: String = ""
    @State private var cImage: UIImage? = nil
    @State private var oKeys: [Key] = [Key]()
    @State private var shouldHide: Bool = false
    //TODO: (if time) be able to delete added item fields
    
    var photoPicker = PhotoPicker()
    
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ScrollView{
            VStack{
                Spacer()
                
                Text("New Collection")
                    .bold()
                    .font(.system(size:30))
                
                
                HStack{
                    Text("  Collection Name")
                    TextField("Collection Name", text:$cName)
                        .textFieldStyle(.roundedBorder)
                }
                .padding()
                
                VStack{
                    HStack{
                        Spacer()
                        Text("Collection Cover                         ")
                        PhotosPicker("Select an image", selection: $selectedItem, matching:.images)
                            .onChange(of: selectedItem){
                                Task{
                                    if let data = try? await selectedItem?.loadTransferable(type: Data.self){
                                        cImage = UIImage(data: data)
                                    }
                                    print("Failed to load the image")
                                }
                            }
                    }
                    if let cImage{
                        Image(uiImage: cImage)
                            .resizable()
                            .scaledToFit()
                    }
                }
                .padding()
                
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                
                Text("Item Fields")
                    .bold()
                    .underline()
                    .font(.system(size:24))
                
                HStack{
                    Text("Item Name   ")
                    TextField("Item Name", text:$iName)
                        .textFieldStyle(.roundedBorder)
                }
                .padding()
                
                HStack{
                    Text("Photo Name")
                    TextField("Photo Name", text:$pName)
                        .textFieldStyle(.roundedBorder)
                }
                .padding()
                
                ForEach($oKeys, id:\.self.id) {descriptor in
                    TextField("New Item Field", text: descriptor.value)
                        .textFieldStyle(.roundedBorder)
                        .padding()
                }
                
                if !shouldHide{
                    Button("Add Item Field"){
                        addItemField()
                        if (oKeys.count == 5){
                            shouldHide = true
                        }
                    }
                }
                
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                
                Button("Create Collection"){
                    createCollection()
                    dismiss()
                }
                .buttonStyle(.bordered)
                .disabled(cName == "" || iName == "" || pName == "" || cImage == nil)
                //TODO: make disabled for the added fields too...
            }
        }
    }
    func createCollection(){
        collections.collectionArray.append(Collection(id: UUID(), name: cName, items: [Item](), coverImage: CodableImage(photo: cImage!), itemName: iName, photoName: pName, otherKeys: oKeys, numKeys: oKeys.count))
    }
    func addItemField(){
        oKeys.append(Key(""))
    }
}

#Preview {
    NewCollectionView()
        .environmentObject(Collections())
}
