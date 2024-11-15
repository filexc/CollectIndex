//
//  SettingsView.swift
//  CollectIndex
//
//  Created by Violet Chaffee on 11/12/24.
//

import SwiftUI

struct SettingsView: View {
    @Binding var backgroundColor: String
    @Binding var textColor: String
    
    var body: some View {
        VStack{
            Text("Background Color")
                .bold()
            let backgroundColors = [
                "white",
                "black",
                "backgroundSepia",
                "backgroundPink",
                "backgroundPeach",
                "backgroundGreen",
                "backgroundBlue",
                "backgroundPurple"
            ]
            
            let columns = [
                GridItem(.adaptive(minimum: 80))
            ]
            
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(backgroundColors, id: \.self){ swatch in
                    ZStack {
                        Circle()
                            .stroke(Color(.black), lineWidth:1)
                            .fill(Color(swatch))
                            .frame(width: 50, height: 50)
                            .onTapGesture(perform: {
                                backgroundColor = swatch
                            })
                            .padding(10)
                        
                        
                        if backgroundColor == swatch {
                            Circle()
                                .stroke(Color(swatch), lineWidth: 0)
                                .border(.black)
                                .frame(width: 60, height: 60)
                        }
                    }
                }
            }
            .padding(10)
            
        }
        VStack {
            Text("Text Color")
                .bold()
            let textColors = [
                "white",
                "black",
                "textBrown",
                "textBrown2",
                "textDarkPink",
                "textDarkGreen",
                "textDarkBlue",
                "textDarkPurple"
            ]
            
            let columns = [
                GridItem(.adaptive(minimum: 80))
            ]
            
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(textColors, id: \.self){ swatch in
                    ZStack {
                        Circle()
                            .stroke(Color(.black), lineWidth:1)
                            .fill(Color(swatch))
                            .frame(width: 50, height: 50)
                            .onTapGesture(perform: {
                                textColor = swatch
                            })
                            .padding(10)
                        
                        
                        if textColor == swatch {
                            Circle()
                                .stroke(Color(swatch), lineWidth: 0)
                                .border(.black)
                                .frame(width: 60, height: 60)
                        }
                    }
                }
            }
            .padding(10)
        }
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.inline)
        
    }
    //features
    // fonts
    //sans serif font
    //serif font
    //handwriting font?
}

#Preview {
    SettingsView(backgroundColor:.constant("backgroundSepia"), textColor: .constant("textBrown"))
}

