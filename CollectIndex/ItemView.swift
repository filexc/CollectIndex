//
//  ItemView.swift
//  CollectIndex
//
//  Created by Violet Chaffee on 10/17/24.
//

import SwiftUI
import PhotosUI

struct ItemView: View {
    @State var item: Item
    //may need to make it a scroll view
    var body: some View {
        Spacer()
        Text(item.name)
            .font(.system(size: 24))
            Image(uiImage: UIImage(data: item.image.photo)!)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200, height: 200)
        Spacer()
        ForEach(item.otherFields) {other in
            HStack{
                Text(other.description + ":")
                    .bold()
                Text(other.descriptor)
            }
            .padding()
        }
        Spacer()
        Spacer()
        Spacer()
        Spacer()
        Spacer()
        Spacer()
            .navigationTitle("Item: " + item.name)
    }
}

#Preview {
    ItemView(item: Item.example)
}
