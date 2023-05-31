//
//  ImageSaver.swift
//  Instafilter
//
//  Created by Anthony Cifre on 5/31/23.
//

import UIKit
import Foundation


class ImageSaver: NSObject {
    var successHandler: (() -> Void)?
    var errorHandler: ((Error) -> Void)?
    
    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveCompleted), nil)
        
    }
    
    @objc func saveCompleted(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            errorHandler?(error)
            
        } else {
            successHandler?()
            
        }
        
    }
    
    

}
