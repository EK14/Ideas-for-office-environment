//
//  SuggestIdeaView.swift
//  Ideas-for-office-environment
//
//  Created by Elina Karapetian on 30.04.2024.
//

import SwiftUI
import Combine

struct SuggestIdeaView: View {
    @State var title = ""
    @State var text = ""
    var coordinator: SuggestIdeaCoordinator
    @State var titleHeight: CGFloat = 56.0
    @State var textHeight: CGFloat = 56.0
    @FocusState var isFocused: Bool
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
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
                
                VStack {
                    ZStack(alignment: .leading) {
                        CustomTextView(text: $title, height: $titleHeight, placeholder: "Заголовок")
                            .focused($isFocused)
                            .onAppear {
                                isFocused = true
                            }
                            .frame(height: titleHeight)
                            .border(width: 1, edges: [.bottom], color: .gray)
                            .padding(.horizontal, 20)
                        
                        if title.isEmpty {
                            Text("Заголовок")
                                .padding(.leading, 20)
                                .foregroundStyle(Color(uiColor: UIColor.black.withAlphaComponent(0.3)))
                        }
                    }
                    
                    ZStack(alignment: .leading) {
                        CustomTextView(text: $text, height: $textHeight, placeholder: "Описание")
                            .frame(height: textHeight)
                            .padding(.horizontal, 20)
                        
                        if text.isEmpty {
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
                
                Spacer()
            }
            .padding(.top, 20)
            .ignoresSafeArea(edges: .bottom)
        }
    }
}

#Preview {
    var coordinator = SuggestIdeaCoordinator(rootViewController: UINavigationController())
    
    return SuggestIdeaView(coordinator: coordinator)
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

extension View {
    func textEditorBackground<V>(@ViewBuilder _ content: () -> V) -> some View where V: View {
        onAppear {
            UITextView.appearance().backgroundColor = .clear
        }
        .background(content())
    }
}
