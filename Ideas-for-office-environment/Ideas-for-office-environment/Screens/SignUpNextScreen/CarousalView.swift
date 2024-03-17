//
//  CustomView.swift
//  Ideas-for-office-environment
//
//  Created by Elina Karapetian on 11.03.2024.
//

import SwiftUI

struct CarousalViewContainer: View {
    
    @State var isSelected: Int = 0
    
    var body: some View {
        CarousalView(isSelected: $isSelected, itemHeight: 500, offices: getViews())
    }
    
    func imageView(name: String) -> some View {
        Image(name)
            .aspectRatio(contentMode: .fill)
    }
    
    func getViews() -> [AnyView] {
        let offices: [Office] = [
            Office(name: "ул. Гагарина 6", image: "Office_1"),
            Office(name: "ул. Нижнегорская 2А", image: "Office_2"),
            Office(name: "ул. Кутузова 8", image: "Office_3"),
            Office(name: "ул. Гагарина 6", image: "Office_1"),
            Office(name: "ул. Нижнегорская 2А", image: "Office_2"),
            Office(name: "ул. Кутузова 8", image: "Office_3"),
            Office(name: "ул. Гагарина 6", image: "Office_1"),
            Office(name: "ул. Нижнегорская 2А", image: "Office_2"),
            Office(name: "ул. Кутузова 8", image: "Office_3"),
        ]
        
        var views : [AnyView] = []
        
        for (index, office) in offices.enumerated() {
            views.append(
                AnyView(
                    VStack {
                        imageView(name: office.image)
                            .frame(width: 180, height: 200)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(isSelected < 0 && (offices.count + isSelected) == index  || isSelected >= 0 && isSelected == index ? .blue: .clear, lineWidth: 8)
                            )
                            .background(.white)
                            .cornerRadius(20)
                            .onTapGesture {
                                withAnimation {
                                    self.isSelected = index
                                    print(index)
                                }
                            }
                        Text(office.name)
                            .foregroundStyle(isSelected < 0 && (offices.count + isSelected) == index  || isSelected >= 0 && isSelected == index ? .blue: .black)
                        
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

struct CarousalView: View {
    
    @GestureState private var dragState = DragState.inactive
    @Binding var isSelected: Int
    
    var itemHeight: CGFloat
    var offices: [AnyView]
    
    var body: some View {
        VStack {
            ZStack {
                ForEach(0..<offices.count) { i in
                    VStack {
                        Spacer()

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

                        Spacer()
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
            print(isSelected)
        } else if (drag.predictedEndTranslation.width) < (-1 * dragThreshold) || (drag.translation.width) < (-1 * dragThreshold) {
            isSelected = (isSelected + 1) % offices.count
            print(isSelected)
        }
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

#Preview {
    CarousalViewContainer()
}
