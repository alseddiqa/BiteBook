//
//  ErrorView.swift
//  BiteBook
//
//  Created by Abdullah Alseddiq on 09/03/2025.
//

import SwiftUI

struct ErrorView: View {
    let error: APIError?
    let retryAction: (() -> Void)?

    init(error: APIError?, retryAction: (() -> Void)? = nil) {
        self.error = error
        self.retryAction = retryAction
    }

    var body: some View {
        VStack(alignment: .center) {
            HStack {
                Spacer()
                Text(errorMessage)
                    .font(.title3)
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
                Spacer()
            }
            if let retryAction = retryAction {
                Button(action: retryAction) {
                    HStack {
                        Image(systemName: "arrow.clockwise")
                        Text("Retry")
                    }
                }
                .padding()
            }
        }
    }

    private var errorMessage: String {
        switch error {
        case .invalidURL:
            return "❗️Invalid URL 😥"
        case .requestFailed(let error):
            return "Request failed: \(error.localizedDescription) 🤒"
        case .invalidResponse:
            return "Invalid response from server."
        case .decodingFailed(let error):
            return "❗️Failed to decode data: \(error.localizedDescription) 😪"
        case .none:
            return "❗️An unknown error occurred 😑"
        }
    }
}
