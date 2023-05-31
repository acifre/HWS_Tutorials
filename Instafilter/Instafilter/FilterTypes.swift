//
//  FilterTypes.swift
//  Instafilter
//
//  Created by Anthony Cifre on 5/31/23.
//


import CoreImage
import CoreImage.CIFilterBuiltins
import Foundation
import SwiftUI


enum FilterType: String, CaseIterable {
    case ComicEffect
    case ColorInvert
    case Crystallize
    case Edges
    case GaussianBlur
    case Pixellate
    case SepiaTone
    case UnsharpMask
    case Vibrance
    case Vignette
    
    
    var filter: CIFilter {
        switch self {
        case .ComicEffect:
            return CIFilter.comicEffect()
        case .ColorInvert:
            return CIFilter.colorInvert()
        case .Crystallize:
            return CIFilter.crystallize()
        case .Edges:
            return CIFilter.edges()
        case .GaussianBlur:
            return CIFilter.gaussianBlur()
        case .Pixellate:
            return CIFilter.pixellate()
        case .SepiaTone:
            return CIFilter.sepiaTone()
        case .UnsharpMask:
            return CIFilter.unsharpMask()
        case .Vibrance:
            return CIFilter.vibrance()
        case .Vignette:
            return CIFilter.vignette()
        }
    }
    
}


