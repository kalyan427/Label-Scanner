//
//  ResultsView.swift
//  Label Scanner
//
//  Created by kalyan . on 2/16/25.
//

import Foundation
import SwiftUI

struct ResultsView: View {
    let image: UIImage
    @Environment(\.dismiss) var dismiss
    @StateObject private var analyzer = ImageAnalyzer()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxHeight: 300)
                        .padding()
                    
                    if analyzer.isProcessing {
                        ProgressView("Processing Image...")
                    } else if let error = analyzer.error {
                        Text(error)
                            .foregroundColor(.red)
                    } else {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Detected Text:")
                                .font(.headline)
                            Text(analyzer.recognizedText)
                                .font(.body)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                    }
                }
            }
            .navigationTitle("Scan Results")
            .navigationBarItems(trailing: Button("Done") {
                dismiss()
            })
        }
        .onAppear {
            analyzer.analyzeImage(image)
        }
    }
}
