//
//  UITableView+Ext.swift
//  Favgame
//
//  Created by deri indrawan on 29/12/22.
//

import UIKit

extension UITableView {
  
  func setEmptyMessage(_ message: String) {
    let contentView = UIView(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
    
    let image = UIImage(systemName: "doc.fill")
    let imageView = UIImageView(frame: CGRect(x: contentView.bounds.size.width/2 - 150/2, y: contentView.bounds.size.height/2 - 150, width: 150, height: 150))
    imageView.image = image
    imageView.tintColor = .white
    
    let messageLabel = UILabel(frame: CGRect(x: 0, y: contentView.bounds.size.height/2 + 10, width: contentView.bounds.size.width, height: 60))
    messageLabel.text = message
    messageLabel.numberOfLines = 0
    messageLabel.textColor = .white
    messageLabel.textAlignment = .center
    messageLabel.font = UIFont.systemFont(ofSize: 17)
    
    contentView.addSubview(imageView)
    contentView.addSubview(messageLabel)
    
    self.backgroundView = contentView
  }
  
  func restore() {
    self.backgroundView = nil
  }
}
