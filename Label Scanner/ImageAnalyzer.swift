//
//  ImageAnalyzer.swift
//  Label Scanner
//
//  Created by kalyan . on 2/20/25.
//

import Foundation
import Vision
import SwiftUI

class ImageAnalyzer: ObservableObject {
    @Published var recognizedText: String = ""
    @Published var isProcessing: Bool = false
    @Published var error: String?
    
    func analyzeImage(_ image: UIImage) {
        isProcessing = true
        error = nil
        
        guard let cgImage = image.cgImage else {
            error = "Failed to process image"
            isProcessing = false
            return
        }
        
        let requestHandler = VNImageRequestHandler(cgImage: cgImage)
        
        let textRequest = VNRecognizeTextRequest { request, error in
            if let error = error {
                DispatchQueue.main.async {
                    self.error = error.localizedDescription
                    self.isProcessing = false
                }
                return
            }
            
            guard let observations = request.results as? [VNRecognizedTextObservation] else { return }
            
            let recognizedStrings = observations.compactMap { observation in
                observation.topCandidates(1).first?.string
            }
            
            DispatchQueue.main.async {
                self.recognizedText = recognizedStrings.joined(separator: "\n")
                self.isProcessing = false
            }
        }
        
        textRequest.recognitionLevel = .accurate
        
        do {
            try requestHandler.perform([textRequest])
        } catch {
            DispatchQueue.main.async {
                self.error = error.localizedDescription
                self.isProcessing = false
            }
        }
    }
}
