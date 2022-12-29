//
//  GameTableViewCell.swift
//  Favgame
//
//  Created by deri indrawan on 29/12/22.
//

import UIKit
import SkeletonView
import Kingfisher

class GameTableViewCell: UITableViewCell {
  static let identifier = "GameTableViewCell"
  
  // MARK: - Properties
  private let coverImage: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleToFill
    imageView.layer.cornerRadius = 8
    imageView.layer.masksToBounds = true
    return imageView
  }()
  
  private let itemContainer: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.alignment = .leading
    stackView.spacing = 6
    return stackView
  }()
  
  private let title: UILabel = {
    let label = UILabel()
    label.textAlignment = .left
    label.font = Constant.fontMedium
    label.textColor = .white
    label.adjustsFontForContentSizeCategory = true
    label.numberOfLines = 2
    return label
  }()
  
  private let released: UILabel = {
    let label = UILabel()
    label.font = Constant.fontRegular
    label.numberOfLines = 1
    label.adjustsFontForContentSizeCategory = true
    label.textColor = .white
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
    label.textColor = .white
    return label
  }()
  
  // MARK: - Life Cycle
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    backgroundColor = UIColor(rgb: Constant.rumColor)
    isSkeletonable = true
    skeletonCornerRadius = 16
    setupUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Helper
  private func setupUI() {
    contentView.addSubview(coverImage)
    coverImage.anchor(
      top: contentView.topAnchor,
      leading: contentView.leadingAnchor,
      bottom: contentView.bottomAnchor,
      paddingTop: 8,
      paddingLeft: 8,
      paddingBottom: 8,
      width: 104
    )
    
    itemContainer.addArrangedSubview(title)
    itemContainer.addArrangedSubview(released)
    itemContainer.addArrangedSubview(rateContainer)
    
    contentView.addSubview(itemContainer)
    itemContainer.anchor(
      top: contentView.topAnchor,
      leading: coverImage.trailingAnchor,
      bottom: contentView.bottomAnchor,
      trailing: contentView.trailingAnchor,
      paddingTop: 8,
      paddingLeft: 8,
      paddingBottom: 8,
      paddingRight: 8
    )
    
    rateContainer.addArrangedSubview(rateIcon)
    rateIcon.anchor(
      width: 16,
      height: 16
    )

    rateContainer.addArrangedSubview(rate)
    rateContainer.anchor(
      leading: itemContainer.leadingAnchor,
      trailing: itemContainer.trailingAnchor
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
