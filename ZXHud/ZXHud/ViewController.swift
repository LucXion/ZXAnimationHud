//
//  ViewController.swift
//  ZXHud
//
//  Created by luc xion on 2021/4/3.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.red
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        ZXAnimationHud.share.showFailProgress(msg: "错了")
    }

}

