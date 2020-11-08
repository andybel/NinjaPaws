//
//  AnimalPic.swift
//  NinjaPaws
//
//  Created by Andy Bell on 07.11.20.
//

import UIKit

struct AnimalPic: Decodable, Identifiable {
    let id: String
    let url: String
    let width: Int
    let height: Int
    
    var widthToHeightRatio: CGFloat {
        CGFloat(Double(width) / Double(height))
    }
}
