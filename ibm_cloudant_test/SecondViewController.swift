//
//  SecondViewController.swift
//  ibm_cloudant_test
//
//  Created by Luis Eduardo Brime Gomez on 11/9/18.
//  Copyright © 2018 Luis Eduardo Brime Gomez. All rights reserved.
//

import UIKit
import SwiftCloudant

class SecondViewController: UIViewController {
    
    let url : String = "https://6e35d4a8-6736-4b01-944a-3efb86eb8844-bluemix.cloudant.com"
    let username : String = "6e35d4a8-6736-4b01-944a-3efb86eb8844-bluemix"
    let password : String = "e500ff5965af55345c1dda8fb7427a68b6403b80b6526e1244203a7db185cca2"
    
    @IBOutlet weak var nLabel: UILabel!
    @IBOutlet weak var aLabel: UILabel!
    @IBOutlet weak var eLabel: UILabel!
    
    var name : String = ""
    var age : String = ""
    var email : String = ""
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        loadData()
    }
    
    func loadData() {
        self.indicator.startAnimating()
        
        DispatchQueue.global().async {
            DispatchQueue.main.async {
                print("Retrieving data...")
                let cloudantURL = NSURL(string: self.url)
                let client = CouchDBClient(url: cloudantURL! as URL, username: self.username, password: self.password)
                let dbName = "test"
                
                let read = GetDocumentOperation(id: "ba290984d2dcbeca3cb8cc22ec5c335c", databaseName: dbName) { (response, httpInfo, error) in
                    if let error = error {
                        print("ERROR \(error)")
                    } else {
                        print("Data retrieved...")
                        self.name = response?["name"] as! String
                        self.age  = response?["age"] as! String
                        self.email = response?["email"] as! String
                        
                        self.nLabel.text = self.name
                        self.aLabel.text = self.age
                        self.eLabel.text = self.email
                        
                        self.indicator.stopAnimating()
                    }
                }
                client.add(operation: read)
                print("Done...")
            }
        }
    }


}

