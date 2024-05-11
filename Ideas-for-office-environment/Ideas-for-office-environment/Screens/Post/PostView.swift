//
//  PostView.swift
//  Ideas-for-office-environment
//
//  Created by Elina Karapetian on 20.03.2024.
//

import SwiftUI
import SDWebImageSwiftUI

struct PostView: View {
    @State var dotsButtonDidTouched = false
    @State var didLiked = false
    @State var didDisliked = false
    @State var likes = 0
    @State var dislikes = 0
    @State var date = ""
    var postInfo: IdeaPostResponse
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack(alignment: .leading, spacing: 10) {
                HStack(alignment: .top) {
                    HStack {
                        AnimatedImage(url: URL(string: postInfo.ideaAuthor.photo))
                            .resizable()
                            .scaledToFill()
                            .frame(width: 60, height: 60)
                            .background(.gray)
                            .clipShape(Circle())
                        
                        VStack(alignment: .leading) {
                            Text(postInfo.ideaAuthor.name)
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
                
                Text(postInfo.title)
                    .font(.title3.bold())
                    .padding(.vertical, 10)
                    .padding(.horizontal, 20)
                
                Text(postInfo.content)
                    .lineLimit(5)
                    .padding(.horizontal, 20)
                
                if(postInfo.attachedImages.count > 0) {
                    TabView {
                        ForEach(postInfo.attachedImages.indices, id: \.self) { index in
                            AnimatedImage(url: URL(string: postInfo.attachedImages[index]))
                                .resizable()
                                .frame(height: UIScreen.main.bounds.height / 3)
                                .scaledToFill()
                                .cornerRadius(20)
                                .padding(.horizontal, 10)
                        }
                    }
                    .frame(height: UIScreen.main.bounds.height / 3)
                    .tabViewStyle(PageTabViewStyle())
                }
                
                HStack(spacing: 0) {
                    AnimatedImage(url: URL(string: postInfo.office.imageUrl))
                        .resizable()
                        .frame(width: 50, height: 50)
                        .background(.gray)
                        .clipShape(Circle())
                    
                    Text(postInfo.office.address)
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
                        likes = likes == postInfo.likesCount ? postInfo.likesCount + 1: postInfo.likesCount
                        dislikes = postInfo.dislikesCount
                    } label: {
                        HStack {
                            Image(systemName: "hand.thumbsup")
                            Text("\(likes)")
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
                        dislikes = dislikes == postInfo.dislikesCount ? postInfo.dislikesCount + 1: postInfo.dislikesCount
                        likes = postInfo.likesCount
                    } label: {
                        HStack {
                            Image(systemName: "hand.thumbsdown")
                            Text("\(dislikes)")
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
                            Text("\(postInfo.commentsCount)")
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
        .onAppear {
            likes = postInfo.likesCount
            dislikes = postInfo.dislikesCount
            date = dateFormatter(date: postInfo.date)
        }
    }
    
    func dateFormatter(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU") // устанавливаем локаль для корректного парсинга даты
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ" // устанавливаем формат исходной даты
        if let date = dateFormatter.date(from: date) {
            dateFormatter.dateFormat = "d MMMM yyyy 'в' HH:mm" // устанавливаем формат целевой даты
            let formattedDate = dateFormatter.string(from: date)
            return formattedDate // выводим отформатированную дату
        }
        return ""
    }
}
