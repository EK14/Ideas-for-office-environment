//
//  CommentView.swift
//  Ideas-for-office-environment
//
//  Created by Elina Karapetian on 27.03.2024.
//

import SwiftUI

struct CommentView: View {
    @State var userPhoto: Image
    @State var name: String
    @State var date: String
    @State var text: String
    @State var didLiked = false
    @State var didDisliked = false
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            userPhoto
                .frame(width: 60, height: 60)
                .background(.gray)
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 8) {
                Text(name)
                    .font(.system(size: 12))
                Text(text)
                    .font(.system(size: 14))
                
                HStack {
                    Text(date)
                        .font(.system(size: 10))
                    
                    Spacer()
                    
                    HStack {
                        Button {
                            didLiked.toggle()
                            didDisliked = false
                        } label: {
                            HStack(spacing: 5) {
                                Image(systemName: "hand.thumbsup")
                                    .font(.system(size: 14))
                                Text("1.1k")
                                    .font(.system(size: 14))
                            }
                            .padding(.horizontal, 8)
                            .padding(.vertical, 2.5)
                            .if(didLiked, transform: { view in
                                view
                                    .foregroundStyle(.green)
                            })
                            .foregroundStyle(.black)
                            .clipShape(Capsule())
                        }
                        
                        Button {
                            didDisliked.toggle()
                            didLiked = false
                        } label: {
                            HStack(spacing: 5) {
                                Image(systemName: "hand.thumbsdown")
                                    .font(.system(size: 14))
                                Text("1.1k")
                                    .font(.system(size: 14))
                            }
                            .padding(.horizontal, 8)
                            .padding(.vertical, 2.5)
                            .if(didDisliked, transform: { view in
                                view
                                    .foregroundStyle(.red)
                            })
                            .foregroundStyle(.black)
                            .clipShape(Capsule())
                        }
                    }
                }
            }
        }
        .padding(.horizontal, 10)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    CommentView(userPhoto: Image(systemName: "person"),
                name: "Дмитрий Комарницкий", 
                date: "1 Янв 2024 в 8:54",
                text: "Ну да, Ну да")
}
