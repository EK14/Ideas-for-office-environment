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
                Text(date)
                    .font(.system(size: 10))
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
