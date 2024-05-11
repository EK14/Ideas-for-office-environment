//
//  SuggestIdeaView.swift
//  Ideas-for-office-environment
//
//  Created by Elina Karapetian on 30.04.2024.
//

import SwiftUI
import Combine

struct SuggestIdeaView: View {
    var coordinator: SuggestIdeaCoordinator
    @State var titleHeight: CGFloat = 56.0
    @State var textHeight: CGFloat = 56.0
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @FocusState var isFocused: Bool
    @ObservedObject var viewModel: SuggestIdeaViewModel
    
    var body: some View {
        ZStack {
            ScrollView(.vertical) {
                VStack(alignment: .leading, spacing: 20) {
                    HStack {
                        Button {
                            coordinator.close()
                        } label: {
                            Image(systemName: "xmark")
                                .imageScale(.large)
                                .font(.title2)
                        }
                        
                        Spacer()
                        
                        Button {
                            viewModel.suggestIdea {
                                viewModel.isLoading = false
                                coordinator.close()
                            }
                        } label: {
                            Text("Опубликовать")
                                .padding(.vertical, 7)
                                .padding(.horizontal, 14)
                                .background(.blue.opacity(0.3))
                                .clipShape(Capsule())
                                .overlay(
                                    Capsule()
                                        .stroke(.blue, lineWidth: 1)
                                )
                                .font(.system(size: 16))
                        }
                    }
                    .padding(.horizontal, 20)
                    
                    Text("Предложить идею")
                        .font(.system(size: 24))
                        .padding(.horizontal, 20)
                    
                    VStack(spacing: 5) {
                        ZStack(alignment: .leading) {
                            CustomTextView(text: $viewModel.title, height: $titleHeight, placeholder: "Заголовок")
                                .focused($isFocused)
                                .onAppear {
                                    isFocused = true
                                }
                                .frame(height: titleHeight)
                                .border(width: 1, edges: [.bottom], color: .gray)
                                .padding(.horizontal, 20)
                            
                            if viewModel.title.isEmpty {
                                Text("Заголовок")
                                    .padding(.leading, 20)
                                    .foregroundStyle(Color(uiColor: UIColor.black.withAlphaComponent(0.3)))
                            }
                        }
                        
                        ZStack(alignment: .leading) {
                            CustomTextView(text: $viewModel.content, height: $textHeight, placeholder: "Описание")
                                .frame(height: textHeight)
                                .padding(.horizontal, 20)
                            
                            if viewModel.content.isEmpty {
                                Text("Описание")
                                    .padding(.leading, 20)
                                    .foregroundStyle(Color(uiColor: UIColor.black.withAlphaComponent(0.3)))
                            }
                        }
                    }
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(LinearGradient(colors: [.white, .gray], startPoint: .bottom, endPoint: .top), lineWidth: 1)
                    )
                    
                    VStack(alignment: .leading) {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 20) {
                                ForEach(viewModel.posts) { post in
                                    ZStack(alignment: .topTrailing) {
                                        Image(uiImage: post.image)
                                            .resizable()
                                            .frame(width: 250, height: 250)
                                            .scaledToFill()
                                            .cornerRadius(10)
                                        
                                        Button {
                                            withAnimation {
                                                viewModel.deletePhoto(post: post)
                                            }
                                        } label: {
                                            Image(systemName: "xmark")
                                                .imageScale(.medium)
                                                .foregroundStyle(.blue)
                                                .padding(5)
                                                .background(.white)
                                                .clipShape(Circle())
                                                .padding(.trailing, 10)
                                                .padding(.top, 10)
                                        }
                                    }
                                }
                            }
                            .padding(.horizontal, 20)
                        }
                        
                        Button {
                            showingImagePicker = true
                        } label: {
                            Image(systemName: "photo")
                                .imageScale(.large)
                                .foregroundStyle(.blue)
                                .padding(8)
                                .background(Color("gray"))
                                .clipShape(RoundedRectangle(cornerRadius: 5))
                        }
                        .padding(.leading, 30)
                        .padding(.top, 10)
                    }
                    
                }
                .padding(.top, 20)
                .ignoresSafeArea(edges: .bottom)
            }
            .onChange(of: inputImage) { _ in
                loadImage()
            }
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(image: $inputImage)
                    .ignoresSafeArea()
            }
            
            if(viewModel.isLoading)  {
                LoadingView()
            }
        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        viewModel.posts.append(Post(image: inputImage))
    }
}

struct CustomTextView: UIViewRepresentable {
    @Binding var text: String
    @Binding var height: CGFloat
    var placeholder: String

    func makeUIView(context: Context) -> some UITextView {
        let textView = UITextView()
        textView.textColor = UIColor.black
        textView.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.body)
        textView.isScrollEnabled = true
        textView.isSelectable = true
        textView.isUserInteractionEnabled = true
        textView.delegate = context.coordinator
        textView.textContainerInset = UIEdgeInsets(top: 17, left: 0, bottom: 17, right: 20)
        textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
        textView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        textView.heightAnchor.constraint(equalToConstant: height).isActive = true
        textView.textContainer.lineFragmentPadding = .zero
        return textView
    }

    func updateUIView(_ textView: UIViewType, context _: Context) {
        textView.text = text
    }

    func makeCoordinator() -> TextViewCoordinator {
        TextViewCoordinator(text: $text, height: $height, placeholder: placeholder)
    }
}

class TextViewCoordinator: NSObject, UITextViewDelegate {
    @Binding var text: String
    var placeholder: String
    @Binding var height: CGFloat
    
    init(text: Binding<String>, height: Binding<CGFloat>, placeholder: String) {
        _text = text
        _height = height
        self.placeholder = placeholder
    }
    
    func textViewDidChange(_ textView: UITextView) {
        $text.wrappedValue = textView.text == placeholder ? "" : textView.text

        let size = CGSize(width: UIScreen.main.bounds.width - UIScreen.main.bounds.size.height * 0.02 * 2, height: .infinity)
        let estimatedSize = textView.sizeThatFits(size)
        
        textView.isScrollEnabled = false
        for constraints in textView.constraints {
            if constraints.firstAttribute == .height {
                constraints.constant = estimatedSize.height
                height = estimatedSize.height
            }
        }
    }
}
