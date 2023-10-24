//
//  DetailViewController.swift
//  ECommerceApp
//
//  Created by Shweta Gupta on 13/10/23.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var addToCartButton: UIButton!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var priceTitleLabel: UILabel!
    @IBOutlet weak var ratingCountLabel: UILabel!
    @IBOutlet weak var productRatingLabel: UILabel!
    @IBOutlet weak var DescrNameLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productTypeLabel: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    
    var productType: String = ""
    var product: String = ""
    var desc: String = ""
    var DescrName: String = ""
    var productRating: String = ""
    var ratingCount: String = ""
    var priceTitle: String = ""
    var price: String = ""
    var myImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        bottomView.layer.cornerRadius = 10.0
        bottomView.layer.masksToBounds = false
        bottomView.layer.shadowOffset = CGSize(width: -1, height: 1)
        bottomView.layer.shadowRadius = 1
        bottomView.layer.shadowOpacity = 0.5
        
        productImage.image = myImage
        productTypeLabel.text = productType
        productName.text = product
        descLabel.text = desc
        DescrNameLabel.text = DescrName
        productRatingLabel.text = productRating
        ratingCountLabel.text = ratingCount
        priceTitleLabel.text = priceTitle
        priceLabel.text = price
        
        addToCartButton.layer.cornerRadius = 10.0
    }


}
