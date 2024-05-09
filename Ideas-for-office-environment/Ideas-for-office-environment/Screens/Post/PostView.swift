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
    @State var photo: [String]
    @State var address: String
    @State var addressPhoto: Image
    @State var likes: String
    @State var dislikes: String
    @State var comments: String
    @State var dotsButtonDidTouched = false
    @State var didLiked = false
    @State var didDisliked = false
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
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
                    
                    Button {
                        dotsButtonDidTouched = true
                    } label: {
                        Image("dots")
                            .padding(.vertical, 5)
                    }
                }
                .padding(.horizontal, 20)
                
                Text(title)
                    .font(.title3.bold())
                    .padding(.vertical, 10)
                    .padding(.horizontal, 20)
                
                Text(text)
                    .lineLimit(5)
                    .padding(.horizontal, 20)
                
                TabView {
                    ForEach(0..<photo.count) { i in
                        Image(photo[i])
                            .resizable()
                            .frame(height: UIScreen.main.bounds.height / 3)
                            .scaledToFill()
                            .cornerRadius(20)
                            .padding(.horizontal, 10)
                    }
                }
                .frame(height: UIScreen.main.bounds.height / 3)

                .tabViewStyle(PageTabViewStyle())
                
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
                    Button {
                        didLiked.toggle()
                        didDisliked = false
                    } label: {
                        HStack {
                            Image(systemName: "hand.thumbsup")
                            Text(likes)
                        }
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .if(didLiked, transform: { view in
                            view
                                .background(.green.opacity(0.2))
                        })
                        .background(.gray.opacity(0.2))
                        .clipShape(Capsule())
                    }
                    
                    Button {
                        didDisliked.toggle()
                        didLiked = false
                    } label: {
                        HStack {
                            Image(systemName: "hand.thumbsdown")
                            Text(dislikes)
                        }
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .if(didDisliked, transform: { view in
                            view
                                .background(.red.opacity(0.2))
                        })
                        .background(.gray.opacity(0.2))
                        .clipShape(Capsule())
                    }
                    
                    Button {
                        
                    } label: {
                        HStack {
                            Image(systemName: "message")
                            Text(comments)
                        }
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(.gray.opacity(0.2))
                        .clipShape(Capsule())
                    }
                }
                .foregroundStyle(.black)
                .padding(.horizontal, 20)
            }
            .padding(.vertical, 10)
            .cornerRadius(20)
            .onTapGesture {
                dotsButtonDidTouched = false
            }
            
            if (dotsButtonDidTouched) {
                VStack(alignment: .leading, spacing: 16) {
                    Button {
                        
                    } label: {
                        Text("Предложить идею моему\nофису")
                            .multilineTextAlignment(.leading)
                    }
                    
                    Button {
                        
                    } label: {
                        Text("Перейти к автору")
                            .multilineTextAlignment(.leading)
                    }
                    
                    Button {
                        
                    } label: {
                        Text("Редактировать")
                            .multilineTextAlignment(.leading)
                    }
                    
                    Button {
                        
                    } label: {
                        Text("Удалить")
                            .multilineTextAlignment(.leading)
                    }
                }
                .foregroundStyle(.black)
                .padding()
                .background(.white)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.gray, lineWidth: 0.5)
                )
                .shadow(radius: 8)
                .padding(.horizontal, 20)
                .padding(.top, 10)
            }
        }
    }
}

#Preview {
    PostView(userPhoto: Image(systemName: "person"), name: "Дмитрий Комарницкий", date: "1 Янв 2024 в 8:54", title: "Растительные вставки для стола", text: "Нас окружает живая природа. Она помогает человечеству выжить. К примеру, без растений мы не смогли бы прожить и дня.Они дарят нам кислород, из них мы не смогли б прожить и дня. Также растения незаменимы для производства лекарств. Многие растения могут излечить даже самых больных людей. Я очень люблю изучать специальную литературу, в которой рассказывается о пользе растений.", photo: ["Idea", "Idea"], address: "ул. Большая Печерская, 5/9", addressPhoto: Image("Office_1"), likes: "1.1к", dislikes: "101", comments: "342")
}
