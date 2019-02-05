//
//  ViewController.swift
//  Gotcha! Score Keeper
//
//  Created by Peter Jaworski on 11/27/18.
//  Copyright © 2018 Peter Jaworski. All rights reserved.
//

import UIKit

//Array of custom model. To save custom model to UserDefaults - encode and decode (Codable)
struct Item: Codable {
    var title: String
    var points: Int
    
    init(title: String, points: Int = 0) {
        self.title = title
        self.points = points
    }
}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var items = [Item]()
    
    
    @IBOutlet weak var listTableView: UITableView!
    @IBAction func addItem(_ sender: AnyObject) {
        alert()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listTableView.dataSource = self
        //Need JSONDecoder for RETRIEVING
        do {
            if let data = UserDefaults.standard.data(forKey:"items") {
                items = try JSONDecoder().decode([Item].self, from: data)
            }
        } catch { print(error) }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! PointsCell
        let item = items[indexPath.row]
        cell.textLabel?.text = item.title
        cell.scoreUILabel.text = "\(item.points)"
        
        
       // assign parameter to cell and say that if button is pressed, increase points of this item and reload this row.
        cell.buttonPressed = { // this gets called when `buttonPressed?()` is called from cell class
        self.items[indexPath.row].points += 1
        tableView.reloadRows(at: [indexPath], with: .automatic)
        self.saveData()
        }
        
        return cell
    }
    
    //Since Codable is used to encode and decode custom model to UserDefaults. - Need JSONEncoder SAVING
    func saveData() {
        do {
            let encoded = try JSONEncoder().encode(items)
            UserDefaults.standard.set(encoded, forKey: "items")
        } catch { print(error) }
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
            
                self.items.append(Item(title: textfield.text!))
                self.saveData()
                let indexPath = IndexPath(row: self.items.count - 1, section: 0)
                self.listTableView.insertRows(at: [indexPath], with: .automatic)


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

