//
//  PhotoCollectionViewCell.swift
//  BostaTask
//
//  Created by Aya Mohamed Ahmed on 09/09/2023.
//

import UIKit
import Kingfisher

class PhotoCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
    func setUp(photo:String){
        imageView.kf.setImage(with: URL(string:photo), placeholder: UIImage(named: ""), options: nil, progressBlock: nil, completionHandler: nil)
    }
}

