//
//  DetailInfoTableViewCell.swift
//  Pokemon
//
//  Created by Vyacheslav Lagutov on 29.04.2023.
//

import UIKit

class UIDetailInfoTableViewCell: UITableViewCell {
    
    var labels: [UILabel] = []
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
//        addSubview(label)
        backgroundColor = UIColor.systemBackground.withAlphaComponent(0)
        
//        label.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
//        label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
//        label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
//        label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
//
//        label.text = "\t\u{2022} Test"
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func addUnitString(value: String) {
        let leadingAnchor = getLeadingAnchor()
        let topAnchor = getTopAnchor()
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        
        label.topAnchor.constraint(equalTo: topAnchor).isActive = true
//        label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        label.heightAnchor.constraint(equalToConstant: 30).isActive = true
        label.widthAnchor.constraint(equalToConstant: 200).isActive = true
        label.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
//        label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true

        label.text = "\t\u{2022} \(value)"
        
        labels.append(label)

    }
    
    private func getLeadingAnchor() -> NSLayoutXAxisAnchor {
        if labels.count < 2 {
            return contentView.leadingAnchor
        }
        
        if labels.count % 2 == 0 {
            return labels.last!.trailingAnchor
        } else {
            return labels[labels.count - 1].trailingAnchor
        }
    }
    
    private func getTopAnchor() -> NSLayoutYAxisAnchor {
        if labels.isEmpty || labels.count % 2 == 0 {
            return contentView.topAnchor
        } else {
            return labels.last!.bottomAnchor
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
