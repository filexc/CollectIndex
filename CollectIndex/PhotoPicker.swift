//
//  PhotoPicker.swift
//  CollectIndex
//
//  Created by Violet Chaffee on 9/30/24.
//

import PhotosUI
//code from https://medium.com/@jakir/access-the-camera-and-photo-library-in-swiftui-0351a3c280f5
import SwiftUI

struct PhotoPicker: View {
    @State private var selectedItem: PhotosPickerItem?
    @State var image: UIImage?

    var body: some View {
        VStack {
            PhotosPicker(
                "Select an image", selection: $selectedItem, matching: .images
            )
            .onChange(of: selectedItem) {
                Task {
                    if let data = try? await selectedItem?.loadTransferable(
                        type: Data.self)
                    {
                        image = UIImage(data: data)
                    }
                    print("Failed to load the image")
                }
            }
            if let image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            }
        }
        .padding()
    }
}

#Preview {
    PhotoPicker()
}
