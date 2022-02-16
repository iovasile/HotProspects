//
//  MeView.swift
//  HotProspects
//
//  Created by Ionut Vasile on 16.02.2022.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct MeView: View {
    @State private var name = "Ionut Vasile"
    @State private var emailAddress = "email@iovasile.dev"
    
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                    .font(.title)
                    .textContentType(.name)
                TextField("Email address", text: $emailAddress)
                    .font(.title)
                    .textContentType(.emailAddress)
                Image(uiImage: qrUIImage)
                    .interpolation(.none)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .contextMenu {
                        Button {
                            ImageSaver().writeToPhotoAlbum(image: qrUIImage)
                        } label: {
                            Label("Save code", systemImage: "square.and.arrow.down")
                        }
                    }
                    
            }
            .navigationTitle("Your code")
        }
    }
    
    var qrUIImage: UIImage {
        generateQRCode(from: "\(name)\n\(emailAddress)")
    }
    
    func generateQRCode(from string: String) -> UIImage {
        filter.message = Data(string.utf8)
        if let outputImage = filter.outputImage {
            if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgImage)
            }
        }
        
        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
}

struct MeView_Previews: PreviewProvider {
    static var previews: some View {
        MeView()
    }
}
