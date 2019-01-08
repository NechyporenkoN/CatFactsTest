//
//  GeneralVC.swift
//  Cat Facts
//
//  Created by Nikita Nechyporenko on 05.01.2019.
//  Copyright © 2019 Nikita Nechyporenko. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class GeneralVC: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        request()
        
        self.tableView.estimatedRowHeight = 70
        self.tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    
    func request() {
        Alamofire.request("https://cat-fact.herokuapp.com/facts", method: .get, encoding: JSONEncoding.default, headers: nil)
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                if (response.result.error == nil) {
                    let swiftyJson = JSON(response.data!)
                    var firstName = ""
                    var lastName = ""
                    for i in 0..<swiftyJson["all"].count  {
                        let all = swiftyJson["all"][i]
                        if all["user"]["name"]["first"].string != nil {
                            firstName = all["user"]["name"]["first"].string!
                        } else {
                            firstName = "anonymous"
                        }
                        if all["user"]["name"]["last"].string != nil {
                            lastName = all["user"]["name"]["last"].string!
                        } else {
                            lastName = "writer"
                        }
                        let name = firstName + " " + lastName
                        let text = all["text"].string!
                        let nameAndText = Response.init(name: name, text: text)
                        arrData.append(nameAndText)
                        self.tableView.reloadData()
                    }
                }
                else {
                    debugPrint("HTTP Request Log in failed: \(String(describing: response.result.error))")
                }
        }
    }
    
    //MARK: TableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        cell.labelCell.text = arrData[indexPath.row].name
        cell.labelForText.text = arrData[indexPath.row].text
        cell.imageViewInCell.image = UIImage(named: "cat_footprint")
        
        return cell
    }
    
}
