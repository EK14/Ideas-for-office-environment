//
//  SignInView.swift
//  Ideas-for-office-environment
//
//  Created by Elina Karapetian on 28.01.2024.
//

import SwiftUI

struct SignInView: View {
    @ObservedObject var viewModel: SignInViewModel = SignInViewModel()
    @State var emptyEmail = false
    @State var emptyPassword = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: Constants.Spacing.verticalStack) {
                Text(S.entry)
                    .font(.largeTitle)
                
                VStack(spacing: Constants.Spacing.verticalStack) {
                    VStack(alignment: .leading) {
                        HStack {
                            Image(systemName: S.envelope)
                                .foregroundColor(emptyEmail ? .red: .gray)
 
                            TextField("", text: $viewModel.email, prompt: Text(S.email).foregroundColor(emptyEmail ? .red: .gray))
                                .padding(.vertical, Constants.TextField.verticalPadding)
                        }
                        .padding(.leading, Constants.TextField.horizontalPadding)
                        .overlay(
                            RoundedRectangle(cornerRadius: Constants.TextField.radius)
                                .stroke(emptyEmail ? .red: .gray)
                                .padding(.horizontal, Constants.Padding.main)
                        )
                        
                        Text(S.emptyEmail)
                            .foregroundStyle(.red)
                            .font(.footnote)
                            .padding(.horizontal, Constants.Padding.main)
                            .opacity(emptyEmail ? 1: 0)
                    }
                    
                    VStack(alignment: .leading) {
                        HybridTextField(text: $viewModel.password, emptyField: $emptyPassword, titleKey: S.password)
                        
                        Text(S.emptyPassword)
                            .foregroundStyle(.red)
                            .font(.footnote)
                            .padding(.horizontal, Constants.Padding.main)
                            .opacity(emptyPassword ? 1: 0)
                    }
                }
                VStack(spacing: Constants.Spacing.verticalStack) {
                    Button(action: {
                        guard !viewModel.email.isEmpty else {
                            emptyEmail = true
                            guard !viewModel.password.isEmpty else {
                                emptyPassword = true
                                return
                            }
                            emptyPassword = false
                            return
                        }
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
