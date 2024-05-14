//
//  SetUpProfileView.swift
//  Ideas-for-office-environment
//
//  Created by Elina Karapetian on 29.04.2024.
//

import SwiftUI
import PhotosUI
import SDWebImageSwiftUI

struct SetUpProfileView: View, KeyboardReadable {
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var image: Image?
    @ObservedObject var setupProfileViewModel: ProfileViewModel
    @State var emptyName = false
    @State var emptySurname = false
    @State var emptyJob = false
    var coordinator: SetUpProfileCoordinator
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack(spacing: 20) {
                    Text("Фото")
                        .font(.title3)
                    
                    Group{
                        if let photo = inputImage {
                            ZStack {
                                Image(uiImage: photo)
                                    .resizable()
                                    .scaledToFill()
                                
                                Image(systemName: "camera")
                                    .font(.headline)
                                    .imageScale(.large)
                                    .foregroundStyle(.blue)
                            }
                        } else {
                            ZStack {
                                WebImage(url: URL(string: setupProfileViewModel.photoUrl))
                                    .resizable()
                                    .scaledToFill()
                                
                                Image(systemName: "camera")
                                    .font(.headline)
                                    .imageScale(.large)
                                    .foregroundStyle(.blue)
                            }
                        }
                    }
                    .frame(width: 180, height: 180)
                    .background(.blue.opacity(0.25))
                    .cornerRadius(20)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(.gray, lineWidth: 2)
                    )
                    .onTapGesture {
                        showingImagePicker = true
                    }
                    .onChange(of: inputImage) { _ in
                        loadImage()
                    }
                    .sheet(isPresented: $showingImagePicker) {
                        ImagePicker(image: $inputImage)
                            .ignoresSafeArea()
                    }
                    
                    VStack(alignment: .leading) {
                        CustomTextField(text: $setupProfileViewModel.name, empty: $emptyName, lable: "Имя", titleKey: "Ваше имя")
                        
                        if emptyName {
                            Text(S.emptyName)
                                .foregroundStyle(.red)
                                .font(.footnote)
                                .padding(.horizontal, Constants.Padding.main)
                        }
                    }
                    
                    VStack(alignment: .leading) {
                        CustomTextField(text: $setupProfileViewModel.surname, empty: $emptySurname, lable: "Фамилия", titleKey: "Ваша фамилия")
                        
                        if emptySurname {
                            Text(S.emptySurname)
                                .foregroundStyle(.red)
                                .font(.footnote)
                                .padding(.horizontal, Constants.Padding.main)
                        }
                    }
                    
                    VStack(alignment: .leading) {
                        CustomTextField(text: $setupProfileViewModel.job, empty: $emptyJob, lable: "Должность", titleKey: "Ваша должность")
                        
                        if emptyJob {
                            Text(S.emptyJob)
                                .foregroundStyle(.red)
                                .font(.footnote)
                                .padding(.horizontal, Constants.Padding.main)
                        }
                    }
                    
                    Text("Офис")
                        .font(.title3)
                    
                    if !setupProfileViewModel.isLoading {
                        CarousalViewContainer(viewModel: setupProfileViewModel, id: setupProfileViewModel.office - 1)
                    }
                    
                    Button {
                        emptyName = setupProfileViewModel.name.isEmpty
                        emptySurname = setupProfileViewModel.surname.isEmpty
                        emptyJob = setupProfileViewModel.job.isEmpty
                        
                        if !emptyName && !emptySurname && !emptyJob {
                            setupProfileViewModel.saveUserInfo {
                                coordinator.didTapSaveInfo()
                            }
                        }
                    } label: {
                        Text("Сохранить")
                            .foregroundStyle(.white)
                            .padding(.horizontal, Constants.Button.Padding.horizontal)
                            .padding(.vertical, Constants.Button.Padding.vertical)
                            .background(.blue)
                            .clipShape(Capsule())
                    }
                }
                .padding(.bottom, 30)
            }
            .navigationBarHidden(false)
            .onTapGesture {
                hideKeyboard()
            }
            
            if setupProfileViewModel.isLoading {
                LoadingView()
                    .ignoresSafeArea()
            }
        }
        .onAppear {
            setupProfileViewModel.fetchOffices {
                setupProfileViewModel.isLoading = false
                print(setupProfileViewModel.office)
            }
        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
        setupProfileViewModel.photo = inputImage
    }
}

