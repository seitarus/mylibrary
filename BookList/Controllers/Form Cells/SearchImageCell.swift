//
//  BookCell.swift
//  Biblioteca
//
//  Created by Alejandro Prieto Beltrán on 05/01/2021.
//  Copyright © 2021 Razeware. All rights reserved.
//

import Foundation
import UIKit

class SearchImageCollectionViewCell: UICollectionViewCell {

  @IBOutlet weak var bookImage: UIImageView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    setup()
  }
  
  override func prepareForReuse() {
    
    super.prepareForReuse()
    
    setup()
  }
  
  func setup()
  {
    bookImage.image = UIImage(named: "no-img")
  }
}
