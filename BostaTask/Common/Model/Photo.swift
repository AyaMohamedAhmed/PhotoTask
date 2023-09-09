//
//  Photos.swift
//  BostaTask
//
//  Created by Aya Mohamed Ahmed on 08/09/2023.
//

import Foundation
import Foundation

// MARK: - Photo
struct Photo:Codable {
    let albumId:Int
    let id: Int
    let title: String
    let url:String
    let thumbnailUrl: String
}

