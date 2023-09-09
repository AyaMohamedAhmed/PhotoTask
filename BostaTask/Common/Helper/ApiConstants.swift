//
//  Constant.swift
//  BostaTask
//
//  Created by Aya Mohamed Ahmed on 08/09/2023.
//

import Foundation
import Alamofire
struct ApiConstants{
    static let END_POINT = "https://jsonplaceholder.typicode.com/"
    static let ALBUMS_URL = "albums"
    static let PHOTOS_URL = "photos"
    private static let USER_URL = "users/"
    
    static func getUserUrl(userId:Int) -> String {
        return USER_URL + String(userId)
    }
}
