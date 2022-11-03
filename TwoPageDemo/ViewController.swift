//
//  ViewController.swift
//  TwoPageDemo
//
//  Created by llt on 2022/11/2.
//

import UIKit
import SnapKit

let screenWidth = UIScreen.main.bounds.width
let screenHeight = UIScreen.main.bounds.height

class ViewController: UIViewController {
    
    let topViewHeight = 40
    
    private lazy var firstBtn: UIButton =  {
        var firstBtn = createButton(with: "OVERVIEW")
        firstBtn.tag = 11
        return firstBtn
    }()
    
    private lazy var secondBtn: UIButton =  {
        var secondBtn = createButton(with: "WITHDRAW")
        secondBtn.tag = 22
        return secondBtn
    }()
    
    private lazy var thirdBtn: UIButton =  {
        var thirdBtn = createButton(with: "ADDRESS BOOK")
        thirdBtn.tag = 33
        return thirdBtn
    }()
    
    private lazy var topView: UIView = {
        let top = UIView()
//        top.backgroundColor = UIColor.gray
        return top
    }()
    private lazy var topViewLine: UIView = {
        let topLine = UIView()
        topLine.backgroundColor = UIColor.red
        return topLine
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.frame = CGRect(x: 0, y: CGFloat(topViewHeight * 2), width: screenWidth, height: screenHeight - CGFloat(topViewHeight))
        scrollView.contentSize = CGSize(width: screenWidth * 3, height: screenHeight - CGFloat(topViewHeight))
        scrollView.isPagingEnabled = true
        scrollView.bounces = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.delegate = self
        return scrollView
    }()
    
    private lazy var firstView: UIView = {
        let firstView = UIView.init(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight - CGFloat(topViewHeight)))
        return firstView
    }()
    private lazy var secondView: UIView = {
        let secondView = UIView.init(frame: CGRect(x: screenWidth, y: 0, width: screenWidth, height: screenHeight - CGFloat(topViewHeight)))
        secondView.backgroundColor = UIColor.blue
        let label = UILabel(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        label.text = "第二个View"
        secondView.addSubview(label)
        return secondView
    }()
    private lazy var thirdView: UIView = {
        let thirdView = UIView.init(frame: CGRect(x: screenWidth * 2, y: 0, width: screenWidth, height: screenHeight - CGFloat(topViewHeight)))
        thirdView.backgroundColor = UIColor.yellow
        let label = UILabel(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        label.text = "第三个View"
        thirdView.addSubview(label)
        return thirdView
    }()
    
    //popView
    private lazy var popView: UIView = {
        let popView = PopView()
        popView.isHidden = true
        return popView
    }()
   
    
    @objc private func clickbtn(for button: UIButton) {
        
        print(button.tag)
        
        if button.tag == 11 {
            scrollView.contentOffset = CGPoint(x: 0, y: 0)
        } else if button.tag == 22 {
            scrollView.contentOffset = CGPoint(x: screenWidth, y: 0)
        } else {
            scrollView.contentOffset = CGPoint(x: screenWidth * 2, y: 0)
        }
        
        topViewLine.snp.remakeConstraints {
            $0.bottom.equalTo(0)
            $0.height.equalTo(1)
            $0.width.equalTo(Int(screenWidth - 30)/3)
            switch(button.tag) {
            case 11:
                $0.centerX.equalTo(firstBtn.snp_centerX).offset(0)
            case 22:
                $0.centerX.equalTo(secondBtn.snp_centerX).offset(0)
            case 33:
                $0.centerX.equalTo(thirdBtn.snp_centerX).offset(0)
            default:
                print("错误了")
            }
        }
    }
    
    func createButton(with string: String) -> UIButton {
        let overViewBtn = UIButton()
        overViewBtn.setTitle(string, for: .normal)
        overViewBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        overViewBtn.setTitleColor(UIColor.hex(hexString: "0x333333"), for: .normal)
        overViewBtn.addTarget(self, action: #selector(clickbtn(for:)), for: .touchUpInside)
        return overViewBtn
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        configUI()
        
        
        view.addSubview(popView)
        popView.snp.makeConstraints { make in
            make.left.right.top.bottom.equalTo(0)
        }
    }
    
    func configUI() {
        //添加topView
        view.addSubview(topView)
        topView.snp.makeConstraints {
            $0.height.top.equalTo(topViewHeight)
            $0.left.right.equalTo(0)
        }

        topView.addSubview(firstBtn)
        topView.addSubview(secondBtn)
        topView.addSubview(thirdBtn)

        firstBtn.snp.makeConstraints {
            $0.top.bottom.left.equalTo(0)
            $0.right.equalTo(secondBtn.snp.left).offset(0)
            $0.width.equalTo(secondBtn)
        }
        secondBtn.snp.makeConstraints {
            $0.top.bottom.equalTo(0)
            $0.left.equalTo(firstBtn.snp.right).offset(0)
            $0.right.equalTo(thirdBtn.snp.left).offset(0)
            $0.width.equalTo(thirdBtn)
        }
        thirdBtn.snp.makeConstraints {
            $0.top.bottom.right.equalTo(0)
            $0.left.equalTo(secondBtn.snp_right).offset(0)
            $0.width.equalTo(firstBtn)
        }
        
        //添加topLine
        firstBtn.addSubview(topViewLine)
        topViewLine.snp.makeConstraints {
            $0.width.equalTo(Int(screenWidth - 30)/3)
            $0.centerX.equalTo(firstBtn.snp_centerX).offset(0)
            $0.bottom.equalTo(0)
            $0.height.equalTo(1)
        }
        //添加scrollView
        view.addSubview(scrollView)
        scrollView.addSubview(firstView)
        scrollView.addSubview(secondView)
        scrollView.addSubview(thirdView)
        
        let commonFirstView = CommonListView()
        commonFirstView.titleString = "Select crypto"
        firstView.addSubview(commonFirstView)
        commonFirstView.snp.makeConstraints {
            $0.left.equalTo(20)
            $0.right.equalTo(-20)
            $0.top.equalTo(scrollView.snp_bottom).offset(20)
            $0.height.equalTo(80)
        }
        
        let commonSecondView = CommonListView()
        commonSecondView.titleString = "NetWork"
        firstView.addSubview(commonSecondView)
        commonSecondView.snp.makeConstraints {
            $0.left.equalTo(20)
            $0.right.equalTo(-20)
            $0.top.equalTo(commonFirstView.snp_top).offset(120)
            $0.height.equalTo(80)
        }
        

        
        let commonThirdView = CommonListView()
        commonThirdView.titleString = "Withdraw to"
        firstView.addSubview(commonThirdView)
        firstView.insertSubview(commonSecondView, aboveSubview: commonThirdView)
        firstView.insertSubview(commonFirstView, aboveSubview: commonSecondView)
        commonThirdView.snp.makeConstraints {
            $0.left.equalTo(20)
            $0.right.equalTo(-20)
            $0.top.equalTo(commonSecondView.snp_top).offset(120)
            $0.height.equalTo(80)
        }
        //popView是否隐藏
        commonThirdView.selectCell = { [weak self] in
            if self?.popView.isHidden == true {
                self?.popView.isHidden = false
            } else {
                self?.popView.isHidden = true
            }
        }
    }
}

extension ViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.scrollView == scrollView {
            if scrollView.contentOffset.x <= screenWidth / 2 {
                topViewLine.snp.remakeConstraints {
                    $0.width.equalTo(Int(screenWidth - 30)/3)
                    $0.centerX.equalTo(firstBtn.snp_centerX).offset(0)
                    $0.bottom.equalTo(0)
                    $0.height.equalTo(1)
                }
            } else if (scrollView.contentOffset.x > screenWidth / 2) && (scrollView.contentOffset.x < screenWidth / 2 + screenWidth) {
                topViewLine.snp.remakeConstraints {
                    $0.width.equalTo(Int(screenWidth - 30)/3)
                    $0.centerX.equalTo(secondBtn.snp_centerX).offset(0)
                    $0.bottom.equalTo(0)
                    $0.height.equalTo(1)
                }
            } else {
                topViewLine.snp.remakeConstraints {
                    $0.width.equalTo(Int(screenWidth - 30)/3)
                    $0.centerX.equalTo(thirdBtn.snp_centerX).offset(0)
                    $0.bottom.equalTo(0)
                    $0.height.equalTo(1)
                }
            }
        }
    }
}




