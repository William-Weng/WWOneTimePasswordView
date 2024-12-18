//
//  Constant.swift
//  WWOneTimePasswordView
//
//  Created by William.Weng on 2024/12/17.
//

import UIKit

// MARK: - 常數
public extension WWOneTimePasswordView {
    
    public typealias BorderParameter = (width: CGFloat, color: UIColor, radius: CGFloat)     // 框線相關設定 (寬度 / 顏色 / 圓角)
    
    /// 輸入狀態
    public enum Status {
        case reset              // 歸零
        case keyIn              // 正在輸入
        case finish             // 輸入完成
        case display            // 鍵盤出現
        case dismiss            // 鍵盤消失
    }
}
