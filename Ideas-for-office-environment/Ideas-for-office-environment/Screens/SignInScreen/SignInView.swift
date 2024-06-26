//
//  SignInView.swift
//  Ideas-for-office-environment
//
//  Created by Elina Karapetian on 28.01.2024.
//

import SwiftUI

struct SignInView: View {
    @ObservedObject var viewModel: SignInViewModel = SignInViewModel()
    var coordinator: SignInCoordinator
    @State var emptyEmail = false
    @State var emptyPassword = false
    @State var isKeyboardVisible = false
    
    var body: some View {
        ZStack {
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
                        
                        if emptyEmail {
                            Text(S.emptyEmail)
                                .foregroundStyle(.red)
                                .font(.footnote)
                                .padding(.horizontal, Constants.Padding.main)
                        }
                    }
                    
                    VStack(alignment: .leading) {
                        HybridTextField(text: $viewModel.password, emptyField: $emptyPassword, titleKey: S.password)
                        
                        if emptyPassword {
                            Text(S.emptyPassword)
                                .foregroundStyle(.red)
                                .font(.footnote)
                                .padding(.horizontal, Constants.Padding.main)
                        }
                    }
                }
                VStack(spacing: Constants.Spacing.verticalStack) {
                    Button(action: {
                        emptyEmail = viewModel.email.isEmpty
                        emptyPassword = viewModel.password.isEmpty
                        
                        if !emptyEmail && !emptyPassword {
                            hideKeyboard()
                            viewModel.signIn {
                                viewModel.isLoading = false
                            }
                        }
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
                        Button(action: {
                            coordinator.navigateToSignUp()
                        }) {
                            Text(S.signup)
                                .font(.callout)
                        }
                    }
                }
            }
            .navigationBarHidden(true)
            .contentShape(Rectangle())
            .alert(S.wrongUser, isPresented: $viewModel.wrongUser) {
                Button(S.ok, role: .cancel) {
                    viewModel.wrongUser = false
                }
            }
            
            if viewModel.isLoading {
                LoadingView()
            }
        }
    }
}

#Preview {
    var coordinator = SignInCoordinator()
    
    return SignInView(coordinator: coordinator)
}
