//
//  favoritesPage.swift
//  kukaApps
//
//  Created by Yusuf Burak Elkan on 27.04.2022.
//

import UIKit
import CoreData

let appDelegatee = UIApplication.shared.delegate as! AppDelegate
class favoritesPage: UIViewController {

    @IBOutlet weak var favoriListViewCell: UITableView!
    
    let context = appDelegate.persistentContainer.viewContext
    var listing = [Favori]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tumKisierlAl()
        favoriListViewCell.delegate = self
        favoriListViewCell.dataSource = self
    }
    func tumKisierlAl(){
        do {
            listing = try context.fetch(Favori.fetchRequest())
        } catch  {
            print(error)
        }
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    let remove = UIContextualAction(style: .destructive, title: "Favorilerimden Kaldır!") {  (contextualAction, view, boolValue) in
        let list = self.listing[indexPath.count]
        self.listing.remove(at: indexPath.row)
        self.favoriListViewCell.deleteRows(at: [indexPath], with: UITableView.RowAnimation.right)
        self.context.delete(list)
        appDelegate.saveContext()
        }
        return UISwipeActionsConfiguration(actions: [remove])
    }
}
extension favoritesPage:UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listing.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let kisi = listing[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriList", for: indexPath) as! favoriListTableViewCell
        cell.favoriName.text = "\(kisi.name!)"
        cell.favoriPoint.text = "\(kisi.point!)"
        return cell
    }
}
