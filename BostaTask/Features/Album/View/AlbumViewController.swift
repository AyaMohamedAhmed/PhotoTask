//
//  AlbumViewController.swift
//  BostaTask
//
//  Created by Aya Mohamed Ahmed on 08/09/2023.
//

import UIKit
import RxCocoa
import RxSwift

class AlbumViewController:UIViewController,UISearchBarDelegate{
    @IBOutlet weak var albumName: UILabel!
    @IBOutlet weak var photoCollectionView: UICollectionView!
    @IBOutlet weak var imagesSearchBar: UISearchBar!
    private var albumViewModel:AlbumViewModel!
    private var dispose:DisposeBag!
    private var photos:[Photo]=[]
    var album :Album!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        albumName.text = album.title
        initViewModel()
        registerCell()
        initScreenObservers()
    }
    private func initViewModel() {
        let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
        self.albumViewModel = AlbumViewModel(
            repo: appDelegate.userRepository,
            albumId:album.id ?? 0
        )
    }
    private func registerCell(){
        let nibfile = UINib(nibName: "PhotoCollectionViewCell", bundle: nil)
        photoCollectionView.register(nibfile,forCellWithReuseIdentifier: "PhotoCollectionViewCell")
    }
    
    private func initScreenObservers(){
        dispose = DisposeBag()
        
        albumViewModel.searchedPhotoListBehaviorRelay.subscribe{ photoList in
            self.reloadImagesTableView(photoList: photoList)
        }.disposed(by: dispose)
        
        albumViewModel.albumPhotosBehaviorRelay.subscribe{ photoList in
            self.reloadImagesTableView(photoList: photoList)
        }.disposed(by: dispose)
    }
    
    private func reloadImagesTableView(photoList:[Photo]){
        self.photos = photoList
        self.photoCollectionView.reloadData()
    }
    
    
}
    extension AlbumViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            albumViewModel.filterImage(title: searchText)
        }
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return photos.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionViewCell", for: indexPath) as! PhotoCollectionViewCell
        cell.setUp(photo:photos[indexPath.row].url)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width-5)/3
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
    }
}
