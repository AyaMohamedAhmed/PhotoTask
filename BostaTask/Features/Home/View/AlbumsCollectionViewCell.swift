//
//  AlbumCollectionViewCell.swift
//  BostaTask
//
//  Created by Aya Mohamed Ahmed on 08/09/2023.
//

import UIKit

class AlbumsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var albumName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setUp(albumsDetails:Album){
        albumName.text = albumsDetails.title
        
    }
}
