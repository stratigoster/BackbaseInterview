//
//  ViewController.swift
//  Backbase
//
//  Created by William  on 2018-11-19.
//  Copyright © 2018 William . All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //preprocessed the data into two array of struct. One to store all values and another to store the intermediate filtered value.
    //This is more efficient because the filtered data only stores the filtered list rather than copy the entire data set
    //this filtered data model is necessary in order to store the index of the cell which stores the location of the lat/lon coordintes to disply in the detail view
    //the filtered data is originally empty in order to avoid duplicating the entire list
    var model: [Location] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        if let path = Bundle.main.path(forResource: "cities", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let decoder = JSONDecoder()
                model = try decoder.decode([Location].self, from: data).sorted(by: { $0.name < $1.name })
            } catch {
                print(error)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

