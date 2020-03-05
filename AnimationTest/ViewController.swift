//
//  ViewController.swift
//  AnimationTest
//
//  Created by Matias Ladelfa on 01/03/2020.
//  Copyright © 2020 Matias La Delfa. All rights reserved.
//

import UIKit

/// Programatically Animated
/// Reference link: https://stackoverflow.com/questions/40320727/fill-uiimageview-with-other-color-animated/40324557
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let width: CGFloat = 100
        let height: CGFloat = 100
        let x = self.view.frame.width
        let y = self.view.frame.height
        let duration: TimeInterval = 1.75
        let frame = CGRect(x: (x / 2) - (CGFloat(width) / 2),
                           y: (y / 2) - (CGFloat(height) / 2),
                           width: width,
                           height: height)
        
        let fill = FillView(frame: frame)
        
        self.view.addSubview(fill)
        Timer.scheduledTimer(withTimeInterval: duration, repeats: true) { timer in
            
            fill.animate(duration: duration)
        }
    }
}

class FillView: UIView {

    let liquidView = UIView() // Is going to be animated from bottom to top
    let shapeView = UIImageView() // Is going to mask everything with alpha mask

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    func setup() {
        self.backgroundColor = UIColor.white
        self.liquidView.backgroundColor = UIColor.cyan

        self.shapeView.contentMode = .scaleAspectFit
        self.shapeView.image = UIImage(systemName: "cube.fill")

        self.addSubview(liquidView)
        self.mask = shapeView

        layoutIfNeeded()
        reset()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        liquidView.frame = self.bounds
        shapeView.frame = self.bounds
    }

    func reset() {
        liquidView.frame.origin.y = bounds.height
    }

    func animate(duration: TimeInterval) {
        reset()
        UIView.animate(withDuration: duration) {
            self.liquidView.frame.origin.y = 0
        }
    }
}
