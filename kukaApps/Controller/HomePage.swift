//
//  HomePage.swift
//  kukaApps
//
//  Created by Yusuf Burak Elkan on 27.04.2022.
//

import UIKit
import SwiftyJSON
import CoreData

let appDelegate = UIApplication.shared.delegate as! AppDelegate
class HomePage: UIViewController {

    @IBOutlet weak var listingViewCell: UITableView!
    
    let context = appDelegate.persistentContainer.viewContext
    var list = [listing]()
    var listingg = [Favori]()
    override func viewDidLoad() {
        super.viewDidLoad()
        data()
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    let Detay = UIContextualAction(style: .normal, title: "Detay") {  (contextualAction, view, boolValue) in
        let index = indexPath[1]
        let indexp = index
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let mainVC = storyboard.instantiateViewController(withIdentifier: "detail") as! detailPage
        let list = indexp
        mainVC.id = list
            mainVC.modalPresentationStyle = .custom
            mainVC.modalTransitionStyle = .crossDissolve
            self.present(mainVC, animated: true, completion: nil)
}
        let favorites = UIContextualAction(style: .destructive, title: "Favorilerime Ekle") { [self]  (contextualAction, view, boolValue) in
            do{
                listingg = try context.fetch(Favori.fetchRequest())
            }catch{
            }
            for k in listingg{
                print("namee:\(k.name!) --- pointt\(k.point!)")
            }
            let alertController = UIAlertController(title: "KukaApps", message: "Favorilerime Eklendi!..😎", preferredStyle: .alert)
            let tamamAction = UIAlertAction(title: "Tamam", style: .cancel){
                action in
            }
            alertController.addAction(tamamAction)
    DispatchQueue.main.async(execute: {
    self.present(alertController, animated: true)
     })
        }
        return UISwipeActionsConfiguration(actions: [Detay, favorites])
}
    func data(){
       listingViewCell.dataSource = self
       listingViewCell.delegate = self
        let semaphore = DispatchSemaphore (value: 0)
        var request = URLRequest(url: URL(string: "https://my-json-server.typicode.com/oguzayan/kuka/drivers")!,timeoutInterval: Double.infinity)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
          guard let data = data else {
            print(String(describing: error))
            semaphore.signal()
            return
          }
            let json = JSON(data)
            let items = json["items"]
            for i in (0...items.count-1) {
                let itemss = items[i]
                let name = itemss["name"]
                let point = itemss["point"]
                let f1 = listing(name: "\(name)", point: "\(point)")
                self.list.append(f1)
                let list = Favori(context: self.context)
                list.name = "\(name)"
                list.point = "\(point)"
                appDelegate.saveContext()
            }
          semaphore.signal()
        }
        task.resume()
        semaphore.wait()
    }
}
extension HomePage: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "listHucre", for: indexPath) as? listingTableViewCell else {return UITableViewCell()}
        let incominglist = list[indexPath.row]
        cell.name.text = incominglist.name
        cell.point.text = incominglist.point
        return cell
    }
}
