//
//  AboutViewController.swift
//  Favgame
//
//  Created by deri indrawan on 29/12/22.
//

import UIKit

class AboutViewController: UIViewController {
  
  // MARK: - Properties
  private let defaults = UserDefaults.standard
  private let imagePicker = UIImagePickerController()
  
  private let coverImage: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.layer.cornerRadius = 8
    imageView.clipsToBounds = true
    imageView.contentMode = .scaleToFill
    imageView.layer.masksToBounds = true
    imageView.layer.borderWidth = 1.5
    imageView.layer.borderColor = UIColor.white.cgColor
    return imageView
  }()
  
  private let nameLabel: UILabel = {
    let label = UILabel()
    label.font = Constant.fontSemiBold
    label.numberOfLines = 1
    label.adjustsFontForContentSizeCategory = true
    label.textColor = UIColor.white
    return label
  }()
  
  private let jobLabel: UILabel = {
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
    label.numberOfLines = 1
    label.adjustsFontForContentSizeCategory = true
    label.textColor = UIColor.white
    return label
  }()
  
  // MARK: - Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = UIColor(rgb: Constant.rhinoColor)
    let barButtonImage = UIImage(systemName: "square.and.pencil")
    navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(image: barButtonImage, style: .done, target: self, action: #selector(editButtonTapped))
    let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
    self.coverImage.addGestureRecognizer(tapRecognizer)
    self.coverImage.isUserInteractionEnabled = true
    imagePicker.delegate = self
    fetchAboutData()
    setupUI()
  }
  
  // MARK: - Selector

  @objc private func imageTapped() {
    let alert = UIAlertController(title: "Update photos", message: "Choose your image resources", preferredStyle: .actionSheet)
    alert.addAction(UIAlertAction(title: "Cancle", style: .cancel, handler: { _ in
      self.dismiss(animated: true)
    }))
    
    alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { [weak self] _ in
      if let imagePicker = self?.imagePicker {
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = true
        self?.present(imagePicker, animated: true, completion: nil)
      } else {
        print("error open the camera")
      }
    }))
    
    alert.addAction(UIAlertAction(title: "Photos", style: .default, handler: { [weak self] _ in
      if let imagePicker = self?.imagePicker {
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        self?.present(imagePicker, animated: true, completion: nil)
      } else {
        print("error open photo library")
      }
    }))
    
    self.present(alert, animated: true, completion: nil)
  }
  
  // MARK: - Helper

  private func fetchAboutData() {
    let userProfile = self.defaults.object(forKey: "userProfile") as? [String: String]
    let userPhotos = UserDefaults.standard.data(forKey: "userPhotos") ?? Data()
    if userPhotos.isEmpty {
      coverImage.image = UIImage(named: "profileImage")
    } else {
      let decoded = try! PropertyListDecoder().decode(Data.self, from: userPhotos)
      coverImage.image = UIImage(data: decoded)
    }
    nameLabel.text = userProfile?["name"] ?? "Deri Indrawan"
    jobLabel.text = userProfile?["job"] ?? "Software Engineer"
    descriptionLabel.text = userProfile?["description"] ?? "Curious about anything"
  }
  
  private func setupUI() {
    view.addSubview(coverImage)
    coverImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    coverImage.anchor(
      top: view.safeAreaLayoutGuide.topAnchor,
      width: 120,
      height: 120
    )
    
    view.addSubview(nameLabel)
    nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    nameLabel.anchor(
      top: coverImage.bottomAnchor,
      paddingTop: 16
    )
    
    view.addSubview(jobLabel)
    jobLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    jobLabel.anchor(
      top: nameLabel.bottomAnchor,
      paddingTop: 16
    )
    
    view.addSubview(descriptionLabel)
    descriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    descriptionLabel.anchor(
      top: jobLabel.bottomAnchor,
      paddingTop: 24
    )
  }
  
}

extension AboutViewController: UIAlertViewDelegate {
  @objc private func editButtonTapped() {
    let alert = UIAlertController(title: "Update profile", message: nil, preferredStyle: .alert)
    
    alert.addTextField { (name) in
      name.text = self.nameLabel.text
    }
    alert.addTextField { (job) in
      job.text = self.jobLabel.text
    }
    alert.addTextField { (description) in
      description.text = self.descriptionLabel.text
    }
    
    alert.addAction(UIAlertAction(title: "Cancle", style: .cancel, handler: { _ in
      self.dismiss(animated: true)
    }))
    
    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
      let name = alert?.textFields![0].text
      let job = alert?.textFields![1].text
      let description = alert?.textFields![2].text
      let data = ["name": name, "job": job, "description": description]
      self.defaults.set(data, forKey: "userProfile")
      self.nameLabel.text = name
      self.jobLabel.text = job
      self.descriptionLabel.text = description
    }))
    
    self.present(alert, animated: true, completion: nil)
  }
}

extension AboutViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    var pickedImage = UIImage()
    if imagePicker.sourceType == .camera {
      pickedImage = (info[UIImagePickerController.InfoKey.editedImage] as? UIImage)!
    } else {
      pickedImage = (info[UIImagePickerController.InfoKey.originalImage] as? UIImage)!
    }
    
    let data = pickedImage.jpegData(compressionQuality: 0.5)
    let encoded = try! PropertyListEncoder().encode(data)
    self.defaults.set(encoded, forKey: "userPhotos")
    self.coverImage.image = pickedImage
    imagePicker.dismiss(animated: true, completion: nil)
  }
}
