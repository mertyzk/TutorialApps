//
//  ViewController.swift
//  SimpsonBook
//
//  Created by Macbook Air on 16.02.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var simpson = [Simpsons]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let s1 = Simpsons(name: "Bart", job: "None1", image: "bartsimpson")
        let s2 = Simpsons(name: "Homer", job: "None2", image: "homersimpson")
        let s3 = Simpsons(name: "Lisa", job: "None3", image: "lisasimpson")
        let s4 = Simpsons(name: "Maggie", job: "None4", image: "maggiesimpson")
        let s5 = Simpsons(name: "Marge", job: "None5", image: "margesimpson")
        
        simpson.append(s1)
        simpson.append(s2)
        simpson.append(s3)
        simpson.append(s4)
        simpson.append(s5)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailVC" {
            let index = sender as? Int
            let goingVC = segue.destination as! DetailsViewController
            goingVC.simpson = simpson[index!]
        }
    }


}

extension ViewController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return simpson.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "hucreName", for: indexPath)
        let incomingData = simpson[indexPath.row]
        cell.textLabel?.text = incomingData.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toDetailVC", sender: indexPath.item)
    }

              
}
              
