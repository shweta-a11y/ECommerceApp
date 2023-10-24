//
//  ProductCollectionViewCell.swift
//  ECommerceApp
//
//  Created by Shweta Gupta on 12/10/23.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
  
    
    var product = UIImage()
    override func awakeFromNib() {
          super.awakeFromNib()
          // Initialization code
       
      }
      
     
}
