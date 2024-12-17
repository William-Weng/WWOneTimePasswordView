//
//  WWVerificationCodeViewDelegate.swift
//  WWOneTimePasswordView
//
//  Created by William.Weng on 2024/12/17.
//

import Foundation

// MARK: - WWOneTimePasswordViewDelegate
public protocol WWOneTimePasswordViewDelegate: AnyObject {
    
    /// 取得輸入的密碼
    /// - Parameters:
    ///   - oneTimePasswordView: WWOneTimePasswordView
    ///   - password: 輸入的密碼
    ///   - replacementString: 當前輸入的字元
    func oneTimePasswordView(_ oneTimePasswordView: WWOneTimePasswordView, password: String, replacementString: String)
}
