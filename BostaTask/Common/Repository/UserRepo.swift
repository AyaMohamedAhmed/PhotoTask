//
//  Repo.swift
//  BostaTask
//
//  Created by Aya Mohamed Ahmed on 08/09/2023.
//

import Foundation
import RxSwift

protocol UserRepoProtocol {
    func getUserById(userId:Int)->Single<User>
    func getAlbums(userId:Int)->Single<[Album]>
    func getPhotos(albumId:Int)->Single<[Photo]>
}

class UserRepo : UserRepoProtocol{
    
    private let networkManger : UserNetworkServicesProtocol
    private let mainScheduler : MainScheduler
    
    init(
        networkManger: UserNetworkServicesProtocol,
        mainSchduler:MainScheduler = MainScheduler.instance
    ) {
        self.networkManger = networkManger
        self.mainScheduler = mainSchduler
    }
    
    func getUserById(userId:Int)->Single<User>{
        return networkManger.getUser(userId: userId)
            .observe(on: mainScheduler)
    }
    
    func getAlbums(userId:Int)->Single<[Album]>{
        return networkManger.getAlbums(userId: userId)
            .observe(on: mainScheduler)
    }
    
    func getPhotos(albumId:Int)->Single<[Photo]>{
        return networkManger.getPhotos(albumId: albumId)
            .observe(on: mainScheduler)
    }
    
}

