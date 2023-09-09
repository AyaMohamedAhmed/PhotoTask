//
//  ForumService.swift
//  BostaTask
//
//  Created by Aya Mohamed Ahmed on 08/09/2023.
//

import Foundation
import Moya
import Alamofire


enum UserService {
    case getUsers(id:Int)
    case getUserAlbums(id: Int)
    case getAlbumPhotos(albumID:Int)
}

extension UserService: TargetType {
    
    var headers: [String : String]? {
        nil
    }
    // This is the base URL we'll be using, typically our server.
    var baseURL: URL {
        return URL(string: ApiConstants.END_POINT)!
    }
    
    // This is the path of each operation that will be appended to our base URL.
    var path: String {
        switch self {
        case .getUsers(id: let id):
            return ApiConstants.getUserUrl(userId: id)
        case .getUserAlbums:
            return ApiConstants.ALBUMS_URL
        case .getAlbumPhotos:
            return ApiConstants.PHOTOS_URL
        }
        
    }
    
    // Here we specify which method our calls should use.
    var method: Moya.Method {
        switch self {
        case .getUsers:
            return .get
        case .getUserAlbums:
            return .get
        case .getAlbumPhotos:
            return .get
        }
    }
    
    // Here we specify body parameters, objects, files etc.
    // or just do a plain request without a body.
    // In this example we will not pass anything in the body of the request.
    var task: Task {
        switch self {
        case .getUsers:
            return .requestPlain
        case .getUserAlbums(let id):
            return .requestParameters(parameters: ["userId":id], encoding: URLEncoding.default)
        case .getAlbumPhotos(let albumID):
            return .requestParameters(parameters: ["albumId":albumID], encoding: URLEncoding.default)
        }
    }
}
