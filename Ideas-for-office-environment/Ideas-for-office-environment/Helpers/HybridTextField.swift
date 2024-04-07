//
//  HybridTextField.swift
//  Ideas-for-office-environment
//
//  Created by Elina Karapetian on 02.03.2024.
//

import SwiftUI

struct HybridTextField: View {
    @Binding var text: String
    @Binding var emptyField: Bool
    @State var isSecure: Bool = true
    var titleKey: String
    
    var body: some View {
        HStack{
            Image(systemName: S.lock)
                .foregroundColor(emptyField ? .red: .gray)
            Group{
                if isSecure{
                    SecureField(titleKey, text: $text, prompt: Text(titleKey).foregroundColor(emptyField ? .red: .gray))
                }else{
                    TextField("", text: $text, prompt: Text(titleKey).foregroundColor(emptyField ? .red: .gray))
                }
            }
            .animation(.easeInOut(duration: Constants.Duration.fast), value: isSecure)
            .padding(.vertical, Constants.TextField.verticalPadding)

            Button(action: {
                isSecure.toggle()
            }, label: {
                Image(systemName: !isSecure ? S.Eye.slash : S.eye )
                    .foregroundColor(emptyField ? .red: .gray)
            })
            .padding(.trailing, Constants.TextField.horizontalPadding)
        }
        .padding(.leading, Constants.TextField.horizontalPadding)
        .overlay(
            RoundedRectangle(cornerRadius: Constants.TextField.radius)
                .stroke(emptyField ? .red: .gray)
                .padding(.horizontal, Constants.Padding.main)
        )
    }
}


#Preview {
    @State var text = ""
    @State var emptyField = false
    
    return HybridTextField(text: $text, emptyField: $emptyField, titleKey: "Preview placeholder")
}
