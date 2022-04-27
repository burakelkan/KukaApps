//
//  animatedController.swift
//  kukaApps
//
//  Created by halil ibrahim Elkan on 27.04.2022.
//

import UIKit

class animatedController: UIViewController {
    
    @IBOutlet weak var animatedImage: UIImageView!
    var image1 = UIImage(named: "1")!
    var image2 = UIImage(named: "2")!
    var image3 = UIImage(named: "3")!
    var image4 = UIImage(named: "4")!
    var image5 = UIImage(named: "5")!
    var image6 = UIImage(named: "6")!
    var image7 = UIImage(named: "7")!
    var image8 = UIImage(named: "8")!
    var image9 = UIImage(named: "9")!
    var image10 = UIImage(named: "10")!
    override func viewDidLoad() {
        super.viewDidLoad()
        animated()
        
    }
    func animated(){
        DispatchQueue.main.asyncAfter(deadline: .now()+6.3) {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let mainVC = storyboard.instantiateViewController(withIdentifier: "HomePage")
            mainVC.modalPresentationStyle = .custom
            mainVC.modalTransitionStyle = .crossDissolve
            self.present(mainVC, animated: true, completion: nil)
        }
        var sayac = 0.0
        for a in 1...15{
            print(a)
            for i in [image1,image2,image3,image4,image5,image6,image7,image8,image9,image10]{
                func hello() {
                    animatedImage.image = i
                }
                func function() {
                    let delayTime = DispatchTime.now() + sayac
                    animatedImage.image = i
                    DispatchQueue.main.asyncAfter(deadline: delayTime, execute: {hello()})
                }
                function()
                sayac = sayac + 0.1
                print(sayac)
            }
        }
        func function() {
            let delayTime = DispatchTime.now() + 2
            animatedImage.image = image1
            DispatchQueue.main.asyncAfter(deadline: delayTime, execute: {hello()})
        }
        func hello() {
        }
        function()
        UIView.animate(withDuration: 6
                       , delay: 2
            , animations: {
            self.animatedImage.transform = CGAffineTransform(translationX: 500, y: 0)
        },completion: nil)
    }
}
