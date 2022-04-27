//
//  detailPage.swift
//  kukaApps
//
//  Created by Yusuf Burak Elkan on 27.04.2022.
//

import UIKit
import SwiftyJSON
import SDWebImage
import WebKit

class detailPage: UIViewController {
    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var teamInfo: UILabel!
    @IBOutlet weak var age: UILabel!
    var id = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        detailData()
    }
    func detailData(){
        let semaphore = DispatchSemaphore (value: 0)
        var request = URLRequest(url: URL(string: "https://my-json-server.typicode.com/oguzayan/kuka/driverDetail/?id=\(id+1)")!,timeoutInterval: Double.infinity)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { [self] data, response, error in
          guard let data = data else {
            print(String(describing: error))
            semaphore.signal()
            return
          }
            let jsonn = JSON(data)
            let json = jsonn[0]
            let age = json["age"]
            let team = json["team"]
            let image = json["image"]
            print("\(age) - \(team) - \(image)")
            let urlString = "\(image)"
            detailImage.contentMode = .scaleToFill
            detailImage.clipsToBounds = true
            view.addSubview(detailImage)
            detailImage.center = view.center
            detailImage.sd_setImage(with: URL(string: urlString),
        placeholderImage: UIImage(systemName: "photo"),
        options: .continueInBackground,
        completed: nil)
            self.teamInfo.text = "Team: \(team)"
            self.age.text = "Age: \(age)"
          print(String(data: data, encoding: .utf8)!)
          semaphore.signal()
        }
        task.resume()
        semaphore.wait()
    }
    @IBAction func backButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainVC = storyboard.instantiateViewController(withIdentifier: "HomePage")
        mainVC.modalPresentationStyle = .custom
        mainVC.modalTransitionStyle = .crossDissolve
        self.present(mainVC, animated: true, completion: nil)
    }
}
