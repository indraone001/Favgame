//
//  GameCollectionViewCell.swift
//  Favgame
//
//  Created by deri indrawan on 28/12/22.
//

import UIKit
import Kingfisher
import SkeletonView

class GameCollectionViewCell: UICollectionViewCell {
  static let identifier = "GameCollectionViewCell"
  
  // MARK: - Properties
  private let coverImage: UIImageView = {
    let imageView = UIImageView()
    imageView.layer.cornerRadius = 8
    imageView.clipsToBounds = true
    imageView.contentMode = .scaleAspectFill
    return imageView
  }()
  
  private let title: UILabel = {
    let label = UILabel()
    label.font = Constant.fontMedium
    label.numberOfLines = 1
    label.adjustsFontForContentSizeCategory = true
    label.textColor = UIColor.white
    return label
  }()
  
  private let released: UILabel = {
    let label = UILabel()
    label.font = Constant.fontRegular
    label.numberOfLines = 1
    label.adjustsFontForContentSizeCategory = true
    label.textColor = UIColor.white
    return label
  }()
  
  private let rateContainer: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.distribution = .fillProportionally
    stackView.alignment = .center
    stackView.spacing = 8
    return stackView
  }()
  
  private let rateIcon: UIImageView = {
    let imageView = UIImageView()
    let image = UIImage(systemName: "star.fill")
    imageView.image = image
    imageView.tintColor = .systemYellow
    return imageView
  }()
  
  private let rate: UILabel = {
    let label = UILabel()
    label.font = Constant.fontRegular
    label.numberOfLines = 1
    label.adjustsFontForContentSizeCategory = true
    label.textColor = UIColor.white
    return label
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = UIColor(rgb: Constant.rumColor)
    layer.cornerRadius = 8
    layer.shadowOffset = CGSize(width: 0, height: 0)
    layer.shadowColor = UIColor.black.cgColor
    layer.shadowOpacity = 0.35
    layer.shadowRadius = 2
    isSkeletonable = true
    skeletonCornerRadius = 8
    setupUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Helper
  private func setupUI() {
    addSubview(coverImage)
    coverImage.anchor(
      top: topAnchor,
      leading: leadingAnchor,
      trailing: trailingAnchor,
      paddingTop: 8,
      paddingLeft: 8,
      paddingRight: 8,
      height: 160
    )
    
    addSubview(title)
    title.anchor(
      top: coverImage.bottomAnchor,
      leading: leadingAnchor,
      trailing: trailingAnchor,
      paddingTop: 8,
      paddingLeft: 8,
      paddingRight: 8
    )
    
    addSubview(released)
    released.anchor(
      top: title.bottomAnchor,
      leading: leadingAnchor,
      trailing: trailingAnchor,
      paddingTop: 16,
      paddingLeft: 8,
      paddingRight: 8
    )
    
    addSubview(rateContainer)
    rateContainer.addArrangedSubview(rateIcon)
    rateIcon.anchor(
      width: 16,
      height: 16
    )
    rateContainer.addArrangedSubview(rate)
    rateContainer.anchor(
      top: released.bottomAnchor,
      leading: leadingAnchor,
      trailing: trailingAnchor,
      paddingTop: 8,
      paddingLeft: 8,
      paddingRight: 8
    )
  }
  
  func configure(with game: Game) {
    guard let url = URL(string: game.backgroundImage) else { return }
    coverImage.kf.setImage(with: url)
    title.text = game.name
    released.text = game.released
    rate.text = "\(game.rating)"
  }

}
