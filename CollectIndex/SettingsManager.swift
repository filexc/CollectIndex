//
//  SettingsManager.swift
//  CollectIndex
//
//  Created by Violet Chaffee on 11/15/24.
//

import Foundation
import SwiftUI

class SettingsManager: ObservableObject {
    @AppStorage("backgroundColor") var backgroundColor: String = "backgroundPink"
    @AppStorage("textColor") var textColor: String = "textDarkPink"
    @AppStorage("fontChoice") var fontChoice: String = "Avenir" //TODO: make the font implemented through the whole app
}
