//
//  HomeViewModel.swift
//  BostaTask
//
//  Created by Aya Mohamed Ahmed on 08/09/2023.
//

import Foundation
import RxSwift

class HomeViewModel : BaseViewModel {
    private let repo:UserRepoProtocol
    let userPublishSubject:PublishSubject<User>
    let albumPublishSubject:PublishSubject<[Album]>
    
    init(repo:UserRepoProtocol,userId:Int) {
        self.repo = repo
        self.userPublishSubject = PublishSubject<User>()
        self.albumPublishSubject = PublishSubject<[Album]>()
        super.init()
        self.getUser(userId: userId)
        self.getUserAlbums(userId: userId)
    }
    
    private func getUser(userId:Int){
        repo.getUserById(userId: userId).subscribe { user in
            self.userPublishSubject.onNext(user)
            self.viewState.accept(UiState.success)
        } onFailure: { error in
            self.viewState.accept(UiState.error)
        }.disposed(by: self.dispose)
    }
    
    private func getUserAlbums(userId:Int){
        repo.getAlbums(userId: userId).subscribe { userAlbumList in
            self.albumPublishSubject.onNext(userAlbumList)
            self.viewState.accept(UiState.success)
        } onFailure: { error in
            self.viewState.accept(UiState.error)
        }.disposed(by: self.dispose)
    }
    
}


