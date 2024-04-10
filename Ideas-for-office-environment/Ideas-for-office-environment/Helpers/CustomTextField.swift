//
//  CustomTextField.swift
//  Ideas-for-office-environment
//
//  Created by Elina Karapetian on 10.03.2024.
//

import SwiftUI

struct CustomTextField: View {
    @Binding var text: String
    @Binding var empty: Bool
    @State var isSecure: Bool = true
    var lable: String
    var titleKey: String
    
    var body: some View {
        VStack(spacing: 5){
            Text(lable)
                .font(.caption)
                .foregroundStyle(empty ? .red: .gray)
                .frame(maxWidth: .infinity, alignment: .leading)
            TextField("", text: $text, prompt: Text(titleKey).foregroundColor(empty ? .red: .gray))
                .foregroundStyle(.black)
        }
        .padding(.bottom, 8)
        .padding(.top, 5)
        .padding(.leading, Constants.TextField.horizontalPadding)
        .overlay(
            RoundedRectangle(cornerRadius: Constants.TextField.radius)
                .stroke(empty ? .red: .gray)
                .padding(.horizontal, Constants.Padding.main)
        )
    }
}

#Preview {
    @State var text = ""
    @State var empty = true
    
    return CustomTextField(text: $text, empty: $empty, lable: "Имя", titleKey: "Ваше имя")
}
