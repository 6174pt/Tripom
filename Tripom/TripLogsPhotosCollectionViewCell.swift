//
//  TripLogsPhotosCollectionViewCell.swift
//  Tripom
//
//  Created by Honoka Nishiyama on 2024/05/29.
//

import UIKit

class TripLogsPhotosCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var tripPhotosImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupCell(photo: TripPhotos) {
//        if let imageName = photo.imageName {
//            // ローカルに保存された画像をロード
//            let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
//            let fileURL = documentsDirectory.appendingPathComponent(imageName)
//            tripPhotosImageView.image = UIImage(contentsOfFile: fileURL.path)
//        }
    }
}
