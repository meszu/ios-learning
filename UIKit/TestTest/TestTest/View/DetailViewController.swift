//
//  DetailViewController.swift
//  TestTest
//
//  Created by Mészáros Kristóf on 2023. 01. 07..
//

import UIKit

class DetailViewController: UIViewController {
    
    private var offerDetail: Detail?

    @IBOutlet weak var headlineLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let offerDetail = offerDetail else { fatalError("Please pass in a valid Detail object") }
        title = offerDetail.name
        layoutDetails(theoffer: offerDetail)
    }
    
    func layoutDetails(theoffer: Detail) {
        
        headlineLabel.text = theoffer.name
        headlineLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        
        subtitleLabel.text = theoffer.shortDescription
        subtitleLabel.font = UIFont.systemFont(ofSize: 16)
        
        bodyLabel.text = theoffer.description
        bodyLabel.font = UIFont.systemFont(ofSize: 12, weight: .light)
    }
}

extension DetailViewController {
    static func instantiate(offerDetail: Detail) -> DetailViewController {
      guard let vc = UIStoryboard(name: "Main", bundle: nil)
        .instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else { fatalError("Unexpectedly failed getting DetailViewController from Storyboard") }

      vc.offerDetail = offerDetail

      return vc
    }
}
