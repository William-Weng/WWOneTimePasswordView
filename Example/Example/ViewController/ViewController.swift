//
//  ViewController.swift
//  Example
//
//  Created by William.Weng on 2024/12/17.
//

import UIKit
import WWPrint
import WWOneTimePasswordView

@IBDesignable
final class MyOneTimePasswordView: WWOneTimePasswordView {}

// MARK: - ViewController
final class ViewController: UIViewController {
    
    @IBOutlet weak var passwordView: MyOneTimePasswordView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordView.initSetting(with: 6)
        passwordView.delegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    @IBAction func resetCodeView(_ sender: UIBarButtonItem) {
        passwordView.reset()
    }
}

// MARK: - WWOneTimePasswordViewDelegate
extension ViewController: WWOneTimePasswordViewDelegate {
    
    func oneTimePasswordView(_ oneTimePasswordView: WWOneTimePasswordView, status: WWOneTimePasswordView.Status, password: String, replacementString: String?) {
        wwPrint("\(status) => \(password) => \(replacementString ?? "<nil>")")
    }
}
