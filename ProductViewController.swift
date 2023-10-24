//
//  ProductViewController.swift
//  ECommerceApp
//
//  Created by Shweta Gupta on 13/10/23.
//

import UIKit

class ProductViewController: UIViewController, UICollectionViewDataSource,UICollectionViewDelegate {
    
    var collectionViewData : [ProductModel] = []
    let margin: CGFloat = 10
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .systemGray3
       
        guard let collectionView = collectionView, let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }

            flowLayout.minimumInteritemSpacing = margin
            flowLayout.minimumLineSpacing = margin
            flowLayout.sectionInset = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
        APIcall()
        
        collectionView.reloadData()
    }

    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionViewData.count
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCollectionViewCell", for: indexPath as IndexPath) as! ProductCollectionViewCell
        
        cell.backgroundColor = UIColor.white // make cell more visible in our example project
        
        let product = collectionViewData[indexPath.row]

        // Assuming you have the URL of the image
        if let imageURLString = product.image, let imageURL = URL(string: imageURLString) {
            let task = URLSession.shared.dataTask(with: imageURL) { (data, response, error) in
                if let error = error {
                    // Handle the error, for example, by logging it or showing an alert
                    print("Error downloading image: \(error)")
                } else if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        cell.productImage.image = image
                        cell.descLabel.text = product.description
                        cell.priceLabel.text = String(product.price ?? 0.0)
                        cell.ratingLabel.text = String(product.rating?.rate ?? 0.0)
                        cell.productNameLabel.text = product.title
                    }
                }
            }
            task.resume()
        }
    
        return cell
       
    }


    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        
        let noOfCellsInRow = 2

           let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout

           let totalSpace = flowLayout.sectionInset.left
               + flowLayout.sectionInset.right
               + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))

           let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))

           return CGSize(width: size, height: size)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat
    {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
    {
        let sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return sectionInset
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
           let vc = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
   
        let product = collectionViewData[indexPath.row]
        
        if let imageURLString = product.image, let imageURL = URL(string: imageURLString) {
            let task = URLSession.shared.dataTask(with: imageURL) { (data, response, error) in
                if let error = error {
                            // Handle the error, for example, by logging it or showing an alert
                            print("Error downloading image: \(error)")
                        } else if let data = data, let image = UIImage(data: data) {
                                vc.myImage = image
                        }
            }
            task.resume()
        }
        vc.product = product.title ?? ""
        vc.productType = product.category ?? ""
        vc.desc = "Description"
        vc.DescrName = product.description ?? ""
        vc.productRating = "Rating"
        vc.ratingCount = String(product.rating?.count ?? Int(0.0))
        vc.priceTitle = String(product.price ?? 0.0)
        vc.price = "Price"
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    func APIcall(){
        if let url = URL(string: "https://fakestoreapi.com/products") {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    print("Error: \(error)")
                    return
                }
                
                if let data = data {
                    do {

                        self.collectionViewData = try JSONDecoder().decode([ProductModel].self, from: data)
                        DispatchQueue.main.async {
 
                            self.collectionView.reloadData()
                       }
                      
                    } catch {
                        print("JSON parsing error: \(error)")
                    }
                }
            }
            task.resume()
        } else {
            print("Invalid URL")
        }
    }
   

}
