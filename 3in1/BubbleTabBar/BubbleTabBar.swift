//
//  BubbleTabBar.swift
//  BubbleTabBar
//
//  Created by Anton Skopin on 28/11/2018.
//  Copyright © 2018 cuberto. All rights reserved.
//

import UIKit
import ChameleonFramework

open class BubbleTabBar: UITabBar {
    
    private var buttons: [CBTabBarButton] = []
    public var animationDuration: Double = 0.3
    
    open override var selectedItem: UITabBarItem? {
        willSet {
            guard let newValue = newValue else {
                buttons.forEach { $0.setSelected(false) }
                return
            }
            guard let index = items?.firstIndex(of: newValue),
                index != NSNotFound else {
                    return
            }
            select(itemAt: index, animated: false)
        }
    }
        
    open override var tintColor: UIColor! {
        didSet {
            buttons.forEach { button in
                if (button.item as? CBTabBarItem)?.tintColor == nil {
                    button.tintColor = #colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1)
                }
            }
        }
    }
    
    override open var backgroundColor: UIColor? {
        didSet {
            barTintColor = backgroundColor
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    var container: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    private var csContainerBottom: NSLayoutConstraint!
    
    private func configure() {
        backgroundColor = UIColor.white
        isTranslucent = false
        barTintColor = UIColor.white
        tintColor = [#colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1), #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1), #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1), #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1), #colorLiteral(red: 0.1294117719, green: 0.2156862766, blue: 0.06666667014, alpha: 1)].randomElement()

        addSubview(container)
        container.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        container.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        container.topAnchor.constraint(equalTo: topAnchor, constant: 1).isActive = true
        let bottomOffset: CGFloat
        if #available(iOS 11.0, *) {
            bottomOffset = safeAreaInsets.bottom
        } else {
            bottomOffset = 0
        }
        csContainerBottom = container.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -bottomOffset)
        csContainerBottom.isActive = true
    }
    
    override open func safeAreaInsetsDidChange() {
        if #available(iOS 11.0, *) {
            super.safeAreaInsetsDidChange()
            csContainerBottom.constant = -safeAreaInsets.bottom
        } else { }
    }
    
    open override var items: [UITabBarItem]? {
        didSet {
            reloadViews()
        }
    }
    
    open override func setItems(_ items: [UITabBarItem]?, animated: Bool) {
        super.setItems(items, animated: animated)
        reloadViews()
    }
    
    private var spaceLayoutGuides:[UILayoutGuide] = []
    
    private func reloadViews() {
        subviews.filter { String(describing: type(of: $0)) == "UITabBarButton" }.forEach { $0.removeFromSuperview() }
        buttons.forEach { $0.removeFromSuperview() }
        spaceLayoutGuides.forEach { self.container.removeLayoutGuide($0) }
        buttons = items?.map { self.button(forItem: $0) } ?? []
        buttons.forEach { (button) in
            self.container.addSubview(button)
            button.topAnchor.constraint(equalTo: self.container.topAnchor).isActive = true
            button.bottomAnchor.constraint(equalTo: self.container.bottomAnchor).isActive = true
        }
        if #available(iOS 11.0, *) {
            buttons.first?.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 50.0).isActive = true
            buttons.last?.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -50.0).isActive = true
        } else {
            buttons.first?.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10.0).isActive = true
            buttons.last?.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10.0).isActive = true
        }
        let viewCount = buttons.count - 1
        spaceLayoutGuides = [];
        for i in 0..<viewCount {
            let layoutGuide = UILayoutGuide()
            container.addLayoutGuide(layoutGuide)
            spaceLayoutGuides.append(layoutGuide)
            let prevBtn = buttons[i]
            let nextBtn = buttons[i + 1]
            layoutGuide.leadingAnchor.constraint(equalTo: prevBtn.trailingAnchor).isActive = true
            layoutGuide.trailingAnchor.constraint(equalTo: nextBtn.leadingAnchor).isActive = true
        }
        for layoutGuide in spaceLayoutGuides[1...] {
            layoutGuide.widthAnchor.constraint(equalTo: spaceLayoutGuides[0].widthAnchor, multiplier: 1.0).isActive = true;
        }
        layoutIfNeeded()
    }
    
    private func button(forItem item: UITabBarItem) -> CBTabBarButton {
        let button = CBTabBarButton(item: item)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setContentHuggingPriority(.required, for: .horizontal)
        if (button.item as? CBTabBarItem)?.tintColor == nil {
            
            button.tintColor = .black

        }
        button.addTarget(self, action: #selector(btnPressed), for: .touchUpInside)
        if selectedItem != nil && item === selectedItem {
            button.setSelected(true)
        }
        return button
    }
    
    @objc private func btnPressed(sender: CBTabBarButton) {
        sender.tintColor = [FlatBlue(),FlatPurpleDark(),FlatSand()][buttons.firstIndex(of: sender)!]
        guard let index = buttons.firstIndex(of: sender),
            index != NSNotFound,
              
            let item = items?[index]
        else {
                return
        }
        buttons.forEach { (button) in
            guard button != sender else {
                return
            }
            button.setSelected(false, animationDuration: animationDuration)
        }
        sender.setSelected(true, animationDuration: animationDuration)
        UIView.animate(withDuration: animationDuration) {
            self.container.layoutIfNeeded()
        }
        delegate?.tabBar?(self, didSelect: item)
    }
    
    func select(itemAt index: Int, animated: Bool = false) {
        guard index < buttons.count else {
            return
        }
        let selectedbutton = buttons[index]
        buttons.forEach { (button) in
            guard button != selectedbutton else {
                return
            }
            button.setSelected(false, animationDuration: animated ? animationDuration : 0)
        }
        selectedbutton.setSelected(true, animationDuration: animated ? animationDuration : 0)
        if animated {
            UIView.animate(withDuration: animationDuration) {
                self.container.layoutIfNeeded()
            }
        } else {
            self.container.layoutIfNeeded()
        }
    }
    
}
