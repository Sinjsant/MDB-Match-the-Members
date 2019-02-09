//
//  statsViewController.swift
//  MDB Mini Project 1
//
//  Created by Sinjon Santos on 2/8/19.
//  Copyright © 2019 Sinjon Santos. All rights reserved.
//

import UIKit

class statsViewController: UIViewController {
    
    
    var bestScore = 0
    var lastChoices = [String]()
    var statsLabel : UILabel!
    var bestScoreLabel : UILabel!
    var lastChoicesTitle : UILabel!
    var lastChoicesLabel : UILabel!
    var coolButton : UIButton!
    
    let mdbColor = UIColor(red: 112/255, green: 188/255, blue: 246/255, alpha: 1.0)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "blob-shape2")
        backgroundImage.contentMode = .scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)

        coolButton = UIButton(frame: CGRect(x: view.frame.width - 80, y: 40, width: 60, height: 50))
        coolButton.setTitle("Cool", for: .normal)
        coolButton.titleLabel?.font = .boldSystemFont(ofSize: 20)
        coolButton.setTitleColor(mdbColor, for: .normal)
        coolButton.addTarget(self, action: #selector(exit), for: .touchUpInside)
        view.addSubview(coolButton)
    
        
        statsLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 100))
        statsLabel.center = CGPoint(x: view.frame.width/2, y: 125)
        statsLabel.font = .boldSystemFont(ofSize: 35)
        statsLabel.textColor = mdbColor
        statsLabel.textAlignment = .center
        statsLabel.text = "Your Statistics"
        
        view.addSubview(statsLabel)
        
        bestScoreLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 40))
        bestScoreLabel.center = CGPoint(x: statsLabel.center.x, y: statsLabel.frame.maxY + 100)
        bestScoreLabel.textAlignment = .center
        bestScoreLabel.text = "Longest Streak: \(bestScore)"
        bestScoreLabel.font = .systemFont(ofSize: 30)
        bestScoreLabel.textColor = mdbColor
        view.addSubview(bestScoreLabel)
        
        
        lastChoicesTitle = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 100))
        lastChoicesTitle.numberOfLines = 0
        lastChoicesTitle.center = CGPoint(x: statsLabel.center.x, y: bestScoreLabel.frame.maxY + 75)
        lastChoicesTitle.textAlignment = .center
        lastChoicesTitle.text = "Last Three People:"
        lastChoicesTitle.font = .systemFont(ofSize: 30)
        lastChoicesTitle.textColor = mdbColor
        view.addSubview(lastChoicesTitle)
        
        
        lastChoicesLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 200))
        lastChoicesLabel.numberOfLines = 0
        lastChoicesLabel.center = CGPoint(x: statsLabel.center.x, y: lastChoicesTitle.frame.maxY + 35)
        lastChoicesLabel.textAlignment = .center
        let arrayString = lastChoices.joined(separator: "\n")
        print(arrayString)
        lastChoicesLabel.text = "\(arrayString)"
        lastChoicesLabel.font = .systemFont(ofSize: 30)
        lastChoicesLabel.textColor = mdbColor
        view.addSubview(lastChoicesLabel)
        
        
        
        
        

        // Do any additional setup after loading the view.
    }
    
    @objc func exit() {
        self.dismiss(animated: true, completion: nil)
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
