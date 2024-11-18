//
//  ItemView.swift
//  CollectIndex
//
//  Created by Violet Chaffee on 10/17/24.
//

import SwiftUI
import PhotosUI

struct ItemView: View {
    @EnvironmentObject var settings: SettingsManager
    @State var item: Item
    //may need to make it a scroll view
    var body: some View {
        ScrollView{
            Spacer()
            Text(item.name)
                .font(.system(size: 24))
                .foregroundStyle(Color(settings.textColor))
            Image(uiImage: UIImage(data: item.image.photo)!)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200, height: 200)
            Spacer()
            ForEach(item.otherFields) {other in
                HStack{
                    Text(other.key + ":")
                        .bold()
                        .foregroundStyle(Color(settings.textColor))
                    Text(other.value)
                        .foregroundStyle(Color(settings.textColor))
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
        .containerRelativeFrame([.horizontal, .vertical])
        .background(Color(settings.backgroundColor))
    }
}

#Preview {
    ItemView(item: Item.example)
        .environmentObject(SettingsManager())
}
