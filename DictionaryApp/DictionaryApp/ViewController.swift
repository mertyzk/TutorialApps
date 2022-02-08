//
//  ViewController.swift
//  DictionaryApp
//
//  Created by Macbook Air on 8.02.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var wordTableView: UITableView!
    
    var wordList = [Kelimeler]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dbCopy()

        wordList = KelimelerDao().getByAll()
        
        wordTableView.delegate = self
        wordTableView.dataSource = self
        searchBar.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let index = sender as? Int
        let goToVC = segue.destination as! DetailViewController
        goToVC.word = wordList[index!]
    }
    
    func dbCopy(){
        let bundlePath = Bundle.main.path(forResource: "sozluk", ofType: ".sqlite")
        let targetPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let fileManager = FileManager.default
        let placeToCopy = URL(fileURLWithPath: targetPath).appendingPathComponent("sozluk.sqlite")
        
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
        return wordList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let word = wordList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "wordCell", for: indexPath) as! WordTableViewCell
        cell.turkishLabel.text = word.turkce
        cell.englishLabel.text = word.ingilizce
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toDetail", sender: indexPath.row)
    }

}

extension ViewController:UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("Search result: \(searchText)")
        
        wordList = KelimelerDao().getSearchByEnglish(ingilizce: searchText)
        wordTableView.reloadData()
    }
}
