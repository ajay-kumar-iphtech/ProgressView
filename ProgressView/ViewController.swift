//
//  ViewController.swift
//  ProgressView
//
//  Created by iPHTech 28 on 29/01/24.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var btn: UIButton!
    
    
    var emojiImageView: UIImageView!
    var isRed = false
    var progressBarTimer: Timer!
    var isRunning = false
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
        
    }
    
    
    func setUpUI(){
        
        progressView.progress = 0.0
        
        // Set black borderColor for the progressView
        progressView.layer.borderColor = UIColor.black.cgColor
        progressView.layer.borderWidth = 2.0 // Adjust the width of the border if needed
        progressView.layer.cornerRadius = 10
        progressView.clipsToBounds = true
        progressView.layer.sublayers![1].cornerRadius = 10
        progressView.subviews[1].clipsToBounds = true
        
        // Create and position the emoji image view within the progress view frame
        let emojiImageSize: CGFloat = 48.0
        emojiImageView = UIImageView(frame: CGRect(x: progressView.frame.origin.x + progressView.frame.width / 2 - emojiImageSize / 2, y: progressView.frame.origin.y - emojiImageSize + 32, width: emojiImageSize, height: emojiImageSize))
        emojiImageView.contentMode = .center
        emojiImageView.image = UIImage(named: "running")
        emojiImageView.alpha = 0.0 // Initially set the image as transparent
        view.addSubview(emojiImageView)
        
        
    }
    
    
    @IBAction func btnAction(_ sender: UIButton) {
        
        if isRunning {
            progressBarTimer.invalidate()
            btn.setTitle("Start", for: .normal)
        } else {
            btn.setTitle("Stop", for: .normal)
            progressView.progress = 0.0
            emojiImageView.alpha = 1.0 // Show the image when progressView starts
            self.progressBarTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(ViewController.updateProgressView), userInfo: nil, repeats: true)
            if isRed {
                progressView.progressTintColor = UIColor.blue
                progressView.progressViewStyle = .default
            } else {
                progressView.progressTintColor = UIColor.red
                progressView.progressViewStyle = .bar
            }
            isRed = !isRed
        }
        isRunning = !isRunning
        
    }
    
    
    @objc func updateProgressView() {
        progressView.progress += 0.1
        progressView.setProgress(progressView.progress, animated: true)
        
        // Update the position of the emoji image view within the progress view frame based on the progress
        let progressWidth = progressView.frame.width * CGFloat(progressView.progress)
        emojiImageView.frame.origin.x = progressView.frame.origin.x + progressWidth - emojiImageView.frame.width / 2
        
        if progressView.progress == 1.0 {
            progressBarTimer.invalidate()
            isRunning = false
            btn.setTitle("Start", for: .normal)
        }
    }
    
}

