//
//  CustomCell.swift
//  Tripom
//
//  Created by Honoka Nishiyama on 2024/05/28.
//

import UIKit

class TripLogsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var tripThumbnailImageView: UIImageView!
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
        tripThumbnailImageView.image = UIImage()
        }
    
    func setupCell(tripDate: String, tripSpot: String, imageName: String) {
        print("cell")
        tripDateLabel.text = tripDate
        tripSpotLabel.text = tripSpot
        //URL型にキャスト
//        let fileURL = URL(string: imageName)
//        print("imageName", imageName)
//        //パス型に変換
//        guard let filePath = fileURL?.path else { return }
//        print("filePath", filePath)
//        tripThumbnailImageView.image = UIImage(contentsOfFile: filePath)
        
        
//        if let url = URL(string: imageName),
//           let data = try? Data(contentsOf: url),
//           let image = UIImage(data: data) {
//            tripThumbnailImageView.image = image
//        } else {
//            // 画像読み込みに失敗した場合、デフォルト画像を設定する
//            tripThumbnailImageView.image = UIImage(named: "defaultImage")
//        }
        
        if let fileURL = URL(string: imageName) {
            // ファイルパスを取得
            let filePath = fileURL.path
            print("filePath", filePath)
            
            // FileManagerを使用してファイルの存在を確認
            let fileManager = FileManager.default
            if fileManager.fileExists(atPath: filePath) {
                print("ファイルは存在します")
                // ファイルが存在する場合、UIImageを設定
                if let data = try? Data(contentsOf: fileURL),
                   let image = UIImage(data: data) {
                    tripThumbnailImageView.image = image
                } else {
                    print("ファイルは存在しますが、UIImageに変換できません")
                    tripThumbnailImageView.image = UIImage(named: "defaultImage")
                }
            } else {
                print("ファイルが存在しません")
                tripThumbnailImageView.image = UIImage(named: "defaultImage")
            }
        } else {
            print("無効なURLです")
            tripThumbnailImageView.image = UIImage(named: "defaultImage")
        }
        
    }
    
}
