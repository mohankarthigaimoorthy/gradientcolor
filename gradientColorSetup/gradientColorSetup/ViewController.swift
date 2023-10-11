//
//  ViewController.swift
//  gradientColorSetup
//
//  Created by Imcrinox Mac on 15/12/1444 AH.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    var audioPlayer = AVAudioPlayer()
    
    let gradientLayer = CAGradientLayer()
    
    
    var timer : Timer?
    
    var backgroundColor : (red:CGFloat,green: CGFloat,blue: CGFloat,alpha: CGFloat)! {
        didSet {
            let color1 = UIColor(red: backgroundColor.blue,
                                 green: backgroundColor.green,
                                 blue: 0,
                                 alpha: backgroundColor.alpha).cgColor
            let color2 = UIColor(red: backgroundColor.red, green: backgroundColor.green, blue:  backgroundColor.blue, alpha: backgroundColor.alpha).cgColor
            gradientLayer.colors = [color1,color2]
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override var prefersStatusBarHidden : Bool {
        return true
    }
    @IBAction func playPauseButton(_ sender: Any) {
   
        let bgMusic = URL(fileURLWithPath: Bundle.main.path(forResource: "LEO - Naa Ready", ofType: "mp3")!)
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
            try AVAudioSession.sharedInstance().setActive(true)
           try audioPlayer = AVAudioPlayer(contentsOf: bgMusic)
            
            audioPlayer.prepareToPlay()
            audioPlayer.play()
        }
        
        catch let audioError as NSError {
            print(audioError)
        }
        
        if (timer == nil)
        {
            timer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(ViewController.randomColor), userInfo: nil, repeats: true)
        }
        
        let redValue = CGFloat(drand48())
        let blueValue = CGFloat(drand48())
        let greenValue = CGFloat(drand48())
        
        self.view.backgroundColor = UIColor(red: redValue, green: greenValue, blue: blueValue, alpha: 1.0)
        
        gradientLayer.frame = view.bounds
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        
        self.view.layer.addSublayer(gradientLayer)
    }
    
    @objc func randomColor() {
        
        let redValue = CGFloat(drand48())
        let blueValue = CGFloat(drand48())
        let greenValue = CGFloat(drand48())
        
        backgroundColor = (redValue,greenValue,blueValue,1)
    }
}

