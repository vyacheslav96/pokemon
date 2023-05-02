//
//  UINavigationViewController.swift
//  Pokemon
//
//  Created by Vyacheslav Lagutov on 25.04.2023.
//

import UIKit

class UINavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let list = UIPokemonsTableViewController(nibName: "UIPokemonsTableViewController", bundle: nil)
        
        list.title = "List"
        setViewControllers([list], animated: false)

        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
