//
//  ViewController.swift
//  MDB Mini Project 1
//
//  Created by Sinjon Santos on 2/7/19.
//  Copyright © 2019 Sinjon Santos. All rights reserved.
//

import UIKit

class startViewController: UIViewController {
    
    var startButton : UIButton!
    var mdbLogo : UIImageView!
    let mdbColor = UIColor(red: 112/255, green: 188/255, blue: 246/255, alpha: 1.0)

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        view.backgroundColor = UIColor(red: 238/255.0, green: 238/255.0, blue: 238/255.0, alpha: 1.0)
        
        mdbLogo = UIImageView(frame: CGRect(x: 0, y: 0, width: 300, height: 400))
        mdbLogo.center = CGPoint(x: view.frame.width/2 + 35, y: 325)
        mdbLogo.contentMode = .scaleAspectFit
        mdbLogo.image = UIImage(named: "mdb_logo")
        view.addSubview(mdbLogo)
        
        
        startButton = UIButton(frame: CGRect(x: view.frame.width/2 - 150, y: view.frame.height/2 - 50, width: 300, height: 100))
        startButton.setTitle("Start!", for: .normal)
        startButton.layer.cornerRadius = 20
        startButton.titleLabel?.font = .systemFont(ofSize: 30)
        startButton.backgroundColor = mdbColor
        startButton.alpha = 0.0
        
        startButton.addTarget(self, action: #selector(startClicked), for: .touchUpInside)
        
        view.addSubview(startButton)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 1, delay: 0, options: [.curveEaseOut], animations:
            {self.startButton.alpha = 1.0
            self.startButton.transform = CGAffineTransform(translationX: 0, y: 200)}, completion: nil)
        
    }
    
    @objc func startClicked() {
        performSegue(withIdentifier: "toMain", sender: self)
    }


}

