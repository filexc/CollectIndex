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
    
    @State private var keyboardHeight: CGFloat = 0

    @State private var selectedItem: PhotosPickerItem?
    @State private var cName: String = ""
    @State private var iName: String = ""
    @State private var pName: String = ""
    @State private var cImage: UIImage? = nil
    @State private var oKey1: String = ""
    @State private var oKey2: String = ""
    @State private var oKey3: String = ""
    @State private var oKey4: String = ""
    @State private var oKey5: String = ""
    @State private var count: Int = 0
    @State private var shouldHide: Bool = false
    @State private var fieldToDelete: Int?
    @State private var showingDeleteAlert = false
    @State private var enableButton = false
    
    var photoPicker = PhotoPicker()
    
    @Environment(\.dismiss) var dismiss

    var body: some View {
            ScrollView{
                //            VStack{
                Text("New Collection")
                    .bold()
                    .font(.custom(settings.fontChoice, size:30, relativeTo:.title))
                    .foregroundStyle(Color(settings.textColor))
                
                Spacer()
                Spacer()
                HStack{
                    Text("  Collection Name")
                        .foregroundStyle(Color(settings.textColor))
                        .font(.custom(settings.fontChoice, size:16, relativeTo:.body))
                    TextField("", text:$cName, prompt: Text("Collection Name").foregroundStyle(Color(settings.textColor).opacity(0.5)))
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
                    Text("  Collection Cover")
                        .foregroundStyle(Color(settings.textColor))
                        .font(.custom(settings.fontChoice, size:16, relativeTo:.body))
                    Spacer()
                    PhotosPicker("Select an image", selection: $selectedItem, matching:.images)
                        .font(.custom(settings.fontChoice, size:16, relativeTo:.body))
                        .onChange(of: selectedItem){
                            Task{
                                if let data = try? await selectedItem?.loadTransferable(type: Data.self){
                                    cImage = UIImage(data: data)
                                }
                                print("Failed to load the image")
                            }
                        }
                }
                .padding()
                if let cImage{
                    Image(uiImage: cImage)
                        .resizable()
                        .scaledToFit()
                        .padding()
                }
                //                }
                //                .padding()
                
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
                    .font(.custom(settings.fontChoice, size:24, relativeTo:.subheadline))
                    .foregroundStyle(Color(settings.textColor))
                
                HStack{
                    Text("  Item Name")
                        .foregroundStyle(Color(settings.textColor))
                        .font(.custom(settings.fontChoice, size:16, relativeTo:.body))
                    Spacer()
                    TextField("", text:$iName, prompt: Text("Item Name").foregroundStyle(Color(settings.textColor).opacity(0.5)))
                        .font(.custom(settings.fontChoice, size:16, relativeTo:.body))
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
                        .font(.custom(settings.fontChoice, size:16, relativeTo:.body))
                    TextField("", text:$pName, prompt: Text("Photo Name").foregroundStyle(Color(settings.textColor).opacity(0.5)))
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
                
                if (count >= 1){
                    HStack{
                        TextField("", text: $oKey1, prompt: Text("New Item Field").foregroundStyle(Color(settings.textColor).opacity(0.5)))
                            .font(.custom(settings.fontChoice, size:16, relativeTo:.body))
                            .padding(5)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10.0)
                                    .strokeBorder(Color(settings.textColor))
                            )
                            .padding(5)
                            .foregroundStyle(Color(settings.textColor))
                        Spacer()
                        Button {
                            fieldToDelete = 1
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
                
                if (count >= 2){
                    HStack{
                        TextField("", text: $oKey2, prompt: Text("New Item Field").foregroundStyle(Color(settings.textColor).opacity(0.5)))
                            .font(.custom(settings.fontChoice, size:16, relativeTo:.body))
                            .padding(5)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10.0)
                                    .strokeBorder(Color(settings.textColor))
                            )
                            .padding(5)
                            .foregroundStyle(Color(settings.textColor))
                        Spacer()
                        Button {
                            fieldToDelete = 2
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
                
                if (count >= 3){
                    HStack{
                        TextField("", text: $oKey3, prompt: Text("New Item Field").foregroundStyle(Color(settings.textColor).opacity(0.5)))
                            .font(.custom(settings.fontChoice, size:16, relativeTo:.body))
                            .padding(5)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10.0)
                                    .strokeBorder(Color(settings.textColor))
                            )
                            .padding(5)
                            .foregroundStyle(Color(settings.textColor))
                        Spacer()
                        Button {
                            fieldToDelete = 3
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
                
                if (count >= 4){
                    HStack{
                        TextField("", text: $oKey4, prompt: Text("New Item Field").foregroundStyle(Color(settings.textColor).opacity(0.5)))
                            .font(.custom(settings.fontChoice, size:16, relativeTo:.body))
                            .padding(5)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10.0)
                                    .strokeBorder(Color(settings.textColor))
                            )
                            .padding(5)
                            .foregroundStyle(Color(settings.textColor))
                        Spacer()
                        Button {
                            fieldToDelete = 4
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
                
                if (count == 5){
                    HStack{
                        TextField("", text: $oKey5, prompt: Text("New Item Field").foregroundStyle(Color(settings.textColor).opacity(0.5)))
                            .font(.custom(settings.fontChoice, size:16, relativeTo:.body))
                            .padding(5)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10.0)
                                    .strokeBorder(Color(settings.textColor))
                            )
                            .padding(5)
                            .foregroundStyle(Color(settings.textColor))
                        Spacer()
                        Button {
                            fieldToDelete = 5
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
                        if (count == 5){
                            shouldHide = true
                        }
                    }
                    .font(.custom(settings.fontChoice, size:16, relativeTo:.body))
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
                .background(Color(settings.textColor).opacity(0.3))
                .foregroundStyle(Color(settings.textColor))
                .font(.custom(settings.fontChoice, size:16, relativeTo:.body))
                .buttonStyle(.bordered)
                .cornerRadius(10)
                .disabled(cName == "" || iName == "" || pName == "" || cImage == nil || (count >= 1 && oKey1 == "") || (count >= 2 && oKey2 == "") || (count >= 3 && oKey3 == "") || (count >= 4 && oKey4 == "") || (count == 5 && oKey5 == ""))
                //            }
            }
            .modifier(DismissingKeyboard())
            .keyboardHeight($keyboardHeight)
//            .offset(y: -keyboardHeight / 2)
            //        .containerRelativeFrame([.horizontal, .vertical])
            .background(Color(settings.backgroundColor))
            .toolbarBackground(Color(settings.backgroundColor))
            //        .ignoresSafeArea(.)
        }
        
    func createCollection(){
        collections.collectionArray.append(Collection(id: UUID(), name: cName, items: [Item](), coverImage: CodableImage(photo: cImage!), itemName: iName, photoName: pName, otherKey1: oKey1, otherKey2: oKey2, otherKey3: oKey3, otherKey4: oKey4, otherKey5: oKey5))
    }
    
    func addItemField(){
        count += 1
    }
    
    func deleteField(field: Int){
        if field == 1 {
            oKey1 = oKey2
        }
        if field <= 2 {
            oKey2 = oKey3
        }
        if field <= 3 {
            oKey3 = oKey4
        }
        if field <= 4 {
            oKey4 = oKey5
        }
        if field <= 5 {
            oKey5 = ""
        }
        count -= 1
        shouldHide = false
    }
    
}

#Preview {
    NewCollectionView()
        .environmentObject(Collections())
        .environmentObject(SettingsManager())
}
