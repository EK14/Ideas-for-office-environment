//
//  SignInView.swift
//  Ideas-for-office-environment
//
//  Created by Elina Karapetian on 28.01.2024.
//

import SwiftUI

struct SignInView: View {
    @ObservedObject var viewModel: SignInViewModel = SignInViewModel()
//    var signIn: () -> ()
    
    var body: some View {
        NavigationView {
            VStack(spacing: Constants.Spacing.verticalStack) {
                Text(S.entry)
                    .font(.largeTitle)
                
                VStack(spacing: Constants.Spacing.verticalStack) {
                    HStack {
                        Image(systemName: S.envelope)
                            .foregroundColor(.gray)
                        TextField(S.email, text: $viewModel.email)
                            .padding(.vertical, Constants.TextField.verticalPadding)
                    }
                    .padding(.leading, Constants.TextField.horizontalPadding)
                    .overlay(
                        RoundedRectangle(cornerRadius: Constants.TextField.radius)
                            .stroke(Color.gray)
                            .padding(.horizontal, Constants.Padding.main)
                    )
                    HybridTextField(text: $viewModel.password, titleKey: S.password)
                }
                VStack(spacing: Constants.Spacing.verticalStack) {
                    Button(action: {
                        viewModel.signIn()
                    }, label: {
                        Text(S.signin)
                            .foregroundStyle(.white)
                            .padding(.horizontal, Constants.Button.Padding.horizontal)
                            .padding(.vertical, Constants.Button.Padding.vertical)
                            .background(.blue)
                            .clipShape(Capsule())
                    })
                    
                    HStack {
                        Text(S.notHaveAccount)
                            .font(.callout)
                        NavigationLink {
                            SignUpView()
                        } label: {
                            Text(S.signup)
                                .font(.callout)
                        }
                    }
                }
            }
            .navigationBarHidden(true)
            .contentShape(Rectangle())
            .onTapGesture {
                hideKeyboard()
            }
        }
    }
}

#Preview {
    SignInView()
}
