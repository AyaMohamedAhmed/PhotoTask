//
//  HomeViewController.swift
//  BostaTask
//
//  Created by Aya Mohamed Ahmed on 08/09/2023.
//

import UIKit
import RxSwift

class HomeViewController: UIViewController {
    @IBOutlet weak var myAlbumsCollectionView: UICollectionView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var errorImage: UIImageView!
    @IBOutlet weak var myAlbumsLbl: UILabel!
    @IBOutlet weak var profileLbl: UILabel!
    private var albums:[Album]=[]
    private var homeVM:HomeViewModel!
    private var dispose:DisposeBag!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewModel()
        registerCells()
        flowLayout()
        initScreenContent()
    }
    
    private func initViewModel() {
        let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
        self.homeVM = HomeViewModel(
            repo: appDelegate.userRepository,
            userId: appDelegate.userId
        )
    }
    
    private func initScreenContent(){
        //init disposable
        dispose = DisposeBag()
        
        //subscribe user info
        homeVM.userPublishSubject.subscribe { user in
            self.userName.text = user.element?.name
            self.setUpAddress(address: user.element!.address)
        }.disposed(by: dispose)
        
        //subscribe user album list
        homeVM.albumPublishSubject.subscribe { albumList in
            self.albums = albumList
            self.myAlbumsCollectionView.reloadData()
        }.disposed(by: dispose)
        
        homeVM.viewState.subscribe { uiState in
            switch uiState.element {
            case .loading:
                self.loadingState()
            case .success:
                self.sucessState()
            default:
                self.errorState()

            }
            
        }.disposed(by: dispose)
    }
    
    private func registerCells(){
        let nibfile = UINib(nibName: "AlbumCollectionViewCell", bundle: nil)
        myAlbumsCollectionView.register(nibfile,forCellWithReuseIdentifier: "AlbumsCollectionViewCell")
    }
    private func setUpAddress(address:Address){
        self.address.text = address.street + ", " + address.suite + ", " + address.city + ", " + address.zipcode
    }
    private func flowLayout(){
        let myAlbumsFlowLayout = UICollectionViewFlowLayout()
        myAlbumsFlowLayout.scrollDirection = UICollectionView.ScrollDirection.vertical
        myAlbumsCollectionView.collectionViewLayout=myAlbumsFlowLayout
    }
    
    private func sucessState(){
        self.baseView.isHidden = true
        self.indicator.isHidden = true
        self.errorImage.isHidden = true
        self.userName.isHidden = false
        self.address.isHidden = false
        self.myAlbumsCollectionView.isHidden = false
        self.profileLbl.isHidden = false
        self.myAlbumsLbl.isHidden = false
    }
    private func loadingState(){
        self.userName.isHidden = true
        self.address.isHidden = true
        self.myAlbumsCollectionView.isHidden = true
        self.errorImage.isHidden = true
        self.profileLbl.isHidden = true
        self.myAlbumsLbl.isHidden = true
    }
    
    private func errorState(){
        self.userName.isHidden = true
        self.address.isHidden = true
        self.myAlbumsCollectionView.isHidden = true
        self.indicator.isHidden = true
        self.profileLbl.isHidden = true
        self.myAlbumsLbl.isHidden = true
        self.baseView.isHidden = false
        self.errorImage.isHidden = false
    }
  }

extension HomeViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return albums.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AlbumsCollectionViewCell", for: indexPath) as! AlbumsCollectionViewCell
        cell.setUp(albumsDetails:albums[indexPath.row])
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (myAlbumsCollectionView.bounds.width - 25), height: (myAlbumsCollectionView.bounds.height-5)/10
        )
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let albumViewController=self.storyboard?.instantiateViewController(withIdentifier: "AlbumViewController") as! AlbumViewController
        albumViewController.album = albums[indexPath.row]
        self.navigationController?.pushViewController(albumViewController, animated: true)
    }
}
