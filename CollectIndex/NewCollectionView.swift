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
    
    var photoPicker = PhotoPicker()
    
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack{
            Spacer()
            
            Text("New Collection")
                .bold()
                .font(.system(size:30))
            
            
            HStack{
                Text("Collection Name")
                TextField("Collection Name", text:$cName)
                    .textFieldStyle(.roundedBorder)
            }
            .padding()
            
            VStack{
                HStack{
                    Spacer()
                    Text("Collection Cover")
                    Spacer()
                    PhotosPicker("Select an image", selection: $selectedItem, matching:.images)
                        .onChange(of: selectedItem){
                            Task{
                                if let data = try? await selectedItem?.loadTransferable(type: Data.self){
                                    cImage = UIImage(data: data)
                                }
                                print("Failed to load the image")
                            }
                        }
                    Spacer()
                }
                if let cImage{
                    Image(uiImage: cImage)
                        .resizable()
                        .scaledToFit()
                }
            }
            .padding()
            
            Spacer()
            
            Text("Item Fields")
                .bold()
                .underline()
                .font(.system(size:24))
            
            HStack{
                Text("Item Name")
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
            
            Spacer()
            Spacer()
            Spacer()
            
            Button("Create Collection"){
                createCollection()
                dismiss()
            }
            .buttonStyle(.bordered)
            .disabled(cName == "" || iName == "" || pName == "" || cImage == nil)
        }
        
    }
    func createCollection(){
        collections.collectionArray.append(Collection(id: UUID(), name: cName, items: [Item](), coverImage: cImage, itemName: iName, photoName: pName))
    }
}

#Preview {
    NewCollectionView()
        .environmentObject(Collections())
}
