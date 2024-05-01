//
//  HomeView.swift
//  Ideas-for-office-environment
//
//  Created by Elina Karapetian on 20.03.2024.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel = HomeViewModel()
    @State var text: String = ""
    @State var posts = [PostView(userPhoto: Image(systemName: "person"), name: "Дмитрий Комарницкий", date: "1 Янв 2024 в 8:54", title: "Растительные вставки для стола", text: "Нас окружает живая природа. Она помогает человечеству выжить. К примеру, без растений мы не смогли бы прожить и дня.Они дарят нам кислород, из них мы не смогли б прожить и дня. Также растения незаменимы для производства лекарств. Многие растения могут излечить даже самых больных людей. Я очень люблю изучать специальную литературу, в которой рассказывается о пользе растений.", photo: "Idea", address: "ул. Большая Печерская, 5/9", addressPhoto: Image("Office_1"), likes: "1.1к", dislikes: "101", comments: "342"),
        PostView(userPhoto: Image(systemName: "person"), name: "Дмитрий Комарницкий", date: "1 Янв 2024 в 8:54", title: "Растительные вставки для стола", text: "Нас окружает живая природа. Она помогает человечеству выжить. К примеру, без растений мы не смогли бы прожить и дня.Они дарят нам кислород, из них мы не смогли б прожить и дня. Также растения незаменимы для производства лекарств. Многие растения могут излечить даже самых больных людей. Я очень люблю изучать специальную литературу, в которой рассказывается о пользе растений.", photo: "Idea", address: "ул. Большая Печерская, 5/9", addressPhoto: Image("Office_1"), likes: "1.1к", dislikes: "101", comments: "342")]
    var coordinator: HomeCoordinator
    
    var body: some View {
        ZStack {
            ScrollView {
                ZStack {
                    Color("gray")
                    
                    VStack(spacing: 40) {
                        ForEach(0..<posts.count) { i in
                            posts[i]
                                .background(.white)
                                .cornerRadius(20)
                        }
                    }
                    .padding(.top, 20)
                }
            }
            .searchable(text: $text, placement: .navigationBarDrawer(displayMode: .always), prompt: "Поиск по идеям")
            
            VStack {
                Spacer()
                
                HStack {
                    
                    Spacer()
                    
                    Button {
                        coordinator.createNewIdea()
                    } label: {
                        Image(systemName: "pencil")
                            .imageScale(.large)
                            .frame(width: 50, height: 50)
                            .background(.blue)
                            .cornerRadius(10)
                            .foregroundStyle(.black)
                    }
                }
                .padding(.trailing, 10)
                .padding(.bottom, 10)
            }
        }
    }
}

#Preview {
    var coordinator = HomeCoordinator()
    return HomeView(coordinator: coordinator)
}
