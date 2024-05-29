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
    @ObservedObject var parentViewModel: HomeViewModel
    var coordinator: HomeCoordinator
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack(alignment: .leading, spacing: 10) {
                HStack(alignment: .top) {
                    HStack {
                        WebImage(url: URL(string: postInfo.ideaAuthor.photo))
                            .resizable()
                            .scaledToFill()
                            .frame(width: 60, height: 60)
                            .background(.gray)
                            .clipShape(Circle())
                        
                        VStack(alignment: .leading) {
                            Text("\(postInfo.ideaAuthor.name) \(postInfo.ideaAuthor.surname)")
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
                
                ExpandableText(postInfo.content, lineLimit: 5)
                    .padding(.horizontal, 20)
                
                if(postInfo.attachedImages.count > 0) {
                    TabView {
                        ForEach(postInfo.attachedImages.indices, id: \.self) { index in
                            WebImage(url: URL(string: postInfo.attachedImages[index] + "jpeg"))
                                .resizable()
                                .frame(width: UIScreen.main.bounds.width - 20, height: UIScreen.main.bounds.height / 3, alignment: .center)
                                .scaledToFill()
                                .cornerRadius(20)
                        }
                    }
                    .frame(height: UIScreen.main.bounds.height / 3)
                    .tabViewStyle(PageTabViewStyle())
                }
                
                HStack(spacing: 0) {
                    WebImage(url: URL(string: postInfo.office.imageUrl))
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
                        if !didLiked {
                            parentViewModel.setLike(postId: postInfo.id) {
                                likes += 1
                            }
                        } else {
                            parentViewModel.removeLike(postId: postInfo.id) {
                                likes -= 1
                            }
                        }
                        didLiked.toggle()
                        if didDisliked {
                            didDisliked = false
                            dislikes -= 1
                        }
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
                    .disabled((parentViewModel.isSettingLike) || (parentViewModel.isRemovingLike))
                    
                    Button {
                        if !didDisliked {
                            parentViewModel.setDislike(postId: postInfo.id) {
                                dislikes += 1
                            }
                        } else {
                            parentViewModel.removeDislike(postId: postInfo.id) {
                                dislikes -= 1
                            }
                        }
                        didDisliked.toggle()
                        if didLiked {
                            didLiked = false
                            likes -= 1
                        }
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
                    .disabled(parentViewModel.isSettingDislike || parentViewModel.isRemovingDislike)
                    
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
                    if(postInfo.ideaAuthor.id != parentViewModel.userId) {
                        Button {
                            dotsButtonDidTouched = false
                        } label: {
                            Text("Предложить идею моему\nофису")
                                .multilineTextAlignment(.leading)
                        }
                    }
                    
                    Button {
                        dotsButtonDidTouched = false
                    } label: {
                        Text("Перейти к автору")
                            .multilineTextAlignment(.leading)
                    }
                    
                    if(postInfo.ideaAuthor.id == parentViewModel.userId) {
                        Button {
                            coordinator.editPost(postId: postInfo.id)
                            dotsButtonDidTouched = false
                        } label: {
                            Text("Редактировать")
                                .multilineTextAlignment(.leading)
                        }
                        
                        Button {
                            parentViewModel.isDeletingPost = true
                            withAnimation(.easeInOut(duration: 0.5)) {
                                parentViewModel.deletePost(postId: postInfo.id)
                            }
                            dotsButtonDidTouched = false
                        } label: {
                            Text("Удалить")
                                .multilineTextAlignment(.leading)
                        }
                        .disabled(parentViewModel.isDeletingPost)
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
            didLiked = postInfo.isLikePressed
            dislikes = postInfo.dislikesCount
            didDisliked = postInfo.isDislikePressed
            date = dateFormatter(date: postInfo.date)
        }
//        .onDisappear {
//            parentViewModel.refresh {}
//        }
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
