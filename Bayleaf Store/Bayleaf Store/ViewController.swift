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
    @IBOutlet var homeTitleLabel: UINavigationItem!
    @IBOutlet var swipeGesture: UISwipeGestureRecognizer!
    @IBOutlet var menuTableView: UITableView!
    @IBOutlet var plantImage: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
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
        // Do any additional setup after loading the view.
        
        menuTableView.delegate = self
        menuTableView.dataSource = self
        
        home = self.containerView.transform
        
        containerView.frame = CGRect(x: 0, y: 0, width: screen.width, height: screen.height)
        if let y = self.navigationController?.navigationBar.centerYAnchor {
            homeTitleLabel.titleView?.bottomAnchor.constraint(equalTo: y, constant: 0).isActive = true
            homeTitleLabel.titleView?.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 30).isActive = true
            constraints(y: self.containerView.topAnchor)
        }
    }
    
    func constraints(y: NSLayoutYAxisAnchor) {
        
        plantImage.layer.cornerRadius = 30
        plantImage.frame = CGRect(x: 0, y: 0, width: self.screen.width * 0.8, height: 200)
        plantImage.center.x = self.view.center.x
        plantImage.center.y = self.view.center.y * 0.7
        titleLabel.center.x = self.view.center.x
        titleLabel.center.y = plantImage.center.y + (plantImage.frame.height / 1.5)
        descriptionLabel.frame = CGRect(x: 0, y: 0, width: plantImage.frame.width, height: 100)
        descriptionLabel.center.x = self.view.center.x
        descriptionLabel.center.y = titleLabel.center.y + (descriptionLabel.frame.height / 2)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        
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
                self.containerView.layer.cornerRadius = 40
                self.viewBG.layer.cornerRadius = self.containerView.layer.cornerRadius
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
        
        if let indexPath = tableView.indexPathForSelectedRow { //optional, to get from any UIButton for example

            let currentCell = (tableView.cellForRow(at: indexPath) ?? UITableViewCell()) as UITableViewCell
            
            currentCell.alpha = 0.5
            UIView.animate(withDuration: 1, animations: {
                currentCell.alpha = 1
            })
            
            self.parent?.performSegue(withIdentifier: options[indexPath.row].segue, sender: self)
        }
    }
    
}


class tableViewCell: UITableViewCell {
    
    @IBOutlet var descriptionLabel: UILabel!
    
    func animate() {

        descriptionLabel.textColor = #colorLiteral(red: 0.1471175551, green: 0.1743232608, blue: 0.1306586266, alpha: 0.8470588235)
        UIView.animate(withDuration: 1) {
            self.descriptionLabel.textColor = #colorLiteral(red: 0.6461477876, green: 0.6871469617, blue: 0.6214019656, alpha: 1)
            
        }
    }
}
