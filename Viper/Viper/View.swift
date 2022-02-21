//
//  View.swift
//  Viper
//
//  Created by Macbook Air on 20.02.2022.
//

import Foundation
import UIKit

protocol AnyView{
    
    var presenter : AnyPresenter? {get set}
    
    func update(with kriptolar:[Kripto])
    func update(with error:String)
}

class KriptoViewController : UIViewController, AnyView, UITableViewDelegate, UITableViewDataSource{

    var presenter: AnyPresenter?
    
    var kriptolar : [Kripto] = []
    
    private let tableView : UITableView = {
       let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.isHidden = true
        return table
    }()
    
    private let messageLabel : UILabel = {
        let label = UILabel()
        label.isHidden = false
        label.text = "Downloading.."
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        view.addSubview(tableView)
        view.addSubview(messageLabel)
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        messageLabel.frame = CGRect(x: view.frame.width / 2 - 100, y: view.frame.height / 2 - 25, width: 200, height: 50)
    }
    
    func update(with kriptolar: [Kripto]) {
        DispatchQueue.main.async {
            self.kriptolar = kriptolar
            self.messageLabel.isHidden = true
            self.tableView.reloadData()
            self.tableView.isHidden = false
        }
    }
    
    func update(with error: String) {
        DispatchQueue.main.async {
            self.kriptolar = []
            self.messageLabel.isHidden = true
            self.messageLabel.text = error
            self.messageLabel.isHidden = false
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return kriptolar.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = kriptolar[indexPath.row].currency
        content.secondaryText = kriptolar[indexPath.row].price
        cell.contentConfiguration = content
        cell.backgroundColor = .blue
        return cell
    }
    
    
}
