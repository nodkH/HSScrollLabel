//
//  HSScrollLabel.swift
//  HSScrollLabel
//
//  Created by 孔祥刚 on 2019/7/25.
//  Copyright © 2019 孔祥刚. All rights reserved.
//

import UIKit

class HSScrollLabel: UIView {
    
    var valueClourse: ((Int,String) -> Void)?
    
    deinit {
        self.timer.invalidate()
        print("deinit")
    }
    
    var textDatas: Array<String>? {
        didSet {
            self.firstLabel.text = self.textDatas?[0]
            self.secondLabel.text = self.textDatas?[1] ?? ""
            if self.textDatas?.count ?? 0 > 1 {
                
                DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                    self.timer.fire()
                }
            }
        }
    }
    /// 当前点击的是第几个
    var currentIndex: Int = 0
    
    /// 当前的label的tag值
    var currentTag = 1
    
    lazy var gesture: UITapGestureRecognizer = {
        let gesture = UITapGestureRecognizer.init(target: self, action: #selector(clickLabel(label:)))
        return gesture
    }()
    
    lazy var firstLabel: UILabel = {
        let firstLabel = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height))
        firstLabel.textColor = UIColor.black
        firstLabel.numberOfLines = 2
        firstLabel.font = UIFont.systemFont(ofSize: 14)
        firstLabel.tag = 1
        firstLabel.isUserInteractionEnabled = true
        firstLabel.addGestureRecognizer(self.gesture)
        return firstLabel
    }()
    
    
    lazy var secondLabel: UILabel = {
        let secondLabel = UILabel.init(frame: CGRect.init(x: 0, y: self.frame.size.height, width: self.frame.size.width, height: self.frame.size.height))
        secondLabel.textColor = .black
        secondLabel.numberOfLines = 2
        secondLabel.font = UIFont.systemFont(ofSize: 14)
        secondLabel.tag = 2
        secondLabel.isUserInteractionEnabled = true
        secondLabel.addGestureRecognizer(self.gesture)
        return secondLabel
    }()
    
    
    lazy var timer: Timer = {
        let timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        return timer
    }()
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.clipsToBounds = true
        configView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configView () {
        self.addSubview(self.firstLabel)
        self.addSubview(self.secondLabel)
    }
    
    
    @objc func timerAction () {
        if self.currentTag == 1 {
            UIView.animate(withDuration: 0.5, animations: {
                self.firstLabel.frame = CGRect.init(x: 0, y: -self.frame.size.height, width: self.frame.size.width, height: self.frame.size.height)
                self.secondLabel.frame = CGRect.init(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
                self.secondLabel.addGestureRecognizer(self.gesture)
            }) { (finshed) in
                self.firstLabel.frame = CGRect.init(x: 0, y: self.frame.size.height, width: self.frame.size.width, height: self.frame.size.height)
                if self.currentIndex == (self.textDatas?.count ?? 0) - 1 {
                    self.currentIndex = 0
                } else {
                    self.currentIndex += 1
                }
                if self.currentIndex == (self.textDatas?.count ?? 0) - 1 {
                    self.firstLabel.text = self.textDatas?[0]
                } else {
                    self.firstLabel.text = self.textDatas?[self.currentIndex + 1]
                }
                
                self.currentTag = 2
            }
        } else {
            UIView.animate(withDuration: 0.5, animations: {
                self.secondLabel.frame = CGRect.init(x: 0, y: -self.frame.size.height, width: self.frame.size.width, height: self.frame.size.height)
                self.firstLabel.frame = CGRect.init(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
                self.firstLabel.addGestureRecognizer(self.gesture)
                
            }) { (finshed) in
                self.secondLabel.frame = CGRect.init(x: 0, y: self.frame.size.height, width: self.frame.size.width, height: self.frame.size.height)
                if self.currentIndex == (self.textDatas?.count ?? 0) - 1 {
                    self.currentIndex = 0
                } else {
                    self.currentIndex += 1
                }
                
                if self.currentIndex == (self.textDatas?.count ?? 0) - 1 {
                    self.secondLabel.text = self.textDatas?[0]
                } else {
                    self.secondLabel.text = self.textDatas?[self.currentIndex + 1]
                }
                
                
                
                self.currentTag = 1
            }
        }
    }
    
    @objc func clickLabel (label: UILabel) {
        if self.valueClourse != nil {
            self.valueClourse?(self.currentIndex,String(describing: self.textDatas?[self.currentIndex]))
        }
    }
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
}
