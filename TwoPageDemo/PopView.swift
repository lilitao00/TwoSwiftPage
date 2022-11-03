//
//  PopView.swift
//  TwoPageDemo
//
//  Created by llt on 2022/11/2.
//

import UIKit

class PopView: UIView {
    
    private lazy var bigView: UIView = {
        let bigView = UIView()
        bigView.layer.cornerRadius = 5
        bigView.backgroundColor = UIColor.white
        return bigView
    }()
    
    private lazy var closeBtn: UIButton =  {
        let closeBtn = UIButton()
        closeBtn.setTitle("close", for: .normal)
        closeBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        closeBtn.setTitleColor(UIColor.hex(hexString: "0x333333"), for: .normal)
        closeBtn.addTarget(self, action: #selector(clickbtn(for:)), for: .touchUpInside)
        return closeBtn
    }()
    
    @objc private func clickbtn(for button: UIButton) {
        self.isHidden = true
    }
    
    @objc private func tapAction() {
        self.isHidden = true
    }
    
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configUI() {
        self.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        tap.numberOfTapsRequired = 1
        addGestureRecognizer(tap)
        
        addSubview(bigView)
        bigView.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(0)
            make.height.equalTo(300)
        }
        
        bigView.addSubview(closeBtn)
        closeBtn.snp.makeConstraints { make in
            make.top.equalTo(20)
            make.right.equalTo(-20)
            make.width.equalTo(50)
            make.height.equalTo(30)
        }
        
        let titleLabel = UILabel()
        titleLabel.text = "标题"
        titleLabel.font = UIFont.systemFont(ofSize: 25)
        bigView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(40)
            make.centerX.equalTo(bigView)
        }
        
        let contentLabel = UILabel()
        contentLabel.text = "Verify with Email"
        contentLabel.font = UIFont.systemFont(ofSize: 14)
        bigView.addSubview(contentLabel)
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp_bottom).offset(20)
            make.centerX.equalTo(titleLabel)
        }
        
        let leftlineLabel = UILabel()
        leftlineLabel.backgroundColor = UIColor.lightGray
        bigView.addSubview(leftlineLabel)
        leftlineLabel.snp.makeConstraints { make in
            make.left.equalTo(20)
            make.right.equalTo(contentLabel.snp_left).offset(-20)
            make.height.equalTo(1)
            make.centerY.equalTo(contentLabel)
        }
        
        let rightlineLabel = UILabel()
        rightlineLabel.backgroundColor = UIColor.lightGray
        bigView.addSubview(rightlineLabel)
        rightlineLabel.snp.makeConstraints { make in
            make.left.equalTo(contentLabel.snp_right).offset(20)
            make.right.equalTo(-20)
            make.height.equalTo(1)
            make.centerY.equalTo(contentLabel)
        }
        
        let textField = UITextField()
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        bigView.addSubview(textField)
        textField.snp.makeConstraints { make in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.top.equalTo(contentLabel.snp_bottom).offset(20)
            make.height.equalTo(50)

        }


        let sureBtn = UIButton()
        sureBtn.backgroundColor = UIColor.red
        sureBtn.setTitle("Confirm", for: .normal)
        sureBtn.setTitleColor(UIColor.white, for: .normal)
        sureBtn.layer.cornerRadius = 5
        sureBtn.addTarget(self, action: #selector(clickbtn(for:)), for: .touchUpInside)
        bigView.addSubview(sureBtn)
        sureBtn.snp.makeConstraints { make in
            make.left.equalTo(40)
            make.right.bottom.equalTo(-40)
            make.height.equalTo(50)
        }
    }
}
