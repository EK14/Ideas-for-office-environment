//
//  HybridTextField.swift
//  Ideas-for-office-environment
//
//  Created by Elina Karapetian on 02.03.2024.
//

import SwiftUI

struct HybridTextField: View {
    @Binding var text: String
    @State var isSecure: Bool = true
    var titleKey: String
    
    var body: some View {
        HStack{
            Image(systemName: S.lock)
                .foregroundColor(.gray)
            Group{
                if isSecure{
                    SecureField(titleKey, text: $text)
                    
                }else{
                    TextField(titleKey, text: $text)
                }
            }
            .animation(.easeInOut(duration: Constants.Duration.fast), value: isSecure)
            .padding(.vertical, Constants.TextField.verticalPadding)

            Button(action: {
                isSecure.toggle()
            }, label: {
                Image(systemName: !isSecure ? S.Eye.slash : S.eye )
            })
            .padding(.trailing, Constants.TextField.horizontalPadding)
        }
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
    
    return HybridTextField(text: $text, titleKey: "Preview placeholder")
}
