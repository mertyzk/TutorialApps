//
//  DetailViewController.swift
//  LandmarkBookApplication
//
//  Created by Macbook Air on 15.02.2022.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var labelArea: UILabel!
    
    var name:String?
    var image = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        labelArea.text = name
        imageView.image = image
        navigationItem.title = name
    }
    


}
