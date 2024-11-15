//
//  SettingsManager.swift
//  CollectIndex
//
//  Created by Violet Chaffee on 11/15/24.
//

import Foundation
import SwiftUI

class SettingsManager: ObservableObject {
    @AppStorage("backgroundColor") var backgroundColor: String = "black"
    @AppStorage("textColor") var textColor: String = "white"
    //TODO: add font
}
