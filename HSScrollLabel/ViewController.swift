//
//  ViewController.swift
//  HSScrollLabel
//
//  Created by 孔祥刚 on 2019/7/25.
//  Copyright © 2019 孔祥刚. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let scroll: HSScrollLabel? = HSScrollLabel.init(frame: CGRect.init(x: 50, y: 100, width: self.view.frame.size.width - 150, height: 50))
        scroll?.layer.borderColor = UIColor.green.cgColor
        scroll?.layer.borderWidth = 1
        scroll?.layer.cornerRadius = 5
        self.view.addSubview(scroll!)
        
        scroll?.textDatas = ["中共中央总书记、国家主席、中央军委主席习近平高度重视并作出重要指示，要求全力搜救被困人员，做好伤员救治、受灾群众安置、遇难者家属安抚等善后工作。要注意科学施救，做好险情监测，防范次生灾害。习近平强调","新京报快讯（记者 李玉坤）记者今天（7月25日）从北京市十五届人大常委会第十四次会议了解到，2018年全北京市一般公共预算收入超过5.5千亿元。北京市级“三公”经费花销5.2亿元，较年初预算下降35.3%，公务接待费下降超过六成。","世界知识产权组织总干事 弗朗西斯·高锐：过去几年来 中国的创新指数排名迅速攀升，表现很突出，恭喜你们!我认为这其中的主要原因在于中国非常重视和强调创新驱动经济发展和转型，从工厂向实验室的转型，以及发展更多知识密集型的高级产业，并且取得了卓著成效。我们相信，中国创新指数的排名还将继续攀升。"]
        
        scroll?.valueClourse = {(index,content) in
            let string = String(describing: "点击了第\(index)个,内容是:\(String(describing: content))")
            let alertControl = UIAlertController.init(title: "内容", message: string, preferredStyle: .alert)
            let action = UIAlertAction.init(title: "确定", style: .default, handler: { (action) in
                alertControl.dismiss(animated: true, completion: nil)
            })
            alertControl.addAction(action)
            self.present(alertControl, animated: true, completion: nil)
        }
        //        print("\(String(describing: scroll))")
    }
    
    
}

