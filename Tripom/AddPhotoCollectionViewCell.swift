//
//  AddPhotoCollectionViewCell.swift
//  Tripom
//
//  Created by Honoka Nishiyama on 2024/05/31.
//

import UIKit

class AddPhotoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var addPhotoButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        var configuration = UIButton.Configuration.plain()
        configuration.image = UIImage(systemName: "plus.circle")
        
        // 画像の配置やパディングを設定
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        configuration.imagePadding = 8
        configuration.imagePlacement = .top
        
        let container = AttributeContainer([
            .font: UIFont.systemFont(ofSize: 12)
        ])
        configuration.attributedTitle = AttributedString("写真を追加する", attributes: container)
        
        configuration.baseForegroundColor = .white
        
        // ボタンに設定を適用
        addPhotoButton.configuration = configuration
//        addPhotoButton.setTitle("写真を追加する", for: .normal)
        
        // レイアウトの設定
        addPhotoButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addPhotoButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            addPhotoButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            addPhotoButton.topAnchor.constraint(equalTo: contentView.topAnchor),
            addPhotoButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
}
