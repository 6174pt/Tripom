//
//  TripLogPhotosCollectionViewCell.swift
//  Tripom
//
//  Created by Honoka Nishiyama on 2024/06/06.
//

import UIKit

protocol TripLogPhotosCollectionViewCellDelegate: AnyObject {
    func didTapDeleteButton(in cell: TripLogPhotosCollectionViewCell)
}

class TripLogPhotosCollectionViewCell: UICollectionViewCell {
    
    weak var delegate: TripLogPhotosCollectionViewCellDelegate?
    
    @IBOutlet var tripPhotosImageView: UIImageView!
    var isEditingMode: Bool = false {
            didSet {
                menuButton.isHidden = !isEditingMode
            }
        }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
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
            print("delegate.delete")
        }
        let menu = UIMenu(title: "", children: [deleteAction])
        menuButton.menu = menu
        menuButton.showsMenuAsPrimaryAction = true
        menuButton.isHidden = !isEditingMode
    }

}
