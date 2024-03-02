//
//  View+Extensions.swift
//  Ideas-for-office-environment
//
//  Created by Elina Karapetian on 03.03.2024.
//

import SwiftUI

extension View {
    func hideKeyboard() {
        let resign = #selector(UIResponder.resignFirstResponder)
        UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
    }
}
