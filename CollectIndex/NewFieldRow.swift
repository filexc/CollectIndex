//
//  NewFieldRow.swift
//  CollectIndex
//
//  Created by Violet Chaffee on 11/5/24.
//

import SwiftUI

struct NewFieldRow: View {
    @State var collection: Collection
    @State var index: Int
    @State var description: String
    var body: some View {
        HStack{
            Text(collection.otherDescriptors[index])
            Spacer()
            TextField(collection.otherDescriptors[index], text:$description)
                .textFieldStyle(.roundedBorder)
        }
        .padding()
    }
}

#Preview {
    NewFieldRow(collection:Collection.example, index:0, description:"")
}
