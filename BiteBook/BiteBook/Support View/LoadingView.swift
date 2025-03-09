//
//  LoadingView.swift
//  BiteBook
//
//  Created by Abdullah Alseddiq on 09/03/2025.
//

import SwiftUI
import SwiftfulLoadingIndicators

struct LoadingView: View {
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                LoadingIndicator(animation: .threeBallsRotation, color: .orange)
                Spacer()
            }
            Spacer()
        }
    }
}
