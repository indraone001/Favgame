//
//  DetailViewController.swift
//  Favgame
//
//  Created by deri indrawan on 28/12/22.
//

import UIKit
import Combine
import SkeletonView

class DetailViewController: UIViewController {
  // MARK: - Properties
  var getGameDetailUseCase: GetGameDetailUseCase?
  private var cancellables: Set<AnyCancellable> = []
  private var gameDetail: GameDetail?
  private var gameId: Int?
  
  private let detailCollectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    layout.minimumInteritemSpacing = 0
    layout.minimumLineSpacing = 0
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.backgroundColor = UIColor(rgb: Constant.rhinoColor)
    collectionView.isSkeletonable = true
    collectionView.showsHorizontalScrollIndicator = false
    collectionView.register(
      DetailHeaderView.self,
      forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
      withReuseIdentifier: DetailHeaderView.identifier
    )
    collectionView.register(
      DetailDesccriptionCollectionViewCell.self,
      forCellWithReuseIdentifier: DetailDesccriptionCollectionViewCell.identifier
    )
    return collectionView
  }()
  
  // MARK: - Life Cycle
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = UIColor(rgb: Constant.rhinoColor)
    self.tabBarController?.tabBar.isHidden = true
    
    let button = UIButton(type: .system)
    button.setTitle("Back", for: .normal)
    button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
    button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
    
    let favoriteButton = UIButton(type: .system)
    favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
    favoriteButton.tintColor = .systemRed
    favoriteButton.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
    navigationItem.rightBarButtonItem = UIBarButtonItem(customView: favoriteButton)
    
    setupUI()
    fetchGameDetail()
  }
  
  // MARK: - Selector
  @objc private func backButtonTapped() {
    dismiss(animated: true)
  }
  
  @objc private func favoriteButtonTapped() {
    print("Favorite Button Tapped")
  }
  
  // MARK: - Helper
  private func setupUI() {
    view.addSubview(detailCollectionView)
    detailCollectionView.anchor(
      top: view.topAnchor,
      leading: view.leadingAnchor,
      bottom: view.bottomAnchor,
      trailing: view.trailingAnchor
    )
    detailCollectionView.delegate = self
    detailCollectionView.dataSource = self
  }
  
  private func fetchGameDetail() {
    guard let gameId = gameId else { return }
    getGameDetailUseCase?.execute(withGameId: gameId)
      .receive(on: RunLoop.main)
      .sink(receiveCompletion: { completion in
        switch completion {
        case .failure:
          let alert = UIAlertController(title: "Alert", message: String(describing: completion), preferredStyle: .alert)
          alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
          self.present(alert, animated: true)
        case .finished:
          self.detailCollectionView.reloadData()
        }
      }, receiveValue: { gameDetail in
        self.gameDetail = gameDetail
      })
      .store(in: &cancellables)
  }
  
  func configure(withAnimeId id: Int) {
    gameId = id
  }
  
}

extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  // MARK: - UICollectionViewDataSource
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: DetailDesccriptionCollectionViewCell.identifier,
      for: indexPath
    ) as? DetailDesccriptionCollectionViewCell else { return UICollectionViewCell() }
    
    if gameDetail != nil {
      cell.configure(with: gameDetail!)
    }
    return cell
  }
  
  // MARK: - UICollectionViewDelegate
  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    guard let header = collectionView.dequeueReusableSupplementaryView(
      ofKind: UICollectionView.elementKindSectionHeader,
      withReuseIdentifier: DetailHeaderView.identifier,
      for: indexPath
    ) as? DetailHeaderView else { return UICollectionReusableView() }
    
    if gameDetail != nil {
      header.configure(with: gameDetail!)
    }
    
    return header
  }
  
  // MARK: - UICollectionViewDelegateFlowLayout
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
    return CGSize(width: view.frame.width, height: 300)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: view.frame.width, height: 1000)
  }
  
}
