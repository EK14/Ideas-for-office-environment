//
//  LoadingView.swift
//  Ideas-for-office-environment
//
//  Created by Elina Karapetian on 13.04.2024.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack {
            Color(.systemBackground)
                .ignoresSafeArea()
            
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                .scaleEffect(2)
        }
    }
}


#Preview {
    LoadingView()
}
