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
    @ObservedObject var viewModel: HomeViewModel
    @State var showFilterView = false
    var coordinator: HomeCoordinator

    var body: some View {
        ZStack {
            ScrollView {
                LazyVStack {
                    SearchableCustom(searchtxt: $viewModel.searchText, showFilterView: $showFilterView, coordinator: coordinator)
                        .background(.white)

                    if(viewModel.posts.count > 0) {
                        ZStack {
                            Color("gray")

                            LazyVStack(spacing: 40) {
                                ForEach(viewModel.posts, id: \.id) { post in
                                    PostView(postInfo: post, parentViewModel: viewModel, coordinator: coordinator)
                                        .background(.white)
                                        .cornerRadius(20)
                                        .onAppear {
                                            viewModel.loadMoreContent(currentPost: post)
                                        }
                                        .transition(.move(edge: .trailing))

                                }
                            }
                            .padding(.vertical, 20)
                        }
                        .ignoresSafeArea(edges: .bottom)
                    }
                    
                    if viewModel.didReachedLastPost {
                        LoadingView()
                    }
                }
            }
            .refreshable {
                viewModel.refresh() {}
            }

            if(viewModel.posts.count == 0) {
                Text("Лента идей пуста")
                    .frame(maxWidth: .infinity, alignment: .center)
                    .foregroundStyle(.gray)
            }

            VStack {
                Spacer()

                HStack {
                    Spacer()

                    Button {
                        withAnimation {
                            coordinator.createNewIdea()
                        }
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

            if(viewModel.isLoading) {
                LoadingView()
            }
        }
        .onAppear {
            viewModel.posts = []
            viewModel.page = 0
            viewModel.getUserInfo {
                viewModel.page += 1
                viewModel.getPosts {}
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
