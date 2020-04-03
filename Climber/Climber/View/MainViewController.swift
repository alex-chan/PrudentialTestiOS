//
//  MainViewController.swift
//  Climber
//
//  Created by AlexChan on 2020/4/2.
//  Copyright © 2020 Alex. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var stepsLabel: UILabel!
    @IBOutlet weak var progressView: GOPCircleProgressView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setData()
    }
    
    func setupUI() {
        let image = UIImage(named: "BlurBG")
        let imageView = UIImageView(frame: self.view.bounds)
        imageView.image = image
        self.view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
    }
    
    func setData() {
        let steps1 = 12000
        let steps2 = 20000
        
        stepsLabel.text = "\(steps1)"
        progressView.progress = UInt(steps1 / 1000)
        
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { (timer) in
            self.stepsLabel.text = "\(steps2)"
            self.progressView.progress = UInt(steps2 / 1000)
        }
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
