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
    @EnvironmentObject var settings: SettingsManager
    @State private var selectedItem: PhotosPickerItem?
    @State private var cName: String = ""
    @State private var iName: String = ""
    @State private var pName: String = ""
    @State private var cImage: UIImage? = nil
    @State private var oKeys: [Key] = [Key]()
    @State private var shouldHide: Bool = false
    @State private var fieldToDelete: UUID?
    @State private var showingDeleteAlert = false
    @State private var enableButton = false
    
    var photoPicker = PhotoPicker()
    
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ScrollView{
            VStack{
                Spacer()
                
                Text("New Collection")
                    .bold()
                    .font(.system(size:30))
                    .foregroundStyle(Color(settings.textColor))
                
                
                HStack{
                    Text("  Collection Name")
                        .foregroundStyle(Color(settings.textColor))
                    TextField("", text:$cName, prompt: Text("Collection Name").foregroundStyle(Color(settings.textColor).opacity(0.5)))
                        .padding(5)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10.0)
                                .strokeBorder(Color(settings.textColor))
                        )
                        .padding(5)
                        .foregroundStyle(Color(settings.textColor))
                        
                }
                .padding()
                
                VStack{
                    HStack{
                        Spacer()
                        Text("Collection Cover                         ")
                            .foregroundStyle(Color(settings.textColor))
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
                    .foregroundStyle(Color(settings.textColor))
                
                HStack{
                    Text("Item Name   ")
                        .foregroundStyle(Color(settings.textColor))
                    TextField("", text:$iName, prompt: Text("Item Name").foregroundStyle(Color(settings.textColor).opacity(0.5)))
                        .padding(5)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10.0)
                                .strokeBorder(Color(settings.textColor))
                        )
                        .padding(5)
                        .foregroundStyle(Color(settings.textColor)).opacity(1)
                }
                .padding()
                
                HStack{
                    Text("Photo Name")
                        .foregroundStyle(Color(settings.textColor))
                    TextField("", text:$pName, prompt: Text("Photo Name").foregroundStyle(Color(settings.textColor).opacity(0.5)))
                        .padding(5)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10.0)
                                .strokeBorder(Color(settings.textColor))
                        )
                        .padding(5)
                        .foregroundStyle(Color(settings.textColor))
                }
                .padding()
                
                ForEach($oKeys, id:\.self.id) {descriptor in
                    HStack{
                        TextField("", text:descriptor.value, prompt: Text("New Item Field").foregroundStyle(Color(settings.textColor).opacity(0.5)))
                            .padding(5)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10.0)
                                    .strokeBorder(Color(settings.textColor))
                            )
                            .padding(5)
                            .foregroundStyle(Color(settings.textColor))
                        Spacer()
                        Button {
                            fieldToDelete = descriptor.id
                            showingDeleteAlert = true
                        } label: {
                            Image(systemName: "trash")
                                .foregroundStyle(.red)
                        }
                        .alert(isPresented:$showingDeleteAlert) {
                            Alert(
                                title: Text("Confirm Delete"),
                                message: Text("You cannot undo this action"),
                                primaryButton: .destructive(Text("Delete")) {
                                    if let field = fieldToDelete {
                                        deleteField(field: field)
                                    }
                                    fieldToDelete = nil
                                },
                                secondaryButton: .cancel() {
                                    fieldToDelete = nil
                                }
                            )
                        }
                    }
                    .padding(.trailing)
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
//                    .padding(8)
//                    .background(Color(settings.textColor).opacity(0.5))
//                    .buttonStyle(.bordered)
//                    .cornerRadius(10)
                    .disabled(cName == "" || iName == "" || pName == "" || cImage == nil && ((oKeys.count == 0) || (oKeys.count == 1 && oKeys[0].value == "") || (oKeys.count == 2 && oKeys[0].value == "" || oKeys[1].value == "") || (oKeys.count == 3 && oKeys[0].value == "" || oKeys[1].value == "" || oKeys[2].value == "") || (oKeys.count == 4 && oKeys[0].value == "" || oKeys[1].value == "" || oKeys[2].value == "" || oKeys[3].value == "") || (oKeys.count == 5 && oKeys[0].value == "" || oKeys[1].value == "" || oKeys[2].value == "" || oKeys[3].value == "" || oKeys[4].value == "")))
            }
            
        }
        .containerRelativeFrame([.horizontal, .vertical])
        .background(Color(settings.backgroundColor))
        
    }
        
    func createCollection(){
        collections.collectionArray.append(Collection(id: UUID(), name: cName, items: [Item](), coverImage: CodableImage(photo: cImage!), itemName: iName, photoName: pName, otherKeys: oKeys, numKeys: oKeys.count))
    }
    func addItemField(){
        oKeys.append(Key(""))
    }
    
    func deleteField(field: UUID){
        oKeys.remove(at: oKeys.firstIndex(where: {$0.id == field})!)
    }
    
}

#Preview {
    NewCollectionView()
        .environmentObject(Collections())
        .environmentObject(SettingsManager())
}
