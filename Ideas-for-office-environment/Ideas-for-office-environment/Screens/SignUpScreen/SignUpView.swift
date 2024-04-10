//
//  SignUpView.swift
//  Ideas-for-office-environment
//
//  Created by Elina Karapetian on 01.03.2024.
//

import SwiftUI

struct SignUpView: View, KeyboardReadable {
    @ObservedObject var viewModel = SignUpViewModel()
    var coordinator: SignUpCoordinator
    @State var isKeyboardVisible = false
    @State var emptyEmail = false
    @State var emptyPassword = false
    @State var emptyPasswordRepeat = false
    @State var wrongPassword: Bool = false
    
    var body: some View {
        VStack(spacing: Constants.Spacing.verticalStack) {
            Text(S.registration)
                .font(.largeTitle)
                .transition(.scale)
            
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

                VStack(alignment: .leading) {
                    HybridTextField(text: $viewModel.passwordRepeate, emptyField: $emptyPasswordRepeat, titleKey: S.repeatPassword)
                    
                }
            }
            VStack(spacing: Constants.Spacing.verticalStack) {
                Button {
                    emptyEmail = viewModel.email.isEmpty
                    emptyPassword = viewModel.password.isEmpty
                    wrongPassword = viewModel.password != viewModel.passwordRepeate
                    viewModel.checkEmailValidation() { 
                        if !emptyEmail && !emptyPassword && !viewModel.emailNotValid && !wrongPassword {
                                coordinator.navigateToSignUpNextView(viewModel: viewModel)
                        }
                    }
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
                        coordinator.navigateToSignInView()
                    }, label: {
                        Text(S.signin)
                            .font(.callout)
                    })
                }
            }
        }
        .contentShape(Rectangle())
        .onReceive(keyboardPublisher) { isKeyboardVisible in
            withAnimation {
                self.isKeyboardVisible = isKeyboardVisible
            }
        }
        .navigationBarHidden(true)
        .navigationTitle(S.registration)
        .alert(S.wrongPassword, isPresented: $wrongPassword) {
            Button(S.ok, role: .cancel) {}
        }
        .alert(S.emailNotValid, isPresented: $viewModel.emailNotValid) {
            Button(S.ok, role: .cancel) {}
        }
    }
}

#Preview {
    var nav = UINavigationController()
    var coordinator = SignUpCoordinator(navigationController: nav)
    
    return SignUpView(coordinator: coordinator)
}
