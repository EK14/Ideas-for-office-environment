//
//  CustomView.swift
//  Ideas-for-office-environment
//
//  Created by Elina Karapetian on 11.03.2024.
//

import SwiftUI

struct CustomView: View {
    
    var body: some View {
        CarousalView(itemHeight: 500, views: getViews())
    }
    
    func imageView(name: String) -> some View {
        Image(name)
            .aspectRatio(contentMode: .fill)
    }
    
    func getViews() -> [AnyView] {
        let images: [String] = [
            "Office_1",
            "Office_2",
            "Office_3",
            "Office_1",
            "Office_2",
            "Office_3",
            "Office_1",
            "Office_2",
            "Office_3",
        ]
        
        var views : [AnyView] = []
        
        for image in images {
            views.append(
                AnyView(
                    imageView(name: image)
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
    @State var carousalLocation = 0
    
    var itemHeight: CGFloat
    var views: [AnyView]
    
    var body: some View {
        VStack {
            ZStack {
                ForEach(0..<views.count) { i in
                    VStack {
                        Spacer()

                        self.views[i]
                            .frame(width: 180, height: 200)
                            .animation(.interpolatingSpring(stiffness: 180, damping: 30, initialVelocity: 10))
                            .background(.white)
                            .cornerRadius(15)
                            .opacity(getOpacity(i))
                            .offset(x: getOffset(i))
                            .animation(.interpolatingSpring(stiffness: 180, damping: 30, initialVelocity: 10))
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(.blue, lineWidth: 4)
                            )
                            .onTapGesture {
                                withAnimation {
                                    self.carousalLocation = i
                                }
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
            carousalLocation = carousalLocation - 1
        } else if (drag.predictedEndTranslation.width) < (-1 * dragThreshold) || (drag.translation.width) < (-1 * dragThreshold) {
            carousalLocation = carousalLocation + 1
        }
    }
    
    func relativeLoc() -> Int {
        return ((views.count * 10000) + carousalLocation) % views.count
    }
    
    func getOffset(_ i: Int) -> CGFloat {
        if i == relativeLoc() {
            return dragState.translation.width
        } else if i == relativeLoc() + 1 || relativeLoc() == views.count - 1 && i == 0{
            return dragState.translation.width + (180 + 20)
        } else if i == relativeLoc() - 1 || relativeLoc() == 0 && i == views.count - 1 {
            return dragState.translation.width - (180 + 20)
        } else if i == relativeLoc() + 2 || (relativeLoc() == views.count - 1 && i == 1) || (relativeLoc() == views.count - 2 && i == 0) {
            return dragState.translation.width + (2*(180 + 20))
        } else if i == relativeLoc() - 2 || (relativeLoc() == 1 && i == views.count - 1) || (relativeLoc() == 0 && i == views.count - 2) {
            return dragState.translation.width - (2*(180 + 20))
        } else if i == relativeLoc() + 3 || (relativeLoc() == views.count - 1 && i == 2) || (relativeLoc() == views.count - 2 && i == 1) || (relativeLoc() == views.count - 3 && i == 0){
            return dragState.translation.width + (3*(180 + 20))
        } else if i == relativeLoc() - 3 || (relativeLoc() == 2 && i == views.count - 1) || (relativeLoc() == 1 && i == views.count - 2) || (relativeLoc() == 0 && i == views.count - 3) {
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
            i == (relativeLoc() + 1) % views.count ||
            i == (relativeLoc() - 1 + views.count) % views.count ||
            i == (relativeLoc() + 2) % views.count ||
            i == (relativeLoc() - 2 + views.count) % views.count {
            return 1
        }
        return 0
    }

}

#Preview {
    CustomView()
}
