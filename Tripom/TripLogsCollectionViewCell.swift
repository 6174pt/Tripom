//
//  CustomCell.swift
//  Tripom
//
//  Created by Honoka Nishiyama on 2024/05/28.
//

import UIKit

class TripLogsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var tripImageView: UIImageView!
    @IBOutlet var tripDateLabel: UILabel!
    @IBOutlet var tripSpotLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
            
        tripDateLabel.text = ""
        tripSpotLabel.text = ""
        tripImageView.image = UIImage()
        }
    
    func setupCell(tripDate: String, tripSpot: String, imageName: String) {
        tripDateLabel.text = tripDate
        tripSpotLabel.text = tripSpot
        tripImageView.image = UIImage(named: imageName)
    }

}
