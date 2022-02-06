//
//  YemekTableViewCell.swift
//  DetailedTableViewUsage
//
//  Created by Macbook Air on 6.02.2022.
//

import UIKit

protocol YemekTableViewCellProtocol{
    func siparisVer(indexPath:IndexPath)
}

class YemekTableViewCell: UITableViewCell {

    @IBOutlet weak var yemekResimImageView: UIImageView!
    @IBOutlet weak var yemekAdiLabel: UILabel!
    @IBOutlet weak var yemekFiyatLabel: UILabel!
    
    var hucreProtokol:YemekTableViewCellProtocol?
    var indexPath:IndexPath?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func siparisVerButton(_ sender: Any) {
        hucreProtokol?.siparisVer(indexPath: indexPath!)
    }
}
