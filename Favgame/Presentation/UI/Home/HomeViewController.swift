//
//  HomeViewController.swift
//  Favgame
//
//  Created by deri indrawan on 27/12/22.
//

import UIKit
import Combine
import SkeletonView

class HomeViewController: UIViewController {
  // MARK: - Properties
  var getListGameUseCase: GetListGameUseCase?
  private var gameList: [Game]?
  
  private let appTitle: UILabel = {
    let label = UILabel()
    let atributedTitle = NSMutableAttributedString(string: "Favgame", attributes: [
      NSAttributedString.Key.font: Constant.fontBold,
      NSAttributedString.Key.foregroundColor: UIColor.white
    ])
    label.attributedText = atributedTitle
    return label
  }()
  
  private let gameCollectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    layout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.isSkeletonable = true
    collectionView.showsHorizontalScrollIndicator = false
    collectionView.register(GameCollectionViewCell.self, forCellWithReuseIdentifier: GameCollectionViewCell.identifier)
    return collectionView
  }()
  
  // MARK: - Life Cycle
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    self.tabBarController?.tabBar.isHidden = false
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = UIColor(rgb: Constant.rhinoColor)
    setupUI()
  }
  
  // MARK: - Helper
  private func setupUI() {
    navigationController?.navigationBar.isHidden = true
    
    view.addSubview(appTitle)
    appTitle.anchor(
      top: view.safeAreaLayoutGuide.topAnchor,
      leading: view.leadingAnchor,
      paddingTop: 16,
      paddingLeft: 10
    )
    
    view.addSubview(gameCollectionView)
    gameCollectionView.dataSource = self
    gameCollectionView.delegate = self
    gameCollectionView.anchor(
      top: appTitle.bottomAnchor,
      leading: view.leadingAnchor,
      bottom: view.bottomAnchor,
      trailing: view.trailingAnchor,
      paddingTop: 8
    )
  }
  
}

extension HomeViewController: SkeletonCollectionViewDataSource, SkeletonCollectionViewDelegate, UICollectionViewDelegateFlowLayout {
  func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> SkeletonView.ReusableCellIdentifier {
    return GameCollectionViewCell.identifier
  }
  
  func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 10
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return gameList?.count ?? 0
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let gameCell = collectionView.dequeueReusableCell(
        withReuseIdentifier: GameCollectionViewCell.identifier,
        for: indexPath
    ) as? GameCollectionViewCell else {
        return UICollectionViewCell()
    }
    
    guard let gameList = gameList else { return UICollectionViewCell() }
    let game = gameList[indexPath.row]
    gameCell.configure(with: game)
    
    return gameCell
  }
  
  // MARK: - UICollectionViewDelegateFlowLayout
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: view.frame.width / 2 - 16, height: 300)
  }
}
