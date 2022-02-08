//
//  ViewController.swift
//  LectureNotesApp
//
//  Created by Macbook Air on 8.02.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var pointTableView: UITableView!
    
    
    var pointList = [Notlar]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dbCopy()
        
        pointTableView.delegate = self
        pointTableView.dataSource = self
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        pointList = PointsDao().getByAll()
        
        var sum = 0
        
        for p in pointList {
            sum = sum + (p.not1! + p.not2!)/2
        }
        
        if pointList.count != 0 {
            navigationItem.prompt  = "SUM : \(sum / pointList.count)"
        }else{
            navigationItem.prompt  = "Ortalama : YOK"
        }
        
        pointTableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let index = sender as? Int
        
        if segue.identifier == "toPointDetail" {
            
            let goToVC = segue.destination as! PointDetailViewController
            
            goToVC.point = pointList[index!]
            
        }
        
    }
    
    func dbCopy(){
        let bundlePath = Bundle.main.path(forResource: "points", ofType: ".sqlite")
        let targetPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let fileManager = FileManager.default
        let placeToCopy = URL(fileURLWithPath: targetPath).appendingPathComponent("points.sqlite")
        
        if fileManager.fileExists(atPath: placeToCopy.path){
            print("DB mevcut, kopyalama gereksiz.")
        }else{
            do {
                try fileManager.copyItem(atPath: bundlePath!, toPath: placeToCopy.path)
            } catch{
                print(error)
            }
        }
    }


}

extension ViewController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        pointList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "puanHucre", for: indexPath) as! PointCellTableViewCell
        let incomingData = pointList[indexPath.row]
        cell.lecturesLabel.text = incomingData.ders_adi
        cell.vizeLabel.text = "\(incomingData.not1!)"
        cell.finalLabel.text = "\(incomingData.not2!)"
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toPointDetail", sender: indexPath.row)
        
    }
    

    
}
