//
//  TileButton.swift
//  Tic Tac Toe
//
//  Created by Alexander Peter Maliyakkal on 05/09/24.
//
import UIKit

class TileButton: UIButton {
  private let animationDuration: TimeInterval = 0.2
  private var symbol: String = ""

  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
    configure()
  }

  private func configure() {
    // Translucent white background
    backgroundColor = UIColor.white.withAlphaComponent(0.5)

    // Rounded corners
    layer.cornerRadius = 15 // Adjust for desired roundness

    // Border and shadow for definition
    layer.borderWidth = 1
    layer.borderColor = UIColor.systemGray4.cgColor
    layer.shadowColor = UIColor.black.cgColor
    layer.shadowOffset = CGSize(width: 0, height: 5)
    layer.shadowRadius = 10
    layer.shadowOpacity = 0.3

    // Title with black color for better contrast on white background
    setTitleColor(.black, for: .normal)
    titleLabel?.font = UIFont.systemFont(ofSize: 60)
  }

  // Add subtle animation on touch with color change
  override var isHighlighted: Bool {
    didSet {
      animatePress(isPressed: isHighlighted)
    }
  }

  private func animatePress(isPressed: Bool) {
    let scale: CGFloat = isPressed ? 0.98 : 1.0
    let newColor: UIColor = isHighlighted ? (symbol == "X" ? .red.withAlphaComponent(0.8) : .green.withAlphaComponent(0.8)) : UIColor.white.withAlphaComponent(0.8)

    UIView.animate(withDuration: animationDuration, animations: {
      self.transform = CGAffineTransform(scaleX: scale, y: scale)
      self.layer.shadowOffset = isPressed ? CGSize(width: 0, height: 3) : CGSize(width: 0, height: 5)
      self.layer.shadowRadius = isPressed ? 8 : 10
      self.backgroundColor = newColor
    })
  }

  // Cross-dissolve animation when setting the symbol
  func animateToSymbol(symbol: String) {
    self.symbol = symbol
    UIView.transition(with: self, duration: animationDuration, options: .transitionCrossDissolve, animations: {
      self.setTitle(symbol, for: .normal)
    }, completion: nil)
  }
}
