//
//  ProfileView.swift
//  Ideas-for-office-environment
//
//  Created by Elina Karapetian on 20.03.2024.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProfileView: View {
    @ObservedObject var viewModel: ProfileViewModel
    var coordinator: ProfileCoordinator
    
    var body: some View {
        ZStack {
            VStack {
                VStack {
                    AnimatedImage(url: URL(string: viewModel.photoUrl))
                        .resizable()
                        .scaledToFill()
                        .foregroundStyle(.blue)
                        .frame(width: 150, height: 150)
                        .background(.blue.opacity(0.25))
                        .cornerRadius(50)
                        .overlay(
                            RoundedRectangle(cornerRadius: 50)
                                .stroke(.gray, lineWidth: 1)
                        )
                        .padding(1)
                    
                    Text("\(viewModel.name) \(viewModel.surname)")
                        .font(.system(size: 24))
                    
                    Text(viewModel.job)
                        .font(.system(size: 15))
                }
                .frame(maxWidth: .infinity)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(LinearGradient(colors: [.white, .gray], startPoint: .top, endPoint: .bottom), lineWidth: 1)
                )
                .cornerRadius(20, corners: [.bottomLeft, .bottomRight])
                
                VStack() {
                    HStack(spacing: 20) {
                        Image("settings")
                            .frame(width: 30)
                        Text("Настроить профиль")
                            .font(.system(size: 16))
                    }
                    .padding(.vertical, 5)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .onTapGesture {
                        coordinator.setupProfile()
                    }
                    
                    HStack(spacing: 20) {
                        Image("myoffice")
                            .frame(width: 30)
                        Text("Мой офис")
                            .font(.system(size: 16))
                    }
                    .padding(.vertical, 5)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .onTapGesture {
                        print("Мой офис")
                    }
                    
                    HStack(spacing: 20) {
                        Image("myideas")
                            .frame(width: 30)
                        Text("Мои идеи")
                            .font(.system(size: 16))
                    }
                    .padding(.vertical, 5)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .onTapGesture {
                        print("Мои идеи")
                    }
                }
                .padding(.vertical, 16)
                .padding(.horizontal, 20)
                
                Button(action: {
                    Auth.shared.logout()
                }, label: {
                    Text("Выйти")
                        .font(.system(size: 15))
                })
                .padding(.vertical, 10)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical, 10)
                .border(width: 1, edges: [.top], color: .blue)
                .padding(.horizontal, 20)
                
                Spacer()
                
            }
            .onAppear {
                viewModel.getUserInfo() {
                    viewModel.isLoading = false
                }
            }
            
            if viewModel.isLoading {
                LoadingView()
            }
        }
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension View {
    func border(width: CGFloat, edges: [Edge], color: Color, padding: CGFloat = 0) -> some View {
        overlay(EdgeBorder(width: width, edges: edges).foregroundColor(color))
            .padding(.horizontal, padding)
    }
}

struct EdgeBorder: Shape {
    var width: CGFloat
    var edges: [Edge]

    func path(in rect: CGRect) -> Path {
        edges.map { edge -> Path in
            switch edge {
            case .top: return Path(.init(x: rect.minX, y: rect.minY, width: rect.width, height: width))
            case .bottom: return Path(.init(x: rect.minX, y: rect.maxY - width, width: rect.width, height: width))
            case .leading: return Path(.init(x: rect.minX, y: rect.minY, width: width, height: rect.height))
            case .trailing: return Path(.init(x: rect.maxX - width, y: rect.minY, width: width, height: rect.height))
            }
        }.reduce(into: Path()) { $0.addPath($1) }
    }
}
