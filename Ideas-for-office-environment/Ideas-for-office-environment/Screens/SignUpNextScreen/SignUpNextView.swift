//
//  SignUpNextView.swift
//  Ideas-for-office-environment
//
//  Created by Elina Karapetian on 10.03.2024.
//

import SwiftUI
import PhotosUI

struct SignUpNextView: View, KeyboardReadable {
    @Environment(\.presentationMode) var presentationMode
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var image: Image?
    @State private var name: String = ""
    @State private var surname: String = ""
    @State private var position: String = ""
    
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
                }
                
                CustomTextField(text: $name, lable: "Имя", titleKey: "Ваше имя")
                
                CustomTextField(text: $surname, lable: "Фамилия", titleKey: "Ваша фамилия")
                
                CustomTextField(text: $position, lable: "Должность", titleKey: "Ваша должность")
                
                Text("Офис")
                    .font(.title3)
                
                CarousalViewContainer()
                
                NavigationLink {
                    Text("hello")
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
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    HStack {
                        Image(systemName: "arrow.backward")
                        Text("Сведения о себе")
                            .foregroundStyle(.black)
                    }
                }
            }
        }
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
    SignUpNextView()
}


