//
//  DetailsViewController.swift
//  SimpsonBook
//
//  Created by Macbook Air on 16.02.2022.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var jobLabel: UILabel!
    
    var simpson:Simpsons?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let simpson = simpson {
            navigationItem.title = simpson.name
            nameLabel.text = simpson.name
            jobLabel.text = simpson.job
            imageView.image = UIImage(named: simpson.image!)
        }
        
        
        
    }

}
