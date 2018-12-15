//
//  ViewController.swift
//  Gotcha! Score Keeper
//
//  Created by Peter Jaworski on 11/27/18.
//  Copyright © 2018 Peter Jaworski. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var items = [String]()
    
    @IBOutlet weak var listTableView: UITableView!
    @IBAction func addItem(_ sender: AnyObject) {
        alert()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listTableView.dataSource = self
        self.items = UserDefaults.standard.stringArray(forKey:"items")  ?? [String]()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! PointsCell
        
        cell.textLabel?.text = items[indexPath.row]
        //cell.delegate = self
        cell.setLabel()
        cell.pointButtonPressed(self)
        
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        
        return cell
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func saveData() {
        UserDefaults.standard.set(items, forKey: "items")
    }
    
    func alert(){
        let alert = UIAlertController(title: "Add Player", message: "", preferredStyle: .alert)
        alert.addTextField{
            (textfield) in
            textfield.placeholder = " Enter Player Name "
            
        }
        let add = UIAlertAction(title: "Add", style: .default)
            {
            
            (action) in guard let textfield = alert.textFields?.first else {return}
            
            if let newText = textfield.text
            {
                self.items.append(newText)
                self.saveData()
                let indexPath = IndexPath(row: self.items.count - 1, section: 0)
                self.listTableView.insertRows(at: [indexPath], with: .automatic)
            }
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) {
            (alert) in
            
        }
        
        alert.addAction(add)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        items.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        saveData()
        
    }
    
}
/*extension ViewController: ScoreCellDelegate {
    func didTappedButton(index: Int) {

        print("\(index) button pressed")
    }
    
}*/

