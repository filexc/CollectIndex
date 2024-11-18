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
    @Binding var fontChoice: String
    
    var body: some View {
        VStack{
            VStack{
                Text("Background Color")
                    .bold()
                    .foregroundStyle(Color(textColor))
                    .font(.custom(fontChoice, size:16, relativeTo:.body))
                
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
                                .stroke(Color(textColor), lineWidth:1)
                                .fill(Color(swatch))
                                .frame(width: 50, height: 50)
                                .onTapGesture(perform: {
                                    if (swatch != textColor){
                                        backgroundColor = swatch
                                    }
                                })
                                .padding(10)
                            
                            
                            if backgroundColor == swatch {
                                Circle()
                                    .stroke(Color(swatch), lineWidth: 0)
                                    .border(Color(textColor))
                                    .frame(width: 60, height: 60)
                            }
                        }
                    }
                }
                .padding(10)
                
            }
            VStack {
                Text("Text Color")
                    .foregroundStyle(Color(textColor))
                    .bold()
                    .font(.custom(fontChoice, size:16, relativeTo:.body))
                
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
                                .stroke(Color(textColor), lineWidth:1)
                                .fill(Color(swatch))
                                .frame(width: 50, height: 50)
                                .onTapGesture(perform: {
                                    if (swatch != backgroundColor) {
                                        textColor = swatch
                                    }
                                })
                                .padding(10)
                            
                            
                            if textColor == swatch {
                                Circle()
                                    .stroke(Color(swatch), lineWidth: 0)
                                    .border(Color(textColor))
                                    .frame(width: 60, height: 60)
                            }
                        }
                    }
                }
                .padding(10)
            }
            
            VStack{
                Text("Font")
                    .foregroundStyle(Color(textColor))
                    .bold()
                    .font(.custom(fontChoice, size:16, relativeTo:.body))
                
                Picker("Fonts", selection: $fontChoice){
                    Text("Avenir").font(.custom("Avenir-Book", size: 20)).tag("Avenir-Book").foregroundStyle(Color(textColor))
                    Text("Chalkboard").font(.custom("Chalkboard", size: 20)).tag("Chalkboard").foregroundStyle(Color(textColor))
                    Text("Georgia").font(.custom("Georgia", size: 20)).tag("Georgia").foregroundStyle(Color(textColor))
                    Text("Helvetica Neue").font(.custom("HelveticaNeue", size: 20)).tag("HelveticaNeue").foregroundStyle(Color(textColor))
                    Text("Marker Felt").font(.custom("MarkerFelt-Thin", size: 20)).tag("MarkerFelt-Thin").foregroundStyle(Color(textColor))
                    Text("Noteworthy").font(.custom("Noteworthy-Light", size: 20)).tag("Noteworthy-Light").foregroundStyle(Color(textColor))
                    Text("Palatino").font(.custom("Palatino-Roman", size: 20)).tag("Palatino-Roman").foregroundStyle(Color(textColor))
                    Text("SF Pro").font(.custom("SFPro-Regular", size: 20)).tag("SFPro-Regular").foregroundStyle(Color(textColor))
                    Text("Times New Roman").font(.custom("TimesNewRomanPSMT", size: 20)).tag("TimesNewRomanPSMT").foregroundStyle(Color(textColor))
                }
                .pickerStyle(.wheel)
                
            }
            
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .stroke(Color(textColor))
                .fill(Color(backgroundColor))
                .overlay(Text("Sample Text").font(.custom(fontChoice, size:36)).foregroundStyle(Color(textColor)))
                .padding()
                
        }
//        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                VStack {
                    Text("Nav Title")
                        .font(.custom(fontChoice, size:16, relativeTo:.headline))
                        .bold()
                        .foregroundStyle(Color(textColor))
                }
            }
        }
        .containerRelativeFrame([.horizontal, .vertical])
        .background(Color(backgroundColor))
        
    }
    
    //TODO: fonts
    //features
    // fonts
    //sans serif font
    //serif font
    //handwriting font?
}

#Preview {
    SettingsView(backgroundColor:.constant("backgroundSepia"), textColor: .constant("textBrown"), fontChoice: .constant("Avenir"))
}

