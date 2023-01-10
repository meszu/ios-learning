//
//  OffersViewController.swift
//  TestTest
//
//  Created by Mészáros Kristóf on 2023. 01. 07..
//

import Moya
import UIKit

class OffersViewController: UIViewController {
    
    let provider = MoyaProvider<Offerzz>()
    
    @IBOutlet var tblOffers: UITableView!
    
    var specialOffers: [Offer] = Offers.mockData
    
    var normalOffers: [Offer] = Offers.mockData.shuffled()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblOffers.delegate = self
        tblOffers.dataSource = self
        
        tblOffers.rowHeight = UITableView.automaticDimension
        tblOffers.estimatedRowHeight = 140
        
        navigationController?.navigationBar.barTintColor = UIColor.white
                     
        title = "Offers"
        
        /* Set the DetailView's back button's title to "Back" */
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
        
        
        
        provider.request(.offers) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let response):
                do {
                    print(try response.mapJSON())
                } catch {
                    print("error")
                }
            case .failure:
                print("errooor")
            }
        }
    }
    
    func createOffers() -> [Offer] {
        var tempOffers: [Offer] = []
        
        let offer1 = Offer(id: "1", rank: 1, isSpecial: true, name: "100MB", shortDescription: "rovid 100 MB adat")
        let offer2 = Offer(id: "2", rank: 2, isSpecial: true, name: "300MB", shortDescription: "gyors 300MB adat very nice")
        let offer3 = Offer(id: "3", rank: 3, isSpecial: false, name: "400MB", shortDescription: "gyors 400MB internet")
        
        tempOffers.append(offer1)
        tempOffers.append(offer2)
        tempOffers.append(offer3)
        
        return tempOffers
    }
    
    var sections: [Section] = [
        Section(title: "Special Offers",
                cells: Offers.mockData
               ),
        Section(title: "Offers",
                cells: Offers.mockData.reversed()
               )]
    
}

// MARK: - UITableView Delegate & Data Source

extension OffersViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OfferCell.reuseIdentifier, for: indexPath) as! OfferCell

        let currentOffer = sections[indexPath.section].cells[indexPath.row]
        
        cell.configureWith(currentOffer)

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailViewController.instantiate(offerDetail: Detail(id: 1, name: "Bestest 1 GB", shortDescription: "legjobb egy giga amit csak kaphatsz", description: "Remek ár érték arányban kaphatod meg ezt a csúcsszuper egy gigabájtnyi adatot amit arra használsz fel amire csak akarsz"))
        navigationController?.show(detailVC, sender: self)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
//    func tableView(_ tableView: UITableView,
//      titleForHeaderInSection section: Int) -> String? {
//        return sections[section].title
//    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionHeaderLabelView = UIView()
        sectionHeaderLabelView.backgroundColor = UIColor(named: "cellBackground")
        sectionHeaderLabelView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: 72)
        
        let sectionHeaderLabel = UILabel()
        sectionHeaderLabel.text = sections[section].title
        sectionHeaderLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle).withWeight(.semibold)
        sectionHeaderLabel.frame = CGRect(x: 16, y: 8, width: 250, height: 35)
        
        sectionHeaderLabelView.addSubview(sectionHeaderLabel)
//        sectionHeaderLabel.translatesAutoresizingMaskIntoConstraints = false
//        sectionHeaderLabel.centerXAnchor.constraint(equalTo: sectionHeaderLabelView.centerXAnchor).isActive
//        sectionHeaderLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: sectionHeaderLabelView.leadingAnchor, multiplier: 2).isActive
        
        return sectionHeaderLabelView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 72
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
}

