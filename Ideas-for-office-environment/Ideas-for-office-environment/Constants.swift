//
//  Constants.swift
//  Ideas-for-office-environment
//
//  Created by Elina Karapetian on 02.03.2024.
//

import Foundation

enum Constants {
    enum Duration {
        static let fast = 0.2
    }
    
    enum SigninView {
        
    }
    
    enum Button {
        enum Padding {
            static let horizontal = 55.0
            static let vertical = 15.0
        }
    }
    
    enum Spacing {
        static let verticalStack = 20.0
    }
    
    enum TextField {
        static let verticalPadding = 15.0
        static let horizontalPadding = Constants.Padding.main + 20.0
        static let radius = 5.0
    }
    
    enum Padding {
        static let main = 20.0
    }
}
