//
//  NetworkService.swift
//  BostaTask
//
//  Created by Aya Mohamed Ahmed on 08/09/2023.
//

import Foundation
import RxSwift
import Moya
import RxCocoa

protocol UserNetworkServicesProtocol {
    func getUser(userId:Int) -> RxSwift.Single<User>
    func getAlbums(userId:Int) -> RxSwift.Single<[Album]>
    func getPhotos(albumId:Int) ->RxSwift.Single<[Photo]>
}


class UserNetworkService : UserNetworkServicesProtocol {
    private let moyaProvider:MoyaProvider<UserService>
    private let backgroundScheduler:ConcurrentDispatchQueueScheduler!
    
    init(
        moyaProvider:MoyaProvider<UserService>,
        backgroundScheduler: ConcurrentDispatchQueueScheduler! =
        ConcurrentDispatchQueueScheduler(
            qos: .background
        )
    ){
        self.moyaProvider = moyaProvider
        self.backgroundScheduler = backgroundScheduler
    }
    
    func getUser(userId:Int) -> RxSwift.Single<User> {
        return moyaProvider.rx
            .request(.getUsers(id: userId))
            .map(User.self)
            .subscribe(on: backgroundScheduler)
    }
    
    func getAlbums(userId:Int) -> RxSwift.Single<[Album]>{
        return moyaProvider.rx
            .request(.getUserAlbums(id: userId))
            .map([Album].self)
            .subscribe(on: backgroundScheduler)
    }
    
    func getPhotos(albumId:Int) ->RxSwift.Single<[Photo]>{
        return moyaProvider.rx
            .request(.getAlbumPhotos(albumID: albumId))
            .map([Photo].self)
            .subscribe(on: backgroundScheduler)
    }
    
}






