//
//  ContentView.swift
//  Label Scanner
//
//  Created by kalyan . on 2/16/25.
//

import SwiftUI

struct ContentView: View {
    @State private var isShowingCamera = false
    @State private var capturedImage: UIImage?
    @State private var isShowingResults = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 24) {
                Image(systemName: "tshirt.fill")
                    .font(.system(size: 40))
                    .foregroundColor(.blue)
                    .padding(.top, 40)
                
                VStack(spacing: 8) {
                    Text("Care Label Scanner")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Text("Get instant care instructions for your garments")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                }
                
                VStack(spacing: 12) {
                    Button {
                        isShowingCamera = true
                    } label: {
                        HStack {
                            Image(systemName: "camera.fill")
                            Text("Scan New Label")
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                    
                    Button {
                        
                    } label: {
                        HStack {
                            Image(systemName: "bookmark.fill")
                            Text("View Saved Items")
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(.systemGray6))
                        .foregroundColor(.primary)
                        .cornerRadius(10)
                    }
                }
                .padding(.top, 20)
                
                VStack(alignment: .leading, spacing: 16) {
                    Text("Quick Tips:")
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        TipRow(text: "Ensure good lighting")
                        TipRow(text: "Hold the camera steady")
                        TipRow(text: "Position label within frame")
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 30)
                
                Spacer()
            }
            .padding()
            .sheet(isPresented: $isShowingCamera) {
                ImagePicker(selectedImage: $capturedImage)
                    .ignoresSafeArea()
            }
            
            .onChange(of: capturedImage) { image in
                if image != nil {
                    isShowingResults = true
                }
            }
            .sheet(isPresented: $isShowingResults) {
                if let image = capturedImage {
                    ResultsView(image: image)
                }
            }
        }
    }
}

struct TipRow: View {
    let text: String
    
    var body: some View {
        HStack {
            Text(".")
                .foregroundColor(.blue)
            Text(text)
                .foregroundColor(.blue)
        }
    }
}

#Preview {
    ContentView()
}
