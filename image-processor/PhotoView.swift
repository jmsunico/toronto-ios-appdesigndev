//
//  PhotoView.swift
//  image-processor
//
//  Created by José-María Súnico on 20160726.
//  Copyright © 2016 José-María Súnico. All rights reserved.
//

import UIKit

class PhotoView: UIImageView {

	var lastTouchTime : NSDate? = nil
	
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
	
	override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
		super.touchesBegan(touches, withEvent: event)
		print("photoview touches began")

	}

	override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
		super.touchesMoved(touches, withEvent: event)
		if let touch = touches.first{
			let location = touch.locationInView	(self)
			print("location: ", location)
		}
	}
	
	override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
		super.touchesEnded(touches, withEvent: event)
		print("photoview touches ended")
		
		let currentTime = NSDate()
		if let previousTime = lastTouchTime{
			if currentTime.timeIntervalSinceDate(previousTime) < 0.5 {
				print("Double Tap!")
				lastTouchTime = nil
			} else {
				lastTouchTime = currentTime
			}
		
		}

	}
	
	override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
		super.touchesCancelled(touches, withEvent: event)
		print("photoview touches cancelled")

	}
}
