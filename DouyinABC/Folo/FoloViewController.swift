//
//  FoloViewController.swift
//  DouyinABC
//
//  Created by Hans on 2023/3/21.
//

import Foundation
import UIKit

class FoloViewController: UIViewController {
    
    init(index:Int, title: String) {
        super.init(nibName: nil, bundle: nil)
        self.title = title
        view.backgroundColor = .gray
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
