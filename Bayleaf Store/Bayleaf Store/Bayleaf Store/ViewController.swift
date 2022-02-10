//
//  ViewController.swift
//  Bayleaf Store
//
//  Created by Martina on 01/01/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var containerView: UIView!
    @IBOutlet var viewBG: UIImageView!
    @IBOutlet var swipeGesture: UISwipeGestureRecognizer!
    @IBOutlet var menuTableView: UITableView!
    
    let screen = UIScreen.main.bounds
    var menu = false
    var home = CGAffineTransform()
    var options: [option] = [option(title: "Home", segue: "HomeSegue"),
                             option(title: "Settings", segue: "SettingsSegue"),
                             option(title: "Profile", segue: "ProfileSegue"),
                             option(title: "Terms and Conditions", segue: "TermsSegue"),
                             option(title: "Privacy Policy", segue: "PrivacySegue")
                            ]
    
    struct option {
        var title = String()
        var segue = String()
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuTableView.delegate = self
        menuTableView.dataSource = self
        menuTableView.backgroundColor = .clear
        
        home = self.containerView.transform
        
    }
    

    
    func showMenu() {
        
        self.containerView.layer.cornerRadius = 40
        self.viewBG.layer.cornerRadius = self.containerView.layer.cornerRadius
        let x = screen.width * 0.8
        let originalTransform = self.containerView.transform
        let scaledTransform = originalTransform.scaledBy(x: 0.8, y: 0.8)
            let scaledAndTranslatedTransform = scaledTransform.translatedBy(x: x, y: 0)
            UIView.animate(withDuration: 0.7, animations: {
                self.containerView.transform = scaledAndTranslatedTransform
                
            })
        
    }
    
    func hideMenu() {
        
            UIView.animate(withDuration: 0.7, animations: {
                
                self.containerView.transform = self.home
                self.containerView.layer.cornerRadius = 0
                self.viewBG.layer.cornerRadius = 0
                
            })
        
    }
    
    
    
    @IBAction func showMenu(_ sender: UISwipeGestureRecognizer) {
        
        print("menu interaction")
        
        if menu == false && swipeGesture.direction == .right {
            
            print("user is showing menu")
            
            showMenu()
            
            menu = true
            
        }
        
    }
    
    
    
    @IBAction func hideMenu(_ sender: Any) {
        
        if menu == true {
            
            print("user is hiding menu")
            
            hideMenu()
            
            menu = false
            
        }
        
        
    }
    
    
   
}



extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return options.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as! tableViewCell
        cell.descriptionLabel.text = options[indexPath.row].title
        cell.descriptionLabel.textColor = #colorLiteral(red: 0.6461477876, green: 0.6871469617, blue: 0.6214019656, alpha: 1)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let indexPath = tableView.indexPathForSelectedRow {

            let currentCell = (tableView.cellForRow(at: indexPath) ?? UITableViewCell()) as UITableViewCell
            
            // optional: animate the button when tapped
            
            currentCell.alpha = 0.5
            UIView.animate(withDuration: 1, animations: {
                currentCell.alpha = 1
            })
            
            // optional: perform a segue when tapped
            
            // self.parent?.performSegue(withIdentifier: options[indexPath.row].segue, sender: self)
            
        }
    }
    
}


class tableViewCell: UITableViewCell {
    
    @IBOutlet var descriptionLabel: UILabel!
    
}
