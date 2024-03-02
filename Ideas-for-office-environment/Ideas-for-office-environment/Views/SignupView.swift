//
//  SignupView.swift
//  Ideas-for-office-environment
//
//  Created by Elina Karapetian on 01.03.2024.
//

import SwiftUI

struct SignupView: View {
    @State var email: String = ""
    @State var password: String = ""
    @State var passwordRepete: String = ""
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(spacing: Constants.Spacing.verticalStack) {
            Text(S.registration)
                .font(.largeTitle)
            
            VStack(spacing: Constants.Spacing.verticalStack) {
                HStack {
                    Image(systemName: S.envelope)
                        .foregroundColor(.gray)
                    TextField(S.email, text: $email)
                        .padding(.vertical, Constants.TextField.verticalPadding)
                }
                .padding(.leading, Constants.TextField.horizontalPadding)
                .overlay(
                    RoundedRectangle(cornerRadius: Constants.TextField.radius)
                        .stroke(Color.gray)
                        .padding(.horizontal, Constants.Padding.main)
                )
                
                HybridTextField(text: $password, titleKey: S.password)
                
                HybridTextField(text: $passwordRepete, titleKey: S.repeatPassword)
            }
            VStack(spacing: Constants.Spacing.verticalStack) {
                NavigationLink {
                    Text(S.signup)
                } label: {
                    Text(S.signup)
                        .foregroundStyle(.white)
                        .padding(.horizontal, Constants.Button.Padding.horizontal)
                        .padding(.vertical, Constants.Button.Padding.vertical)
                        .background(.blue)
                        .clipShape(Capsule())
                }
                HStack {
                    Text(S.haveAccount)
                        .font(.callout)
                    
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Text(S.signin)
                            .font(.callout)
                    })
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    SignupView()
}
