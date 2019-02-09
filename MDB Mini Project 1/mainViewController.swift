//
//  mainViewController.swift
//  MDB Mini Project 1
//
//  Created by Sinjon Santos on 2/7/19.
//  Copyright © 2019 Sinjon Santos. All rights reserved.
//

import UIKit

class mainViewController: UIViewController {
    
    var mdbLogo: UIImageView!
    var statsButton: UIButton!
    var scoreLabel : UILabel!
    var scoreEntry : UILabel!
    var memberPic : UIImageView!
    let shapeLayer = CAShapeLayer()
    var member1Button : UIButton!
    var member2Button : UIButton!
    var member3Button : UIButton!
    var member4Button : UIButton!
    var buttonArray = [UIButton?]()
    var memberName = ""
    var timer : DispatchSourceTimer?
    var bestScore = 0
    var currentScore = 0
    var lastChoices = [String]()
    
    let mdbColor = UIColor(red: 112/255, green: 188/255, blue: 246/255, alpha: 1.0)
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        // Render score label
        scoreLabel = UILabel(frame: CGRect(x: 40, y: 70, width: 80, height: 20))
        scoreLabel.text = "Score"
        scoreLabel.font = .boldSystemFont(ofSize: 25)
        scoreLabel.textAlignment = .center
        scoreLabel.textColor = mdbColor
        view.addSubview(scoreLabel)
        
        // Render score display
        scoreEntry = UILabel(frame: CGRect(x: 0, y: 0, width: 80, height: 50))
        scoreEntry.center = CGPoint(x: scoreLabel.frame.midX, y: scoreLabel.frame.maxY + 30)
        scoreEntry.text = "0"
        scoreEntry.font = .boldSystemFont(ofSize: 40)
        scoreEntry.textAlignment = .center
        scoreEntry.textColor = mdbColor
        view.addSubview(scoreEntry)
        
        
        // Render MDB logo
        mdbLogo = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        mdbLogo.center = CGPoint(x: view.frame.width/2, y: 100)
        mdbLogo.image = UIImage(named: "mdblogo")
        mdbLogo.contentMode = .scaleAspectFit
        mdbLogo.layer.cornerRadius = mdbLogo.frame.size.width/2
        mdbLogo.clipsToBounds = true
        mdbLogo.layer.borderWidth = 4
        mdbLogo.layer.borderColor = UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 0.8).cgColor
        view.addSubview(mdbLogo)
        
        // Render stats button
        statsButton = UIButton(frame: CGRect(x: view.frame.width - 90, y: 70, width: 50, height: 50))
        statsButton.setBackgroundImage(UIImage(named: "barchart"), for: .normal)
        statsButton.addTarget(self, action: #selector(statsClicked), for: .touchUpInside)
        view.addSubview(statsButton)
        
        // Render member picture
        memberPic = UIImageView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        memberPic.center = CGPoint(x: view.frame.width/2, y: mdbLogo.frame.maxY + 200)
        memberPic.contentMode = .scaleAspectFit
        view.addSubview(memberPic)
        
        // Render answer buttons
        member1Button = UIButton(frame: CGRect(x: 0, y: 0, width: 300, height: 50))
        member2Button = UIButton(frame: CGRect(x: 0, y: 0, width: 300, height: 50))
        member3Button = UIButton(frame: CGRect(x: 0, y: 0, width: 300, height: 50))
        member4Button = UIButton(frame: CGRect(x: 0, y: 0, width: 300, height: 50))
        buttonArray = [member1Button, member2Button, member3Button, member4Button]
        
        for i in 0...3 {
            let button = buttonArray[i]!
            button.layer.borderWidth = 2
            button.layer.cornerRadius = button.frame.height/2
            button.layer.borderColor = UIColor.lightGray.cgColor
            button.setTitleColor(mdbColor, for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 26)
            button.setTitle("", for: .normal)
            button.addTarget(self, action: #selector(buttonSelect), for: .touchUpInside)
        }
        
        member1Button.center = CGPoint(x: memberPic.center.x, y: memberPic.frame.maxY + 70)
        view.addSubview(member1Button)
        
        for i in 1...3 {
            let button = buttonArray[i]!
            button.center = CGPoint(x: memberPic.center.x, y: buttonArray[i-1]!.frame.maxY + 40)
            view.addSubview(button)
        }

        
        
        // Circular timer animation
        let center = mdbLogo.center
        let circularPath = UIBezierPath(arcCenter: center, radius: 50, startAngle: -CGFloat.pi/2, endAngle: -5/2 * CGFloat.pi, clockwise: false)
        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeColor = UIColor.cyan.cgColor
        shapeLayer.lineWidth = 7
        shapeLayer.lineCap = CAShapeLayerLineCap.round
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineCap = CAShapeLayerLineCap.round
        shapeLayer.strokeEnd = 0
        
        view.layer.addSublayer(shapeLayer)
        
        
        gameStart()
        
        
    }
    
    @objc private func draw() {
        let circleDraw = CABasicAnimation(keyPath: "strokeEnd")
        
        circleDraw.toValue = 1
        circleDraw.duration = 5
        circleDraw.fillMode = CAMediaTimingFillMode.forwards
        circleDraw.isRemovedOnCompletion = false
        shapeLayer.add(circleDraw, forKey: "test")
        shapeLayer.speed = 1.0
    }
    
    private func gameStart() {
        draw()
        timer = DispatchSource.makeTimerSource(queue: .main)
        timer?.schedule(deadline: .now() + 5.0, repeating: 5.0)
        timer?.setEventHandler {
            self.wrongChoice()
            for i in 0...3 {
                let button = self.buttonArray[i]!
                button.isEnabled = false
            }
            if self.lastChoices.count == 3 {
                self.lastChoices.removeLast()
            }
            self.lastChoices.insert(self.memberName, at: 0)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.gameStart()
            }
        }
        timer?.resume()
        
        for i in 0...3 {
            let button = buttonArray[i]!
            button.backgroundColor = UIColor.clear
            button.setTitleColor(mdbColor, for: .normal)
            button.isEnabled = true
        }
        var namesCopy = Constants.names.shuffled()
        var nameArray = [String]()
        memberName = namesCopy.removeFirst()
        nameArray.append(memberName)
        
        for _ in 1...3 {
            nameArray.append(namesCopy.removeFirst())
        }
        nameArray.shuffle()
        member1Button.setTitle(nameArray[0], for: .normal)
        member2Button.setTitle(nameArray[1], for: .normal)
        member3Button.setTitle(nameArray[2], for: .normal)
        member4Button.setTitle(nameArray[3], for: .normal)
        
        memberPic.image = Constants.getImageFor(name: memberName)
        
    }
    
    
    
    @objc private func buttonSelect(sender: UIButton) {
        let name = sender.titleLabel!.text!
        if name == memberName {
            currentScore += 1
            scoreEntry.text = "\((Int(scoreEntry.text!)! + 1))"
            for i in 0...3 {
                let button = buttonArray[i]!
                if button != sender {
                    button.backgroundColor = UIColor(red: 226/255, green: 157/255, blue: 180/255, alpha: 0.75)
                }
            }
            sender.backgroundColor = UIColor(red: 114/255, green: 198/255, blue: 152/255, alpha: 0.75)
            sender.setTitleColor(UIColor.white, for: .normal)
        } else {
            wrongChoice()
        }
        
        timer?.cancel()
        shapeLayer.timeOffset = shapeLayer.convertTime(CACurrentMediaTime(), from: nil)
        shapeLayer.speed = 0.0
        
        for i in 0...3 {
            let button = buttonArray[i]!
            button.isEnabled = false
        }
        
        if lastChoices.count == 3 {
            lastChoices.removeLast()
        }
        lastChoices.insert(memberName, at: 0)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.gameStart()
        }
    }
    
    
    
    private func wrongChoice() {
        if currentScore > bestScore {
            bestScore = currentScore
        }
        currentScore = 0
        
        for i in 0...3 {
            let button = buttonArray[i]!
            if button.titleLabel!.text! == memberName {
                button.backgroundColor = UIColor(red: 114/255, green: 198/255, blue: 152/255, alpha: 1.0)
                button.setTitleColor(UIColor.white, for: .normal)
            } else {
                button.backgroundColor = UIColor(red: 226/255, green: 157/255, blue: 180/255, alpha: 1.0)
                
            }
        }
    }
    
    @objc func statsClicked() {
        performSegue(withIdentifier: "toStats", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let resultVC = segue.destination as! statsViewController
        resultVC.bestScore = bestScore
        resultVC.lastChoices = lastChoices
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
