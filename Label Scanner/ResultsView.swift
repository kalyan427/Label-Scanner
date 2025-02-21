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
    
    var body: some View {
        NavigationView {
            VStack {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .padding()
                
                Text("Processing image...")
                    .font(.headline)
                    .padding()
            }
            .navigationTitle("Scan Results")
            .navigationBarItems(trailing: Button("Done") {
                dismiss()
            })
        }
    }
}
