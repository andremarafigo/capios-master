//
//  ContatosViewController.swift
//  capios
//
//  Created by PUCPR on 14/06/19.
//  Copyright © 2019 Adriano. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ContatosViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!{
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(R.nib.contactTableViewCell)
            tableView.isHidden = false
        }
    }
    
    var contactList: [Contact] = []
    var contato1: Contact = Contact()
    var contato2: Contact = Contact()
    
    var indicator: UIActivityIndicatorView!
    let api: ContactAPI = ContactAPI()
    let disposeBag: DisposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = R.string.main.contatosViewTitle()
        
        if let image = R.image.bruce() {
            contato1.contactAvatar = image
        }
        contato1.contactName = "Bruce"
        contato1.contactPhoneNumber = "(41)9-9999-9999"
        contato1.contactID = 0
        contato1.contactFullDetails = "Teste Full Deails"
        
        if let image = R.image.john() {
            contato1.contactAvatar = image
        }
        contato1.contactName = "John"
        contato1.contactPhoneNumber = "(41)9-9999-8888"
        contato1.contactID = 1
        contato1.contactFullDetails = "Teste Full Deails"
        
        self.createIndicator()
        
        indicator.startAnimating()
        api.rx_getContactData().subscribe(onNext: {
            [weak self] contactList in
            guard let `self` = self else { return }
            self.indicator.stopAnimating()
            self.contactList = contactList
            self.tableView.reloadData()
            }, onError: { [weak self] error in
                guard let `self` = self else { return }
                self.indicator.stopAnimating()
                let alert = UIAlertController(title: "Ixi! Deu erro", message: "Não foi possível recuperar a de contatos", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                    self.navigationController?.popViewController(animated: true)
                }))
                self.present(alert, animated: true, completion: nil)
        }).disposed(by: self.disposeBag)
        
    }
    
    func createIndicator () {
        indicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        indicator.hidesWhenStopped = true
        indicator.center = self.view.center
        indicator.transform = CGAffineTransform(scaleX: 3, y: 3)
        self.view.addSubview(indicator)
    }
}

extension ContatosViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.contactTableViewCell.identifier, for: indexPath) as? ContactTableViewCell {
            cell.configCell(avatarImage: contactList[indexPath.row].contactAvatar,
                            contactName: contactList[indexPath.row].contactName,
                            contactPhoneNumber: contactList[indexPath.row].contactPhoneNumber)
            return cell
        }
        
        return UITableViewCell()
    }
    
    
}
