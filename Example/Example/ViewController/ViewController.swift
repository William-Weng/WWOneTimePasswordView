//
//  ViewController.swift
//  Example
//
//  Created by William.Weng on 2024/12/17.
//

import UIKit
import WWOneTimePasswordView

@IBDesignable
final class MyOneTimePasswordView: WWOneTimePasswordView {}

// MARK: - ViewController
final class ViewController: UIViewController {
    
    @IBOutlet weak var password1View: MyOneTimePasswordView!
    @IBOutlet weak var password2View: MyOneTimePasswordView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        password1View.initSetting(count: 6, appearanceType: .border)
        password1View.delegate = self
        
        password2View.initSetting(count: 4, appearanceType: .underLine, codeLabelFont: .systemFont(ofSize: 56.0), codeLabelBackgroundColor: .clear)
        password2View.delegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    @IBAction func resetCode1View(_ sender: UIBarButtonItem) {
        password1View.reset()
    }
    
    @IBAction func resetCode2View(_ sender: UIBarButtonItem) {
        password2View.reset()
    }
}

// MARK: - WWOneTimePasswordViewDelegate
extension ViewController: WWOneTimePasswordViewDelegate {
    
    func oneTimePasswordView(_ oneTimePasswordView: WWOneTimePasswordView, status: WWOneTimePasswordView.Status, password: String, replacementString: String?) {
        print("\(oneTimePasswordView.tag) => \(status) => \(password) => \(replacementString ?? "<nil>")")
    }
}
