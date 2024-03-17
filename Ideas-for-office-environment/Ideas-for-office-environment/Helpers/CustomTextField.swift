//
//  CustomTextField.swift
//  Ideas-for-office-environment
//
//  Created by Elina Karapetian on 10.03.2024.
//

import SwiftUI

struct CustomTextField: View {
    @Binding var text: String
    @State var isSecure: Bool = true
    var lable: String
    var titleKey: String
    
    var body: some View {
        VStack(spacing: 5){
            Text(lable)
                .font(.caption)
                .foregroundStyle(.gray)
                .frame(maxWidth: .infinity, alignment: .leading)
            TextField(titleKey, text: $text)
        }
        .padding(.bottom, 8)
        .padding(.top, 5)
        .padding(.leading, Constants.TextField.horizontalPadding)
        .overlay(
            RoundedRectangle(cornerRadius: Constants.TextField.radius)
                .stroke(Color.gray)
                .padding(.horizontal, Constants.Padding.main)
        )
    }
}

#Preview {
    @State var text = ""
    
    return CustomTextField(text: $text, lable: "Имя", titleKey: "Ваше имя")
}
