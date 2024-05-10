//
//  FilterView.swift
//  Ideas-for-office-environment
//
//  Created by Elina Karapetian on 09.05.2024.
//

import SwiftUI
import SDWebImageSwiftUI

struct test {
    let id: Int
    let photo: String
    let address: String
}

enum Sort {
    case likes
    case dislikes
    case comments
    case none
}

struct FilterView: View {
    @State var isSelestedOffice: [Int] = []
    @State var state = Sort.none
    @ObservedObject var viewModel = FilterViewModel()
    var coordinator: FilterCoordinator
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Офисы")
                        .foregroundStyle(.gray)
                        .padding(.leading, 40)
                        .font(.system(size: 18).bold())
                    
                    ForEach(viewModel.offices.indices, id: \.self) { index in
                        HStack(spacing: 0) {
                            AnimatedImage(url: URL(string: viewModel.offices[index].imageUrl))
                                .resizable()
                                .frame(width: 100, height: 100)
                                .scaledToFill()
                            
                            Text(viewModel.offices[index].address)
                                .font(.system(size: 16))
                                .padding(.leading, 20)
                            
                            Spacer()
                            
                            HStack {
                                Color.clear
                                    .frame(width: 20, height: 20)
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 2)
                                            .stroke(lineWidth: 1)
                                    }
                                    .if(isSelestedOffice.contains(index+1)) { view in
                                        view
                                            .background(.blue)
                                            .cornerRadius(2)
                                            .overlay {
                                                Image(systemName: "checkmark")
                                                    .foregroundStyle(.white)
                                            }
                                    }
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.trailing, 21)
                        .background(isSelestedOffice.contains(index+1) ? .blue.opacity(0.3): .gray.opacity(0.3))
                        .cornerRadius(10)
                        .overlay {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(lineWidth: 1)
                                .foregroundStyle(isSelestedOffice.contains(index+1) ? .blue.opacity(0.3): .gray.opacity(0.3))
                        }
                        .padding(.horizontal, 20)
                        .onTapGesture {
                            if isSelestedOffice.contains(index+1) {
                                if let index = isSelestedOffice.firstIndex(where: { $0 == index + 1 }) {
                                    isSelestedOffice.remove(at: index)
                                }
                            } else {
                                isSelestedOffice.append(index+1)
                            }
                        }
                    }
                    
                    Text("Сортировать по")
                        .foregroundStyle(.gray)
                        .padding(.leading, 40)
                        .font(.system(size: 18).bold())
                    
                    HStack {
                        Button {
                            withAnimation {
                                state = .likes
                            }
                        } label: {
                            Text("Лайкам")
                        }
                        .padding(.vertical, 10)
                        .border(width:3, edges: [.top], color: state == .likes ? .blue: .clear)
                        .foregroundStyle(state == .likes ? .blue: .gray)
                        
                        Spacer()
                        
                        Button {
                            withAnimation {
                                state = .dislikes
                            }
                        } label: {
                            Text("Дизлайкам")
                        }
                        .padding(.vertical, 10)
                        .border(width:3, edges: [.top], color: state == .dislikes ? .blue: .clear)
                        .foregroundStyle(state == .dislikes ? .blue: .gray)
                        
                        Spacer()
                        
                        Button {
                            withAnimation {
                                state = .comments
                            }
                        } label: {
                            Text("Комментируемости")
                        }
                        .padding(.vertical, 10)
                        .border(width:3, edges: [.top], color: state == .comments ? .blue: .clear)
                        .foregroundStyle(state == .comments ? .blue: .gray)
                    }
                    .padding(.horizontal, 20)
                    .overlay {
                        Rectangle()
                            .stroke(lineWidth: 0.5)
                    }
                    
                    VStack(alignment: .center) {
                        Button {
                            coordinator.applyFilters()
                        } label: {
                            Text("Показать")
                                .foregroundStyle(.white)
                                .padding(.horizontal, Constants.Button.Padding.horizontal)
                                .padding(.vertical, Constants.Button.Padding.vertical)
                                .frame(maxWidth: .infinity)
                                .background(.blue)
                                .clipShape(Capsule())
                                .padding(.horizontal, 20)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    
                }
                .padding(.bottom, 20)
            }
            
            if(viewModel.isLoading) {
                LoadingView()
            }
        }
        .onAppear {
            viewModel.fetchOffices {
                viewModel.getUserInfo {
                    viewModel.isLoading = false
                    isSelestedOffice.append(viewModel.office)
                }
            }
        }
        .toolbar {
            Button {
                state = .none
                isSelestedOffice.removeAll()
                isSelestedOffice.append(viewModel.office)
            } label: {
                Text("Сбросить")
                    .foregroundStyle(.gray)
            }

        }
    }
}
