//
//  ItemView.swift
//  CollectIndex
//
//  Created by Violet Chaffee on 10/17/24.
//

import SwiftUI

struct ItemView: View {
    @State var item: Item
    var body: some View {
        Text(item.name)
    }
}

#Preview {
    ItemView(item: Item.example)
}
