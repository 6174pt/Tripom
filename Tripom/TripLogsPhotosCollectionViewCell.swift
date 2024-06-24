//
//  TripLogsPhotosCollectionViewCell.swift
//  Tripom
//
//  Created by Honoka Nishiyama on 2024/05/29.
//

import UIKit

protocol CustomCollectionViewCellDelegate: AnyObject {
    func didTapDeleteButton(in cell: TripLogsPhotosCollectionViewCell)
}

class TripLogsPhotosCollectionViewCell: UICollectionViewCell {
    
    weak var delegate: CustomCollectionViewCellDelegate?
    
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
    
    let menuButton: UIButton = {
        let button = UIButton(type: .system)
        // カスタムアイコンの設定
        if let ellipsisImage = UIImage(systemName: "ellipsis")?.withRenderingMode(.alwaysTemplate) {
            let rotatedImage = UIImage(cgImage: ellipsisImage.cgImage!, scale: ellipsisImage.scale, orientation: .right)
            button.setImage(rotatedImage, for: .normal)
        }
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupMenuButton()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupMenuButton()
    }

    private func setupMenuButton() {
        contentView.addSubview(menuButton)
        NSLayoutConstraint.activate([
            menuButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            menuButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            menuButton.widthAnchor.constraint(equalToConstant: 24),
            menuButton.heightAnchor.constraint(equalToConstant: 24)
        ])

        // ボタンにメニューを設定
        let deleteAction = UIAction(title: "削除", image: UIImage(systemName: "trash"), attributes: .destructive) { [weak self] action in
            guard let self = self else { return }
            self.delegate?.didTapDeleteButton(in: self)
        }
        let menu = UIMenu(title: "", children: [deleteAction])
        menuButton.menu = menu
        menuButton.showsMenuAsPrimaryAction = true
    }
    
    
}


