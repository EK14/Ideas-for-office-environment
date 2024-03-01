//
//  SigninView.swift
//  Ideas-for-office-environment
//
//  Created by Elina Karapetian on 28.01.2024.
//

import SwiftUI

struct SigninView: View {
    @State var email: String = ""
    @State var password: String = ""
    
    var body: some View {
        VStack(spacing: 40) {
            Text("Вход")
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
            }
            VStack(spacing: 30) {
                Button(action: {
                    print("нажата кнопка войти")
                }, label: {
                    Text("Войти")
                        .foregroundStyle(.white)
                        .padding(.horizontal, 55)
                        .padding(.vertical, 15)
                        .background(.blue)
                        .clipShape(Capsule())
                })
                HStack {
                    Text("Нет аккаунта?")
                        .font(.callout)
                    Button(action: {
                        print("нажата кнопка зарегистрироваться")
                    }, label: {
                        Text("Зарегистрироваться")
                            .font(.callout)
                    })
                }
            }
        }
    }
}

struct HybridTextField: View {
    @Binding var text: String
    @State var isSecure: Bool = true
    var titleKey: String
    
    var body: some View {
        HStack{
            Image(systemName: "lock")
                .padding(.leading, 40.0)
                .foregroundColor(.gray)
            Group{
                if isSecure{
                    SecureField(titleKey, text: $text)
                    
                }else{
                    TextField(titleKey, text: $text)
                }
            }
            .animation(.easeInOut(duration: 0.2), value: isSecure)
            .padding(.vertical, 15)

            Button(action: {
                isSecure.toggle()
            }, label: {
                Image(systemName: !isSecure ? "eye.slash" : "eye" )
            })
            .padding(.trailing, 40.0)
        }
        .overlay(
            RoundedRectangle(cornerRadius: 5)
                .stroke(Color.gray)
                .padding(.horizontal, 20)
        )
    }
}

#Preview {
    SigninView()
}
