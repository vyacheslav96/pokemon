//
//  UICardViewController.swift
//  Pokemon
//
//  Created by Vyacheslav Lagutov on 25.04.2023.
//

import UIKit

class UICardViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var pokemon: PokemonCodable?
    var name: String?
    var dataManager = DataManager()
    var frontIcon = UISprite()
    var detailTable = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addfrontIcon()
        addTableView()
        fetchData()
        
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 20
        view.layer.borderWidth = 1
    }
    
    func addfrontIcon() {
        view.addSubview(frontIcon)
        
        frontIcon.translatesAutoresizingMaskIntoConstraints = false
        frontIcon.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
        frontIcon.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 5).isActive = true
        frontIcon.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -5).isActive = true
        frontIcon.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.45).isActive = true
        
        frontIcon.backgroundColor = .white.withAlphaComponent(0.5)
        
        frontIcon.layer.shadowOpacity = 0.5
        frontIcon.layer.shadowOffset = CGSize(width: 0, height: 3)
        frontIcon.layer.shadowRadius = 3
        frontIcon.layer.shadowColor = UIColor.gray.cgColor
        frontIcon.layer.masksToBounds = false
        
        frontIcon.layer.borderWidth = 1
        frontIcon.layer.cornerRadius = 20
        frontIcon.layer.borderWidth = 1
    }
    
    func addTableView() {
        view.addSubview(detailTable)
        
        detailTable.dataSource = self
        detailTable.delegate = self
        
        detailTable.translatesAutoresizingMaskIntoConstraints = false
        detailTable.topAnchor.constraint(equalTo: frontIcon.bottomAnchor, constant: 5).isActive = true
        detailTable.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 5).isActive = true
        detailTable.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -5).isActive = true
        detailTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        
        detailTable.backgroundColor = UIColor.systemBackground.withAlphaComponent(0)
        
        detailTable.register(UIDetailInfoTableViewCell.self, forCellReuseIdentifier: "DetailCell")
        detailTable.separatorStyle = .none
        detailTable.allowsSelection = false
        detailTable.isScrollEnabled = false
    }
    
    func fetchData() {
        guard let p = pokemon else { return }
        
        title = p.name
        
        let nm = NetworkManager()
        nm.fetchSpecies(name: p.id) { [unowned self] species in
            DispatchQueue.main.async {
                guard let img = UIImage(named: species.color.name) else { return }
                self.view.layer.contents = img.cgImage
            }
        }
        
        guard let urlStr = p.sprites.other?.home?.front_default else { return }
        let url = URL(string: urlStr)!
        frontIcon.loadImageWithUrl(url)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var result = ""
        
        if section == 0 {
            result = "ABILITIES"
        } else {
            result = "TYPES"
        }
        
        return result
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath) as! UIDetailInfoTableViewCell
        guard let pokemon = pokemon else { return cell }
        
        if indexPath.section == 0 {
            pokemon.abilities.forEach { ability in
                cell.addUnitString(value: ability.ability.name)
            }
        } else {
            pokemon.types.forEach { type in
                cell.addUnitString(value: type.type.name)
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
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
