//
//  ViewController.swift
//  ParsingJSONWithCodable
//
//  Created by hexlant_01 on 2020/05/10.
//  Copyright © 2020 hexlant_01. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    
    // Use dateFormatter to change string data to date format
    let dateFormatter = DateFormatter()

    @IBOutlet weak var tableView: UITableView!
    let cellIdentifier:String = "cell"
    
    // An Array to save json file data
    var lunars: [Lunar] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let jsonDecodar: JSONDecoder = JSONDecoder()
        // "lunar" is the name of json flie. Therefore if you want use your own file, then you should change the name("lunar").
        guard let dataAsset: NSDataAsset = NSDataAsset(name: "lunar") else {
            return
        }
        
        do {
            self.lunars = try jsonDecodar.decode([Lunar].self, from: dataAsset.data)
        } catch {
            print(error.localizedDescription)
        }
        
        self.tableView.reloadData()
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.lunars.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath)

        // change String data in json file to Date type data
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        
        let lunar: Lunar = self.lunars[indexPath.row]
        
        let solarDate: Date = dateFormatter.date(from: lunar.date)!
        let lunarDate: Date = dateFormatter.date(from: lunar.lunar)!
        
        cell.textLabel?.text = "\(solarDate)"
        cell.detailTextLabel?.text = "\(lunarDate)"
        
        return cell
    }


}

