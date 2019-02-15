//
//  ViewController.swift
//  CustomSlider
//
//  Created by Manas Mishra on 14/02/19.
//  Copyright © 2019 manas. All rights reserved.
//

import UIKit

protocol SliderViewDelegate: AnyObject {
    func sliderScaleChangedTo(scale: CGFloat)
    func slidingDidEnd(scale: CGFloat)
}

class ViewController: UIViewController {
    
    @IBOutlet weak var trackFillViewTrailing: NSLayoutConstraint!
    @IBOutlet weak var trackFillView: UIView!
    @IBOutlet weak var tappableCursorview: UIView!
    var trackLength: CGFloat {
        return trackView.frame.width - cursorView.frame.width
    }
    
    weak var delegate: SliderViewDelegate?
    
    var pan: CGFloat {
        return trackView.frame.width - 70
    }
    var panStartX: CGFloat {
        return 35
    }
    var panEndX: CGFloat {
        return 35 + pan
    }
    
    var isSlidingEnabled: Bool = false

    @IBOutlet weak var cursorViewLeading: NSLayoutConstraint!
    @IBOutlet weak var trackView: UIView!
    @IBOutlet weak var cursorView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    //Used for programmatically changing slider valuew
    func changeSliderScaleValueTo(scale: CGFloat) {
        guard scale >= 0, scale <= 1 else {return}
        let leading = trackLength*scale
        cursorViewLeading.constant = leading
        trackFillViewTrailing.constant = (1-scale)
    }
    
    //Initial setUp of slider
    func setUpSlider(delegate: SliderViewDelegate, fillColor: UIColor) {
        self.trackFillView.backgroundColor = fillColor
        self.delegate = delegate
    }
    
    

}

extension ViewController {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let location = touches.first?.location(in: self.tappableCursorview) else {return}
        if location.x >= 0, location.x <= self.tappableCursorview.frame.maxX {
            isSlidingEnabled = true
        } else {
            isSlidingEnabled = false
        }
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard isSlidingEnabled else {return}
        guard let locationX = touches.first?.location(in: self.view).x else {return}
        let leading = trackLength*getScale(locationX)
        cursorViewLeading.constant = leading
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard isSlidingEnabled else {return}
        guard let locationX = touches.first?.location(in: self.view).x else {return}
        isSlidingEnabled = false
        trackFillViewTrailing.constant = (1-getScale(locationX))*trackView.frame.width
        delegate?.slidingDidEnd(scale: getScale(locationX))
    }
    private func getScale(_ locationX: CGFloat) -> CGFloat {
        var scale = (locationX - panStartX)/pan
        if scale < 0 {
            scale = 0
        } else if scale > 1 {
            scale = 1
        }
        delegate?.sliderScaleChangedTo(scale: scale)
        return scale
    }

}

