//
//  EmptyView.swift
//  BiteBook
//
//  Created by Abdullah Alseddiq on 09/03/2025.
//
import SwiftUI

struct EmptyStateView: View {
    let message: String

    init(message: String = "No results found.") {
        self.message = message
    }

    var body: some View {
        VStack(alignment: .center) {
            HStack {
                Spacer()
                Text(message)
                    .font(.title3)
                    .foregroundColor(.brown)
                Spacer()
            }
        }
    }
}
