//
//  WWVerificationCodeView.swift
//  WWOneTimePasswordView
//
//  Created by William.Weng on 2024/12/17.
//

import UIKit

// MARK: - 一次性密碼輸入框
@IBDesignable
open class WWOneTimePasswordView: UIView {
    
    @IBInspectable var digitCodeCount: Int = 6
    @IBInspectable var textColor: UIColor = .black

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var codeStackView: UIStackView!
    @IBOutlet weak var inputTextField: UITextField!
    
    public weak var delegate: WWOneTimePasswordViewDelegate?
    
    private var codeLabelFont: UIFont = .systemFont(ofSize: 20.0)
    private var generalBorderParameter: BorderParameter = (width: 1.0, color: .black, radius: 8.0)
    private var selectedBorderParameter: BorderParameter = (width: 3.0, color: .red, radius: 8.0)
    private var spacing: CGFloat = 8.0

    override public init(frame: CGRect) {
        super.init(frame: frame)
        initViewFromXib()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initViewFromXib()
    }
    
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        inputTextField.becomeFirstResponder()
    }
    
    open override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        initSetting(with: digitCodeCount)
    }
    
    deinit {
        delegate = nil
    }
}

// MARK: - 公開函式
public extension WWOneTimePasswordView {
    
    /// [初始化設定](https://medium.com/@dejanvu.developer/email-verification-with-sent-codes-in-ruby-on-rails-a-step-by-step-guide-039bcf194634)
    /// - Parameters:
    ///   - digitCodeCount: 輸入框的數量
    ///   - spacing: 文字框之間的間隔
    ///   - codeLabelFont: 字體
    ///   - generalBorderParameter: 一般時的框線數值
    ///   - selectedBorderParameter: 輸入時的框線數值
    func initSetting(with digitCodeCount: Int? = nil, spacing: CGFloat? = nil, codeLabelFont: UIFont? = nil, generalBorderParameter: BorderParameter? = nil, selectedBorderParameter: BorderParameter? = nil) {
        
        if let digitCodeCount = digitCodeCount { self.digitCodeCount = digitCodeCount }
        if let generalBorderParameter = generalBorderParameter { self.generalBorderParameter = generalBorderParameter }
        if let selectedBorderParameter = selectedBorderParameter { self.selectedBorderParameter = selectedBorderParameter }
        if let codeLabelFont = codeLabelFont { self.codeLabelFont = codeLabelFont }
        if let spacing = spacing { self.spacing = spacing }

        initCodeViews(with: self.digitCodeCount, font: self.codeLabelFont, spacing: self.spacing, borderParameter: self.generalBorderParameter)
        initInputTextField()
    }
    
    /// [重置畫面](https://zh.wikipedia.org/zh-tw/一次性密碼)
    func reset() {
        inputTextField.text = nil
        resetCodeViews()
        textFieldEditingAction(inputTextField, isDisplay: true)
    }
}

extension WWOneTimePasswordView: UITextFieldDelegate {}

// MARK: - UITextFieldDelegate
public extension WWOneTimePasswordView {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textFieldEditingAction(textField, isDisplay: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textFieldEditingAction(textField, isDisplay: false)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return textFieldAction(textField, shouldChangeCharactersIn: range, replacementString: string)
    }
}

// MARK: - 小工具
private extension WWOneTimePasswordView {
    
    /// [讀取Nib畫面 => 加到View上面](https://medium.com/@dejanvu.developer/email-verification-with-sent-codes-in-ruby-on-rails-a-step-by-step-guide-039bcf194634)
    func initViewFromXib() {
        
        let bundle = Bundle.module
        let name = String(describing: WWOneTimePasswordView.self)
        
        bundle.loadNibNamed(name, owner: self, options: nil)
        contentView.frame = bounds
        
        addSubview(contentView)
    }
    
    /// 初始化CodeView的畫面
    /// - Parameters:
    ///   - count: Int
    ///   - font: UIFont
    ///   - spacing: CGFloat
    ///   - borderParameter: BorderParameter
    func initCodeViews(with count: Int, font: UIFont, spacing: CGFloat, borderParameter: BorderParameter) {
        
        removeAllCodeViews()
        
        (0..<count).forEach { index in
            
            let codeView = CodeView()
            
            codeView.tag = index
            codeView.setting(font: font, borderParameter: borderParameter)
            codeView.contentView.backgroundColor = .white
            codeView.inputLabel.textColor = textColor
            
            codeStackView.spacing = spacing
            codeStackView.addArrangedSubview(codeView)
        }
    }
    
    /// 輸入框設定
    func initInputTextField() {
        inputTextField.delegate = self
    }
}

// MARK: - 小工具
private extension WWOneTimePasswordView {
    
    /// 移除全部的CodeView
    func removeAllCodeViews() {
        
        codeStackView.arrangedSubviews.forEach { view in
            
            if view is CodeView {
                codeStackView.removeArrangedSubview(view)
                view.removeFromSuperview()
            }
        }
    }
    
    /// 重置所有的CodeView
    func resetCodeViews() {
        inputTextField.becomeFirstResponder()
        codeStackView.arrangedSubviews.forEach { if let codeView = $0 as? CodeView { codeView.resetText(with: generalBorderParameter) }}
        delegate?.oneTimePasswordView(self, status: .reset, password: "", replacementString: nil)
    }
    
    /// 輸入框編輯輸入有開始 / 結束時的顯示處理
    /// - Parameters:
    ///   - textField: UITextField
    ///   - isDisplay: Bool
    func textFieldEditingAction(_ textField: UITextField, isDisplay: Bool) {
        
        let codeCount = textField.text?.count ?? 0
        let password = parsePassword()
        let status: Status = !isDisplay ? .dismiss : .display
        
        guard let codeView = codeStackView.arrangedSubviews[safe: codeCount] as? CodeView else { return }
        
        codeView.cursorView(isDisplay: isDisplay)
        codeViewBorderSetting(codeView, isDisplay: isDisplay)
        
        delegate?.oneTimePasswordView(self, status: status, password: password, replacementString: nil)
    }
    
    /// 正在輸入文字時的處理
    /// - Parameters:
    ///   - textField: UITextField
    ///   - range: NSRange
    ///   - string: String
    /// - Returns: Bool
    func textFieldAction(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        defer { delegateAction(with: string) }
        
        let currentText = textField.text ?? ""
        let currentCodeCount = currentText.count
        
        if string.isEmpty && range.length == 1 { keyinBackSpaceAction(with: currentCodeCount, length: range.length, string: string); return true }
        if currentCodeCount >= digitCodeCount { return false }
        
        displayStringAciton(with: currentCodeCount, string: string)
        return true
    }
    
    /// delegate的動作處理
    /// - Parameter replacementString: String
    func delegateAction(with replacementString: String) {
        
        var password = parsePassword()
        var status: Status = .finish
        
        delegate?.oneTimePasswordView(self, status: inputStatus(with: password), password: password, replacementString: replacementString)
    }
    
    /// 根據輸入框來取得Password
    /// - Returns: String
    func parsePassword() -> String {
        
        var password: String = ""
        
        codeStackView.arrangedSubviews.forEach { view in
            
            guard let codeView = view as? CodeView,
                  let code = codeView.code()
            else {
                return
            }
            
            password += code
        }
        
        return password
    }
    
    /// 根據輸入的文字來取得現在的狀態
    /// - Parameter password: String
    /// - Returns: Status
    func inputStatus(with password: String) -> Status {
        
        if password.count >= digitCodeCount { return .finish }
        if password.isEmpty { return .reset }
        
        return .keyIn
    }
    
    /// 按下刪除鍵的處理
    /// - Parameters:
    ///   - count: Int
    ///   - length: Int
    ///   - string: String
    func keyinBackSpaceAction(with count: Int, length: Int, string: String) {
        
        let previousCodeView = codeStackView.arrangedSubviews[safe: count] as? CodeView
        let currentCodeView = codeStackView.arrangedSubviews[safe: count - length] as? CodeView
        
        previousCodeView?.cursorView(isDisplay: false)
        currentCodeView?.cursorView(isDisplay: true)
        
        codeViewBorderSetting(previousCodeView, isDisplay: false)
        codeViewBorderSetting(currentCodeView, isDisplay: true)
        
        currentCodeView?.inputLabel.text = string
    }
    
    /// 文字顯示的相關處理
    /// - Parameters:
    ///   - count: Int
    ///   - string: String
    func displayStringAciton(with count: Int, string: String) {
        
        for (index, subView) in codeStackView.arrangedSubviews.enumerated() {
            
            guard let codeView = subView as? CodeView else { continue }
            
            let isDisplay = (index != count + 1) ? false : true
            
            codeView.cursorView(isDisplay: isDisplay)
            codeViewBorderSetting(codeView, isDisplay: isDisplay)
            
            if (index == count) {
                codeView.inputLabel.text = string
                codeView.cursorLineView._cursorBlinkAnimation()
            }
        }
    }
    
    /// 顯示正在輸入的外形處理
    /// - Parameters:
    ///   - codeView: CodeView
    ///   - isDisplay: Bool
    func codeViewBorderSetting(_ codeView: CodeView?, isDisplay: Bool) {
        
        guard let codeView = codeView else { return }
        
        let borderParameter = !isDisplay ? generalBorderParameter : selectedBorderParameter
        codeView.setting(borderParameter: borderParameter)
    }
}
