//
//  BaseViewController.swift
//  Favgame
//
//  Created by deri indrawan on 27/12/22.
//

import UIKit

class BaseViewController: UITabBarController {
  //MARK: - Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupBottomNav()
  }

  private func setupBottomNav() {
    let homeImage = UIImage(systemName: "house")
//    let homeVC = Injection().container.resolve(HomeViewController.self)
//    let home = templateNavigationController(image: homeImage, rootViewController: homeVC!, title: "Home")
    
  }
  
}
