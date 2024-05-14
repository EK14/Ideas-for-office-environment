//
//  CustomView.swift
//  Ideas-for-office-environment
//
//  Created by Elina Karapetian on 11.03.2024.
//

import SwiftUI
import SDWebImageSwiftUI

protocol CarousalViewContainerViewModel: ObservableObject {
    var office: Int { get set }
    var offices: [Office] { get set }
}

struct CarousalViewContainer<ViewModel: CarousalViewContainerViewModel>: View {
    
    @State var isSelected: Int = 0
    @ObservedObject var viewModel: ViewModel
    @State var id: Int = 0
    
    var body: some View {
        CarousalView(viewModel: viewModel, isSelected: $isSelected, itemHeight: 500, offices: getViews())
            .onAppear {
                self.isSelected = self.id
            }
    }
    
    func imageView(name: String) -> some View {
        Image(name)
            .aspectRatio(contentMode: .fill)
    }
    
    func getViews() -> [AnyView] {
        
        var views : [AnyView] = []
        
        for (index, office) in viewModel.offices.enumerated() {
            views.append(
                AnyView(
                    VStack {
                        WebImage(url: URL(string: office.imageUrl))
                            .resizable()
                            .scaledToFill()
                            .frame(width: 180, height: 200)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(isSelected < 0 && (viewModel.offices.count + isSelected) == index  || isSelected >= 0 && isSelected == index ? .blue: .clear, lineWidth: 8)
                            )
                            .background(.white)
                            .cornerRadius(20)
                            .onTapGesture {
                                withAnimation {
                                    self.isSelected = index
                                    viewModel.office = viewModel.offices[isSelected % viewModel.offices.count].id
                                }
                            }
                        Text(office.address)
                        
                        Spacer()
                    }
                )
            )
        }
        return views
    }
}

enum DragState {
    case inactive
    case dragging(translation: CGSize)
    
    var translation: CGSize {
        switch self {
        case .inactive:
            return .zero
        case .dragging(let translation):
            return translation
        }
    }
    
    var isDragging: Bool {
        switch self {
        case .inactive:
            return false
        case .dragging:
            return true
        }
    }
}

struct CarousalView<ViewModel: CarousalViewContainerViewModel>: View {
    
    @GestureState private var dragState = DragState.inactive
    @ObservedObject var viewModel: ViewModel
    @Binding var isSelected: Int
    
    var itemHeight: CGFloat
    var offices: [AnyView]
    
    var body: some View {
        VStack {
            ZStack {
                ForEach(0..<offices.count) { i in
                    VStack {
                        VStack {
                            self.offices[i]
                                .frame(width: 180)
                                .animation(.interpolatingSpring(stiffness: 180, damping: 30, initialVelocity: 10))
                                .background(.white)
                                .cornerRadius(20)
                                .opacity(getOpacity(i))
                                .offset(x: getOffset(i))
                                .animation(.interpolatingSpring(stiffness: 180, damping: 30, initialVelocity: 10))
                            
                        }
                    }
                }
            }
            .gesture(
                DragGesture()
                    .updating($dragState) { drag, state, transaction in
                        state = .dragging(translation: drag.translation)
                    }
                    .onEnded(onDragEnded)
            )
        }
    }
    
    private func onDragEnded(drag: DragGesture.Value) {
        let dragThreshold: CGFloat = 180
        if drag.predictedEndTranslation.width > dragThreshold || drag.translation.width > dragThreshold {
            isSelected = (isSelected - 1) % offices.count
        } else if (drag.predictedEndTranslation.width) < (-1 * dragThreshold) || (drag.translation.width) < (-1 * dragThreshold) {
            isSelected = (isSelected + 1) % offices.count
        }
        viewModel.office = viewModel.offices[isSelected >= 0 ? isSelected % viewModel.offices.count: (isSelected + viewModel.offices.count * 2) % viewModel.offices.count].id
    }
    
    func relativeLoc() -> Int {
        return ((offices.count * 10000) + isSelected) % offices.count
    }
    
    func getOffset(_ i: Int) -> CGFloat {
        if i == relativeLoc() {
            return dragState.translation.width
        } else if i == relativeLoc() + 1 || relativeLoc() == offices.count - 1 && i == 0{
            return dragState.translation.width + (180 + 20)
        } else if i == relativeLoc() - 1 || relativeLoc() == 0 && i == offices.count - 1 {
            return dragState.translation.width - (180 + 20)
        } else if i == relativeLoc() + 2 || (relativeLoc() == offices.count - 1 && i == 1) || (relativeLoc() == offices.count - 2 && i == 0) {
            return dragState.translation.width + (2*(180 + 20))
        } else if i == relativeLoc() - 2 || (relativeLoc() == 1 && i == offices.count - 1) || (relativeLoc() == 0 && i == offices.count - 2) {
            return dragState.translation.width - (2*(180 + 20))
        } else if i == relativeLoc() + 3 || (relativeLoc() == offices.count - 1 && i == 2) || (relativeLoc() == offices.count - 2 && i == 1) || (relativeLoc() == offices.count - 3 && i == 0){
            return dragState.translation.width + (3*(180 + 20))
        } else if i == relativeLoc() - 3 || (relativeLoc() == 2 && i == offices.count - 1) || (relativeLoc() == 1 && i == offices.count - 2) || (relativeLoc() == 0 && i == offices.count - 3) {
            return dragState.translation.width - (3*(180 + 20))
        } else {
            return 10000
        }
    }
    
    func getHeight(_ i: Int) -> CGFloat {
        if i == relativeLoc(){
            return itemHeight
        }
        return itemHeight - 100
    }
    
    func getOpacity(_ i: Int) -> Double {
        if i == relativeLoc() ||
            i == (relativeLoc() + 1) % offices.count ||
            i == (relativeLoc() - 1 + offices.count) % offices.count ||
            i == (relativeLoc() + 2) % offices.count ||
            i == (relativeLoc() - 2 + offices.count) % offices.count {
            return 1
        }
        return 0
    }

}
