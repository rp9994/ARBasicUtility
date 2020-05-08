//
//  RadioButton.swift
//  RadioButton
//
//  Created by Mac Mini on 08/05/20.
//  Copyright © 2020 Ronak Adeshara. All rights reserved.
//

import Foundation
import UIKit

let radioOn = UIImage(named: "ic_radioOn")!.withRenderingMode(.alwaysOriginal)
let radioOff = UIImage(named: "ic_radioOff")!.withRenderingMode(.alwaysOriginal)

@IBDesignable
class ARRadioButton: UIButton {
    
    @IBInspectable var radioTitle : String = ""
    
    var isOn = false {
        didSet {
            if self.isOn {
                self.setImage(radioOn, for: .normal)
            } else {
                self.setImage(radioOff, for: .normal)
            }
        }
    }
    
    override func awakeFromNib() {
        self.isOn = false
        self.setImage(radioOff, for: .normal)
        self.setTitle(radioTitle, for: .normal)
        self.titleEdgeInsets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
    }
}

typealias Radio = [ARRadioButton]

extension Radio {
    
    func setInitialOption(_ selectedOption:String, completion: @escaping (Bool, ARRadioButton) -> ()) {
        self.setSelected(selectedOption)
        for btn in self {
            btn.addAction(for: .touchUpInside) {
                for radio in self {
                    if btn == radio {
                        radio.isOn = true
                        completion(true, radio)
                    } else {
                        radio.isOn = false
                        completion(false, radio)
                    }
                }
            }
        }
    }
    
    private func setSelected(_ value:String) {
        for rad in self {
            
            rad.isOn = false
            rad.setImage(radioOff, for: .normal)
            
            if rad.titleLabel!.text!.lowercased() == value.lowercased() {
                rad.isOn = true
                rad.setImage(radioOn, for: .normal)
            }
        }
    }
}

class ClosureSleeve {
    let closure: ()->()
    
    init (_ closure: @escaping () -> ()) {
        self.closure = closure
    }
    
    @objc func invoke () {
        closure()
    }
}

extension UIControl {
    
    func addAction(for controlEvents: UIControl.Event, _ closure: @escaping ()->()) {
        let sleeve = ClosureSleeve(closure)
        addTarget(sleeve, action: #selector(ClosureSleeve.invoke), for: controlEvents)
        objc_setAssociatedObject(self, "[\(arc4random())]", sleeve, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
    }
}
