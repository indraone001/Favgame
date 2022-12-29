//
//  DetailHeaderView.swift
//  Favgame
//
//  Created by deri indrawan on 28/12/22.
//

import UIKit
import Kingfisher

class DetailHeaderView: UICollectionReusableView {
  static let identifier = "DetailHeaderView"
  
  // MARK: - Properties
  private let coverImage: UIImageView = {
    let imageView = UIImageView()
    imageView.layer.cornerRadius = 8
    imageView.clipsToBounds = true
    imageView.contentMode = .scaleAspectFill
    return imageView
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = UIColor(rgb: Constant.rhinoColor)
    setupUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Helper
  private func setupUI() {
    addSubview(coverImage)
    coverImage.anchor(
      top: safeAreaLayoutGuide.topAnchor,
      leading: leadingAnchor,
      trailing: trailingAnchor,
      height: 300
    )
  }
  
  func configure(with gameDetail: GameDetail) {
    guard let url = URL(string: gameDetail.backgroundImage) else { return }
    coverImage.kf.setImage(with: url)
  }

}
