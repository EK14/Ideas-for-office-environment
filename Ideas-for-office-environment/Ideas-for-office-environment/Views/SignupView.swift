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
    
    var body: some View {
        VStack(spacing: 40) {
            Text("Регистрация")
                .font(.largeTitle)
            
            VStack(spacing: 30) {
                HStack {
                    Image(systemName: "envelope")
                        .padding(.leading, 40.0)
                        .foregroundColor(.gray)
                    TextField("Email", text: $email)
                        .padding(.vertical, 15)
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.gray)
                        .padding(.horizontal, 20)
                )
                
                HybridTextField(text: $password, titleKey: "Пароль")
                
                HybridTextField(text: $password, titleKey: "Повторите пароль")
            }
            VStack(spacing: 30) {
                Button(action: {
                    print("нажата кнопка войти")
                }, label: {
                    Text("Зарегистрироваться")
                        .foregroundStyle(.white)
                        .padding(.horizontal, 55)
                        .padding(.vertical, 15)
                        .background(.blue)
                        .clipShape(Capsule())
                })
                HStack {
                    Text("Есть аккаунт?")
                        .font(.callout)
                    Button(action: {
                        print("нажата кнопка зарегистрироваться")
                    }, label: {
                        Text("Войти")
                            .font(.callout)
                    })
                }
            }
        }
    }
}

#Preview {
    SignupView()
}
