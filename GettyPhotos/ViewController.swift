//
//  ViewController.swift
//  GettyPhotos
//
//  Created by seungchul lee on 2020/11/19.
//

import UIKit
import Kanna

class ViewController: UIViewController {
    
    @IBOutlet var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        self.makeDataFromHtml("https://www.gettyimagesgallery.com/collection/slim-aarons/")
    }
    
    func makeDataFromHtml(_ urlString: String) {
        if let main = URL(string: urlString) {
            do {
                let HtmlString = try String(contentsOf: main, encoding: .utf8)
                let doc = try HTML(html: HtmlString, encoding: .utf8)
                
                for product in doc.xpath("//div[@class='item-wrapper']") {
                    if let productImageURL = product.at_xpath("//img/@src | img/@data-src"){
                        if let urlText = productImageURL.text {
                            print(urlText)
                        }
                    }
                    
                    if let productTitle = product.at_xpath("//img/@alt"){
                        if let title = productTitle.text {
                            print(title)
                        }
                    }
                }
            } catch let error {
                print("Error: \(error)")
            }
            
        } else {
            print("Error: doesn't seem to be a valid URL")
            return
        }
    }
}

