//
//  MeView.swift
//  HotProspects
//
//  Created by Anthony Cifre on 6/16/23.
//

import CodeScanner
import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI
import UIKit

struct MeView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var prospects: Prospects

    @State private var name = "Anthony Cifre"
    @State private var emailAddress = "abcifre@cougarnet.uh.edu"
    @State private var qrCode = UIImage()


    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()


    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                    .textContentType(.name)
                    .font(.title)
                    .padding(.horizontal)

                TextField("Email Address", text: $emailAddress)
                    .textContentType(.emailAddress)
                    .font(.title)
                    .padding([.horizontal, .bottom])

                Image(uiImage: qrCode)
                    .resizable()
                    .interpolation(.none)
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .contextMenu {
                        Button("Save to Photos") {
                            let imageSaver = ImageSaver()
                            imageSaver.writeToPhotoAlbum(image: qrCode)
                        }
                }
            }
                .navigationTitle("Your Info")
                .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {

                        dismiss()
                    }
                }
            }
                .onAppear(perform: updateCode)
                .onChange(of: name) { updateCode() }
                .onChange(of: emailAddress) { updateCode() }

        }
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

    func updateCode() {
        qrCode = generateQRCode(from: "\(name)\n\(emailAddress)")
    }


}

#Preview {
    MeView()
}
