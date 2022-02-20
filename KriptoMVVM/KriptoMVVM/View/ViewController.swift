//
//  ViewController.swift
//  KriptoMVVM
//
//  Created by Macbook Air on 20.02.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    private var kriptoListViewModel : KriptoListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        

        
    }
    
    func getAll(){
        Service().getData { (kriptolist) in
            if let kriptolist = kriptolist {
                self.kriptoListViewModel = KriptoListViewModel(kriptoList: kriptolist)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }


}

extension ViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.kriptoListViewModel == nil ? 0 : self.kriptoListViewModel.numberOfRowsInsection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellName", for: indexPath) as! KriptoTableViewCell
        let kriptoViewModel = self.kriptoListViewModel.kriptoAtIndex(indexPath.row)
        cell.nameLabel.text = kriptoViewModel.name
        cell.priceLabel.text = kriptoViewModel.price
        return cell
    }
    
    
}

