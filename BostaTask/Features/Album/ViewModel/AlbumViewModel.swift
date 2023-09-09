//
//  AlbumViewModel.swift
//  BostaTask
//
//  Created by Aya Mohamed Ahmed on 08/09/2023.
//

import Foundation
import RxSwift
import RxRelay

class AlbumViewModel: BaseViewModel {
    private let repo:UserRepoProtocol
    let searchedPhotoListBehaviorRelay:BehaviorRelay<[Photo]>
    let albumPhotosBehaviorRelay:BehaviorRelay<[Photo]>
    
    init(repo:UserRepoProtocol,albumId:Int) {
        self.repo = repo
        self.searchedPhotoListBehaviorRelay = BehaviorRelay<[Photo]>(value: [])
        self.albumPhotosBehaviorRelay = BehaviorRelay<[Photo]>(value: [])
        super.init()
        self.getAlbumsPhotos(albumId: albumId)
    }
    
    private func getAlbumsPhotos(albumId:Int){
        repo.getPhotos(albumId: albumId).subscribe { albumPhotosList in
            self.albumPhotosBehaviorRelay.accept(albumPhotosList)
            self.viewState.accept(UiState.success)
        } onFailure: { error in
            self.viewState.accept(UiState.error)
        }.disposed(by: self.dispose)
    }
    
    func filterImage(title:String){
        if(title.isEmpty){
            searchedPhotoListBehaviorRelay.accept(
                albumPhotosBehaviorRelay.value
            )
        }else{
            searchedPhotoListBehaviorRelay.accept(
                searchedPhotoListBehaviorRelay.value.filter({ photo in
                    photo.title
                        .lowercased()
                        .contains(title.lowercased())
                })
            )
        }
        
    }
    
}
