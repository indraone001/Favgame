//
//  DetailDescriptionView.swift
//  Favgame
//
//  Created by deri indrawan on 29/12/22.
//

import UIKit

class DetailDesccriptionCollectionViewCell: UICollectionViewCell {
  static let identifier = "DetailDescriptionCollectionViewCell"
  
  // MARK: - Properties
  private let title: UILabel = {
    let label = UILabel()
    label.textColor = .white
    label.font = Constant.fontSemiBold
    label.numberOfLines = 2
    label.adjustsFontForContentSizeCategory = true
    return label
  }()
  
  private let released: UILabel = {
    let label = UILabel()
    label.textColor = .white
    label.font = Constant.fontMedium
    label.numberOfLines = 1
    label.adjustsFontForContentSizeCategory = true
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
    label.font = Constant.fontMedium
    label.numberOfLines = 1
    label.adjustsFontForContentSizeCategory = true
    label.textColor = UIColor.white
    return label
  }()
  
  private let descriptionLabel: UILabel = {
    let label = UILabel()
    label.font = Constant.fontMedium
    label.numberOfLines = 0
    label.adjustsFontForContentSizeCategory = true
    label.textColor = UIColor.white
    return label
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = UIColor(rgb: Constant.eastBayColor)
    setupUI()
  }
  
  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Helper
  private func setupUI() {
    addSubview(title)
    title.anchor(
      top: safeAreaLayoutGuide.topAnchor,
      leading: leadingAnchor,
      paddingTop: 16,
      paddingLeft: 12
    )
    
    addSubview(released)
    released.anchor(
      top: title.bottomAnchor,
      leading: leadingAnchor,
      paddingTop: 16,
      paddingLeft: 12
    )

    addSubview(rateContainer)
    rateContainer.addArrangedSubview(rateIcon)
    rateIcon.anchor(
      width: 20,
      height: 20
    )
    rateContainer.addArrangedSubview(rate)
    rateContainer.anchor(
      top: released.bottomAnchor,
      leading: leadingAnchor,
      trailing: trailingAnchor,
      paddingTop: 8,
      paddingLeft: 12
    )
    
    addSubview(descriptionLabel)
    descriptionLabel.anchor(
      top: rateContainer.bottomAnchor,
      leading: leadingAnchor,
      trailing: trailingAnchor,
      paddingTop: 16,
      paddingLeft: 12,
      paddingRight: 12
    )
  }
  
  func configure(with gameDetail: GameDetail) {
    title.text = gameDetail.name
    released.text = gameDetail.released
    rate.text = "\(gameDetail.rating)"
    descriptionLabel.text = gameDetail.descriptionRaw
  }

}
