//
//  Constant.swift
//  WWOneTimePasswordView
//
//  Created by William.Weng on 2024/12/17.
//

import UIKit

// MARK: - 常數
public extension WWOneTimePasswordView {
    
    typealias BorderParameter = (width: CGFloat, color: UIColor, radius: CGFloat)    // 框線相關設定 (寬度 / 顏色 / 圓角)
    
    /// 輸入狀態
    enum Status {
        case reset              // 歸零
        case keyIn              // 正在輸入
        case finish             // 輸入完成
        case display            // 鍵盤出現
        case dismiss            // 鍵盤消失
    }
    
    /// 外形樣式
    enum AppearanceType {
        case border             // 框線
        case underLine          // 底線
    }
}
