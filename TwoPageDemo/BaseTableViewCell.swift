//
//  BaseTableViewCell.swift
//  TwoPageDemo
//
//  Created by llt on 2022/11/2.
//

import UIKit

class BaseTableViewCell: UITableViewCell {
    
    lazy var label: UILabel = {
        label = UILabel()
//        label.textColor = UIColor.blue
//        label.backgroundColor = UIColor.lightGray
        return label
    }()
    
    var labelString: String? {
        didSet {
            label.text = labelString
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func configUI() {
        addSubview(label)
        label.snp.makeConstraints { make in
            make.left.right.top.bottom.equalTo(0)
        }
    }

}
