//
//  PulseButton.swift
//  ProtoKit
//
//  Created by Zhu Shengqi on 24/07/2017.
//
//

import UIKit

/// Call sizeToFit() and startPulsing() after initialization completed
open class PulseButton : UIButton {
  open var pulses = true
  private var isPulsing = false
  
  override open var isHighlighted: Bool {
    didSet {
      if isHighlighted {
        stopPulsing()
        animate(toScale: 1.4)
      }
      else {
        startPulsing()
        animateToDefaultScale()
      }
    }
  }
  
  private func animateToDefaultScale() {
    guard !isHighlighted && !pulses else { return }
    animate(toScale: 1.0)
  }
  
  private func animate(toScale targetScale: CGFloat) {
    UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [.allowUserInteraction, .beginFromCurrentState], animations: {
      self.transform = CGAffineTransform(scaleX: targetScale, y: targetScale)
    })
  }
  
  public func startPulsing() {
    guard pulses && !isPulsing else { return }
    
    isPulsing = true
    
    let minScale = CGFloat(0.95)
    let maxScale = CGFloat(1.05)
    
    UIView.animate(withDuration: 0.25, delay: 0, options: [.allowUserInteraction], animations: {
      self.transform = CGAffineTransform(scaleX: minScale, y: minScale)
    }, completion: { _ in
      UIView.animate(withDuration: 0.5, delay: 0, options: [.allowUserInteraction, .repeat, .autoreverse], animations: {
        self.transform = CGAffineTransform(scaleX: maxScale, y: maxScale)
      })
    })
  }
  
  public func stopPulsing() {
    guard pulses else { return }
    
    isPulsing = false
    layer.removeAllAnimations()
  }
}
