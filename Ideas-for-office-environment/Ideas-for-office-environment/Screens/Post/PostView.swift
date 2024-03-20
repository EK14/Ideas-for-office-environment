//
//  PostView.swift
//  Ideas-for-office-environment
//
//  Created by Elina Karapetian on 20.03.2024.
//

import SwiftUI

struct PostView: View {
    @State var userPhoto: Image
    @State var name: String
    @State var date: String
    @State var title: String
    @State var text: String
    @State var photo: String
    @State var address: String
    @State var addressPhoto: Image
    @State var likes: String
    @State var dislikes: String
    @State var comments: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .top) {
                HStack {
                    userPhoto
                        .frame(width: 60, height: 60)
                        .background(.gray)
                        .clipShape(Circle())
                    
                    VStack(alignment: .leading) {
                        Text(name)
                        Text(date)
                            .font(.caption)
                    }
                }
                
                Spacer()
                
                Image("dots")
                    .padding(.vertical, 5)
            }
            .padding(.horizontal, 20)
            
            Text(title)
                .font(.title3.bold())
                .padding(.vertical, 10)
                .padding(.horizontal, 20)
            
            Text(text)
                .lineLimit(5)
                .padding(.horizontal, 20)
            
            Image(photo)
                .resizable()
                .scaledToFit()
                .cornerRadius(20)
                .padding(.horizontal, 10)
            
            HStack(spacing: 0) {
                addressPhoto
                    .resizable()
                    .frame(width: 50, height: 50)
                    .background(.gray)
                    .clipShape(Circle())
                
                Text(address)
                    .padding(.horizontal, 20)
            }
            .background(.blue.opacity(0.2))
            .cornerRadius(25)
            .overlay(
                RoundedRectangle(cornerRadius: 25)
                    .stroke(.blue, lineWidth: 1)
            )
            .padding(.horizontal, 20)
            
            HStack {
                HStack {
                    Image(systemName: "hand.thumbsup")
                    Text(likes)
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .background(.gray.opacity(0.2))
                .clipShape(Capsule())
                
                HStack {
                    Image(systemName: "hand.thumbsdown")
                    Text(dislikes)
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .background(.red.opacity(0.2))
                .clipShape(Capsule())
                
                HStack {
                    Image(systemName: "message")
                    Text(comments)
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .background(.gray.opacity(0.2))
                .clipShape(Capsule())
            }
            .padding(.horizontal, 20)
        }
        .padding(.vertical, 10)
        .cornerRadius(20)
    }
}

#Preview {
    PostView(userPhoto: Image(systemName: "person"), name: "Дмитрий Комарницкий", date: "1 Янв 2024 в 8:54", title: "Растительные вставки для стола", text: "Нас окружает живая природа. Она помогает человечеству выжить. К примеру, без растений мы не смогли бы прожить и дня.Они дарят нам кислород, из них мы не смогли б прожить и дня. Также растения незаменимы для производства лекарств. Многие растения могут излечить даже самых больных людей. Я очень люблю изучать специальную литературу, в которой рассказывается о пользе растений.", photo: "Idea", address: "ул. Большая Печерская, 5/9", addressPhoto: Image("Office_1"), likes: "1.1к", dislikes: "101", comments: "342")
}
