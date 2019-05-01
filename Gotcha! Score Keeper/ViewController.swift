//
//  ViewController.swift
//  Gotcha! Score Keeper
//
//  Created by Peter Jaworski on 11/27/18.
//  Copyright © 2018 Peter Jaworski. All rights reserved.
//

import UIKit
import Firebase

//Array of custom model. To save custom model to UserDefaults - encode and decode (Codable)

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var items = [Item]()
    var refNames: DatabaseReference!
    //var databaseHandle: DatabaseHandle?
    
    @IBOutlet weak var listTableView: UITableView!
    @IBAction func addItem(_ sender: AnyObject) {
        alert()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listTableView.dataSource = self
        
        // Need to create a reference to the Firebase database
        refNames = Database.database().reference().child("Players")
        
        // This will be called if we make any changes in our Firbase database
        refNames.observe(DataEventType.value, with: { (snapshot) in
            //checks to see if there are any data in Firebase and fetch all the data.
            if snapshot.childrenCount > 0 {
                // First we need to remove all the  existing players from the array in "items"
                self.items.removeAll()
                
                // run a loop through all the players
                for players in snapshot.children.allObjects as![DataSnapshot]{
                    let playersObject = players.value as? [String: AnyObject]
                    let playerName = playersObject?["name"]
                    let playerPoints = playersObject?["points"]
                    let playerId = playersObject?["id"]
                    
                    let player = Item(id: playerId as? String, name: playerName as? String, points: playerPoints as! Int)
                    
                    self.items.append(player)
                    
                }
                self.listTableView.reloadData()
            }
        })
        //Need JSONDecoder for RETRIEVING
        /*do {
            if let data = UserDefaults.standard.data(forKey:"items") {
                items = try JSONDecoder().decode([Item].self, from: data)
            }
        } catch { print(error) }*/
    }
    
    /*override func viewDidAppear(_ animated: Bool) {
        
        let isUserLoggedIn = UserDefaults.standard.bool(forKey: "isUserLoggedIn")
        
        if isUserLoggedIn{
        self.performSegue(withIdentifier: "loginView", sender: self)
        }
    }*/
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! PointsCell
        let item = items[indexPath.row]
        
        cell.textLabel?.text = item.name
        cell.scoreUILabel.text = "\(String(describing: item.points))"

        
        // create auto ID for points and save initial point value to firebase database
       
       // assign parameter to cell and say that if button is pressed, increase points of this item and reload this row.
        cell.buttonPressed = { // this gets called when `buttonPressed?()` is called from cell class
            self.items[indexPath.row].points += 1
            
            
            tableView.reloadRows(at: [indexPath], with: .automatic)
    
            /*
            let id =  item.id
            let name = cell.textLabel?.text
            let points = cell.scoreUILabel?.text
            self.updatePoint(id: id!, name: name!, points: points!)*/
            let id =  item.id
            let name = item.name
            let points = item.points
            
            let player = ["id": id!,
                          "name": name!,
                          "points": points] as [String : Any]
            
            self.refNames.child(id!).setValue(player)

        
            
            //self.saveData()
        
        }
        cell.minusButton = { // this gets called when `buttonPressed?()` is called from cell class
            self.items[indexPath.row].points -= 1
            
            
            tableView.reloadRows(at: [indexPath], with: .automatic)
            
            /*
             let id =  item.id
             let name = cell.textLabel?.text
             let points = cell.scoreUILabel?.text
             self.updatePoint(id: id!, name: name!, points: points!)*/
            let id =  item.id
            let name = item.name
            let points = item.points
            
            let player = ["id": id!,
                          "name": name!,
                          "points": points] as [String : Any]
            
            self.refNames.child(id!).setValue(player)
            
            
            
            //self.saveData()
            
        }
        
        return cell
        
    }
    
    /*func updatePoint(id: String, name: String, points: String){
        let player = [
            "id": id,
            "name": name,
            "points": points]
        
        self.refNames.child(id).setValue(player)
    }*/
    
    //Since Codable is used to encode and decode custom model to UserDefaults. - Need JSONEncoder SAVING
    /*func saveData() {
        do {
            let encoded = try JSONEncoder().encode(items)
            UserDefaults.standard.set(encoded, forKey: "items")
        } catch { print(error) }
    }*/
    
    
    func alert() {
        let alert = UIAlertController(title: "Add Player", message: "", preferredStyle: .alert)
        alert.addTextField{
            (textfield) in
            textfield.placeholder = " Enter Player Name "
            
        }
        let add = UIAlertAction(title: "Add", style: .default)
            {
            
            (action) in guard let textfield = alert.textFields?.first else {return}
                
                self.items.append(Item(id: "",name: textfield.text!, points: 0))
                //self.saveData()
                let indexPath = IndexPath(row: self.items.count - 1, section: 0)
                self.listTableView.insertRows(at: [indexPath], with: .automatic)
                
                let key = self.refNames.childByAutoId().key
                let players = ["id": key!,
                               "name": textfield.text!,
                               "points": 0] as [String : Any]
                
                self.refNames.child(key!).setValue(players)
                


        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) {
            (alert) in
            
        }
        
        alert.addAction(add)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        items.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        self.deleteEntry(id: item.id!)
        //saveData()
        
    }
    func deleteEntry (id: String){
        refNames.child(id).setValue(nil)
    }
    
    
}

/*extension ViewController: ScoreCellDelegate {
    func didTappedButton(index: Int) {

        print("\(index) button pressed")
    }
    
}*/
