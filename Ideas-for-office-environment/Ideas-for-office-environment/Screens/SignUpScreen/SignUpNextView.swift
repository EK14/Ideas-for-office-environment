//
//  SignUpNextView.swift
//  Ideas-for-office-environment
//
//  Created by Elina Karapetian on 10.03.2024.
//

import SwiftUI
import PhotosUI

struct SignUpNextView: View, KeyboardReadable {
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var image: Image?
    @ObservedObject var viewModel: SignUpViewModel
    @State var emptyName = false
    @State var emptySurname = false
    @State var emptyJob = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("Фото")
                    .font(.title3)
                
                Group{
                    if let image = image {
                        image
                            .resizable()
                            .scaledToFill()
                    } else {
                        Image(systemName: "camera")
                            .font(.headline)
                            .imageScale(.large)
                            .foregroundStyle(.blue)
                    }
                }
                .frame(width: 180, height: 180)
                .background(.blue.opacity(0.25))
                .cornerRadius(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(image == nil ? .blue: .gray, lineWidth: 2)
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
                    CustomTextField(text: $viewModel.name, empty: $emptyName, lable: "Имя", titleKey: "Ваше имя")
                    
                    if emptyName {
                        Text(S.emptyName)
                            .foregroundStyle(.red)
                            .font(.footnote)
                            .padding(.horizontal, Constants.Padding.main)
                    }
                }
                
                VStack(alignment: .leading) {
                    CustomTextField(text: $viewModel.surname, empty: $emptySurname, lable: "Фамилия", titleKey: "Ваша фамилия")
                    
                    if emptySurname {
                        Text(S.emptySurname)
                            .foregroundStyle(.red)
                            .font(.footnote)
                            .padding(.horizontal, Constants.Padding.main)
                    }
                }
                
                VStack(alignment: .leading) {
                    CustomTextField(text: $viewModel.job, empty: $emptyJob, lable: "Должность", titleKey: "Ваша должность")
                    
                    if emptyJob {
                        Text(S.emptyJob)
                            .foregroundStyle(.red)
                            .font(.footnote)
                            .padding(.horizontal, Constants.Padding.main)
                    }
                }
                
                Text("Офис")
                    .font(.title3)
                
                CarousalViewContainer(viewModel: viewModel)
                
                Button {
                    emptyName = viewModel.name.isEmpty
                    emptySurname = viewModel.surname.isEmpty
                    emptyJob = viewModel.job.isEmpty
                    
                    if !emptyName && !emptySurname && !emptyJob {
                        viewModel.signUp()
                    }
                } label: {
                    Text("Завершить регистрацию")
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
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?

    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {

    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)

            guard let provider = results.first?.itemProvider else { return }

            if provider.canLoadObject(ofClass: UIImage.self) {
                provider.loadObject(ofClass: UIImage.self) { image, _ in
                    self.parent.image = image as? UIImage
                }
            }
        }
    }
}

#Preview {
    let vm = SignUpViewModel()
    
    return SignUpNextView(viewModel: vm)
}


