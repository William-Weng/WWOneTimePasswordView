//
//  Delegate.swift
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
    ///   - status: 輸入狀態
    ///   - password: 輸入的密碼
    ///   - replacementString: 當前輸入的字元
    func oneTimePasswordView(_ oneTimePasswordView: WWOneTimePasswordView, status: WWOneTimePasswordView.Status, password: String, replacementString: String?)
}
