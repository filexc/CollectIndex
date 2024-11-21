//
//  ItemView.swift
//  CollectIndex
//
//  Created by Violet Chaffee on 10/17/24.
//

import PhotosUI
import SwiftUI

struct ItemView: View {
    @EnvironmentObject var settings: SettingsManager
    @State var item: Item

    var body: some View {
        ScrollView {
            Spacer()
            Text(item.name)
                .font(.custom(settings.fontChoice, size: 24, relativeTo: .body))
                .foregroundStyle(Color(settings.textColor))
            Image(uiImage: UIImage(data: item.image.photo)!)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200, height: 200)
            Spacer()
            ForEach(item.otherFields) { other in
                HStack {
                    Text(other.key + ":")
                        .bold()
                        .foregroundStyle(Color(settings.textColor))
                        .font(
                            .custom(
                                settings.fontChoice, size: 16, relativeTo: .body
                            ))
                    Text(other.value)
                        .foregroundStyle(Color(settings.textColor))
                        .font(
                            .custom(
                                settings.fontChoice, size: 16, relativeTo: .body
                            ))
                }
                .padding()
            }
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            Spacer()
        }
        .containerRelativeFrame([.horizontal, .vertical])
        .background(Color(settings.backgroundColor))
        .toolbarBackground(Color(settings.backgroundColor))
        .toolbar {
            ToolbarItem(placement: .principal) {
                VStack {
                    Text("Item: " + item.name)
                        .font(
                            .custom(
                                settings.fontChoice, size: 16,
                                relativeTo: .headline)
                        )
                        .bold()
                        .foregroundStyle(Color(settings.textColor))
                }
            }
        }
    }
}

#Preview {
    ItemView(item: Item.example)
        .environmentObject(SettingsManager())
}
