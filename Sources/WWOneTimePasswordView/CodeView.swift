//
//  CodeView.swift
//  WWOneTimePasswordView
//
//  Created by William.Weng on 2024/12/17.
//

import UIKit

// MARK: - 輸入Code的View
class CodeView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var cursorLineView: UIView!
    @IBOutlet weak var inputLabel: UILabel!
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        initSetting()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initSetting()
    }
}

// MARK: - 公用工具
extension CodeView {
    
    /// 外形相關設定
    /// - Parameters:
    ///   - font: UIFont?
    ///   - borderParameter: WWOneTimePasswordView.BorderParameter
    func setting(font: UIFont? = nil, borderParameter: WWOneTimePasswordView.BorderParameter) {
        if let font = font { inputLabel.font = font }
        contentView.layer._borderColor(borderParameter.color)._borderWidth(borderParameter.width)._cornerRadius(borderParameter.radius)
    }
    
    /// 設定游標的顯示狀態
    /// - Parameter isDisplay: Bool
    func cursorView(isDisplay: Bool) {
        cursorLineView.isHidden = !isDisplay
    }
    
    /// 重置文字相關設定
    func resetText(with borderParameter: WWOneTimePasswordView.BorderParameter) {
        inputLabel.text = nil
        cursorView(isDisplay: false)
        setting(borderParameter: borderParameter)
    }
    
    /// 取得文字
    /// - Returns: String?
    func code() -> String? {
        return inputLabel.text
    }
}

// MARK: - 小工具
private extension CodeView {
    
    /// 初始化設定
    func initSetting() {
        initViewFromXib()
        cursorLineView.isHidden = true
        cursorLineView._cursorBlinkAnimation()
    }
    
    /// 讀取Nib畫面 => 加到View上面
    func initViewFromXib() {
        
        let bundle = Bundle.module
        let name = String(describing: CodeView.self)
        
        bundle.loadNibNamed(name, owner: self, options: nil)
        contentView.frame = bounds
        
        addSubview(contentView)
    }
}

