//
//  TextFieldView.swift
//  Conviva
//
//  Created by Gabriel Ferreira on 12/11/19.
//  Copyright © 2019 Gabriel Ferreira. All rights reserved.
//

import UIKit

class TextFieldView: UIView {
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var emptyTextndicator: UILabel!
    
    override func draw(_ rect: CGRect) {
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commomInit()
    }
    
    required init?(coder aDrecoder: NSCoder) {
        super.init(coder: aDrecoder)
        
        commomInit()
    }
    
    private func commomInit() {
        Bundle.main.loadNibNamed("TextFieldView", owner: self, options: nil)
        addSubview(contentView)
        self.contentView.frame = self.bounds
        self.contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.textField.attributedPlaceholder =
            NSAttributedString(string: "placeholder text",
                               attributes: [NSAttributedString.Key.font: UIFont(name: "Ubuntu", size: 16)
                                                                        ?? UIFont.systemFont(ofSize: 16),
                                NSAttributedString.Key.foregroundColor: UIColor(named: "ConvivaTextColor")
                                                                        ?? UIColor.systemPurple])
        self.emptyTextndicator.isHidden = true
    }

}
