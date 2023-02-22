//
//  SRCopyableLabel.swift
//
//  Created by Stephen Radford on 08/09/2015.
//  Copyright (c) 2015 Cocoon Development Ltd. All rights reserved.
//  https://stephenradford.me/make-uilabel-copyable/

import UIKit

class SRCopyableLabel: UILabel {

    override public var canBecomeFirstResponder: Bool {
        get {
            return true
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        sharedInit()
        print ("SRCopyableLabel")
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        sharedInit()
    }

    func sharedInit() {
        isUserInteractionEnabled = true
        addGestureRecognizer(UILongPressGestureRecognizer(
            target: self,
            action: #selector(showMenu(sender:))
        ))
    }

    override func copy(_ sender: Any?) {
        UIPasteboard.general.string = text
        UIMenuController.shared.hideMenu()

//setMenuVisible(_:animated:)' was deprecated in iOS 13.0: Use showMenuFromView:rect: or hideMenuFromView: instead.
        //        UIMenuController.shared.setMenuVisible(false, animated: true)
    }

    @objc func showMenu(sender: Any?) {
        becomeFirstResponder()
        let menu = UIMenuController.shared
        if !menu.isMenuVisible {
//            menu.setTargetRect(bounds, in: self)
//            menu.setMenuVisible(true, animated: true)
            UIMenuController.shared.showMenu(from: superview!, rect: superview!.frame)

        }
    }

    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return (action == #selector(copy(_:)))
    }
}
