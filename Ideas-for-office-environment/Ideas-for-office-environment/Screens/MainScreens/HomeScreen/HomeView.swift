//
//  HomeView.swift
//  Ideas-for-office-environment
//
//  Created by Elina Karapetian on 20.03.2024.
//

import SwiftUI

enum Filter {
    case likes
    case dislikes
    case comments
}

struct HomeView: View {
    @ObservedObject var viewModel = HomeViewModel()
    @State var text: String = ""
    @State var showFilterView = false
    @State var posts = [PostView(userPhoto: Image(systemName: "person"), name: "Дмитрий Комарницкий", date: "1 Янв 2024 в 8:54", title: "Растительные вставки для стола", text: "Нас окружает живая природа. Она помогает человечеству выжить. К примеру, без растений мы не смогли бы прожить и дня.Они дарят нам кислород, из них мы не смогли б прожить и дня. Также растения незаменимы для производства лекарств. Многие растения могут излечить даже самых больных людей. Я очень люблю изучать специальную литературу, в которой рассказывается о пользе растений.", photo: ["Idea", "Idea"], address: "ул. Большая Печерская, 5/9", addressPhoto: Image("Office_1"), likes: "1.1к", dislikes: "101", comments: "342"),
        PostView(userPhoto: Image(systemName: "person"), name: "Дмитрий Комарницкий", date: "1 Янв 2024 в 8:54", title: "Растительные вставки для стола", text: "Нас окружает живая природа. Она помогает человечеству выжить. К примеру, без растений мы не смогли бы прожить и дня.Они дарят нам кислород, из них мы не смогли б прожить и дня. Также растения незаменимы для производства лекарств. Многие растения могут излечить даже самых больных людей. Я очень люблю изучать специальную литературу, в которой рассказывается о пользе растений.", photo: ["Idea", "Idea", "Idea"], address: "ул. Большая Печерская, 5/9", addressPhoto: Image("Office_1"), likes: "1.1к", dislikes: "101", comments: "342")]
    var coordinator: HomeCoordinator
    
    var body: some View {
        ZStack {
            ScrollView {
                
                VStack {
                    SearchableCustom(searchtxt: $text, showFilterView: $showFilterView, coordinator: coordinator)
                    
                    ZStack {
                        Color("gray")
                        
                        VStack(spacing: 40) {
                            ForEach(0..<posts.count) { i in
                                posts[i]
                                    .background(.white)
                                    .cornerRadius(20)
                            }
                        }
                        .padding(.vertical, 20)
                    }
                    .ignoresSafeArea(edges: .bottom)
                }
            }
            
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
        .onAppear {
            viewModel.getPosts {
                print("done")
            }
        }
    }
}

struct SearchableCustom: View {
    
    @State private var sheetHeight: CGFloat = .zero
    @State var filter = Filter.comments
    @Binding var searchtxt: String
    @Binding var showFilterView: Bool
    @FocusState private var isSearchFocused: Bool // Track focus state
    var coordinator: HomeCoordinator
    
    var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(.gray)
                TextField("Search", text: $searchtxt)
                    .focused($isSearchFocused) // Track focus state
                    .padding(.horizontal, 10)
                    .padding(.vertical, 8)
            }
            .padding(.horizontal)
            .background(Color(.secondarySystemBackground))
            .cornerRadius(10)
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 0.5))
            
            if isSearchFocused {
                Button("Cancel") {
                    searchtxt = ""
                    withAnimation(.easeInOut(duration: 1)) {
                        isSearchFocused = false
                    }
                }
                .transition(.move(edge: .trailing).combined(with: .opacity))
                .animation(.easeInOut(duration: 1), value: isSearchFocused)
            } else {
                Button {
                    coordinator.addFilters()
                } label: {
                    Text("Filter")
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal)
        .padding(.bottom, 10)
    }
}

struct InnerHeightPreferenceKey: PreferenceKey {
    static let defaultValue: CGFloat = .zero
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

#Preview {
    var coordinator = HomeCoordinator()
    return HomeView(coordinator: coordinator)
}
