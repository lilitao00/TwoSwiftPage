//
//  CommonListView.swift
//  TwoPageDemo
//
//  Created by llt on 2022/11/2.
//

import UIKit

typealias CommonListViewSelectCellBlock = () -> Void

class CommonListView: UIView {
    
    var selectCell: CommonListViewSelectCellBlock?

    var tableViewisHidden = true
    
    var titleString: String? {
        didSet {
            firstLabel.text = titleString
        }
    }
    
    private lazy var firstArray: Array = {
        return ["111", "222", "333", "444", "555", "666", "777", "888", "999"]
    }()

    private lazy var firstLabel: UILabel = {
        let firstLable = UILabel()
        firstLable.text = "Select crypto"
        return firstLable
    }()
    
    private lazy var contentLabel: UILabel = {
        let contentLabel = UILabel()
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        tap.numberOfTapsRequired = 1
        contentLabel.addGestureRecognizer(tap)
        contentLabel.isUserInteractionEnabled = true
        contentLabel.text = "请选择"
        return contentLabel
    }()
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.layer.cornerRadius = 5
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        contentView.layer.borderWidth = 1
        return contentView
    }()
    
    lazy var tableView: UITableView = {
        let tw = UITableView(frame: .zero, style: .grouped)
        tw.backgroundColor = UIColor.blue
        tw.delegate = self
        tw.dataSource = self
        tw.register(BaseTableViewCell.self, forCellReuseIdentifier: NSStringFromClass(BaseTableViewCell.self))
        return tw
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func tapAction() {
        print("click")
        tableViewisHidden = !tableViewisHidden
        if tableViewisHidden == true {
            self.snp.updateConstraints { make in
                make.height.equalTo(80)
            }
        } else if tableViewisHidden == false {
            self.snp.updateConstraints { make in
                make.height.equalTo(230)
            }
        }
        tableView.reloadData()
    }
    
    func configUI() {
        addSubview(firstLabel)
        firstLabel.snp.makeConstraints {
            $0.left.right.top.equalTo(0)
            $0.height.equalTo(30)
        }
        
        addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.left.bottom.right.equalTo(0)
            make.top.equalTo(firstLabel.snp_bottom).offset(0)
        }
        
        //添加内容label
        contentView.addSubview(contentLabel)
        contentLabel.snp.makeConstraints { make in
            make.left.right.equalTo(0)
            make.top.equalTo(contentView.snp_top).offset(0)
            make.height.equalTo(50)
        }
        
        contentView.addSubview(tableView)
        
        tableView.backgroundColor = UIColor.blue
        tableView.snp.makeConstraints { make in
            make.left.right.equalTo(0)
            make.top.equalTo(contentLabel.snp_bottom).offset(0)
            make.bottom.equalTo(contentView.snp_bottom).offset(0)
        }
        tableView.reloadData()

    }

}

extension CommonListView: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return firstArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(BaseTableViewCell.self), for: indexPath) as! BaseTableViewCell
        
        let labelString = firstArray[indexPath.row]
//        cell.textLabel?.text = labelString
        cell.labelString = labelString
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let labelString = firstArray[indexPath.row]
        contentLabel.text = labelString
        //选中后关闭下拉菜单
        tapAction()
        
        //block回调
        guard let selectCell = selectCell else { return }
        selectCell()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
}
