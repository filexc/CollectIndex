//
//  KeyboardProvider.swift
//  CollectIndex
//
//  Created by Violet Chaffee on 11/20/24.
//
import SwiftUI

struct KeyboardProvider: ViewModifier {

    var keyboardHeight: Binding<CGFloat>

    func body(content: Content) -> some View {
        content
            .onReceive(
                NotificationCenter.default.publisher(
                    for: UIResponder.keyboardWillShowNotification),
                perform: { notification in
                    guard let userInfo = notification.userInfo,
                        let keyboardRect = userInfo[
                            UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
                    else { return }

                    self.keyboardHeight.wrappedValue = keyboardRect.height

                }
            ).onReceive(
                NotificationCenter.default.publisher(
                    for: UIResponder.keyboardWillHideNotification),
                perform: { _ in
                    self.keyboardHeight.wrappedValue = 0
                })
    }
}

extension View {
    public func keyboardHeight(_ state: Binding<CGFloat>) -> some View {
        self.modifier(KeyboardProvider(keyboardHeight: state))
    }
}
