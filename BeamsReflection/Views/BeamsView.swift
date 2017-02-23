//
//  BeamsView.swift
//  BeamsReflection
//
//  Created by jufina on 23.02.17.
//  Copyright © 2017 jufina. All rights reserved.
//

import Foundation
import UIKit

final class BeamsView: UIView {
    
    var touches = Array<UITouch>()
    var beams = [CAShapeLayer]()
    var colors = [UITouch: UIColor]()
    
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.isMultipleTouchEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - TouchesHandler
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        touches.forEach { (touch) in
            self.touches.append(touch)
            colors[touch] = UIColor.randomColor()
        }
        showBeamsLayers()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        touches.forEach { (touch) in
            let index = self.touches.index(of: touch)
            self.touches[index!] = touch
        }
        showBeamsLayers()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        touches.forEach { (touch) in
            self.touches.remove(at: self.touches.index(of: touch)!)
        }
        showBeamsLayers()
    }
}


private protocol BeamLayerChanges: class {
    func showBeamsLayers()
    func removeOldBeams()
    func addBeams()
}


//MARK: - BeamLayerChanges

extension BeamsView: BeamLayerChanges {
    func showBeamsLayers() {
        removeOldBeams()
        addBeams()
    }
    
    func removeOldBeams() {
        beams.forEach { (layer) in
            layer.removeFromSuperlayer()
        }
        beams.removeAll()
    }
    
    func addBeams() {
        touches.forEach { (touch) in
            let beamColor = colors[touch]!
            let beam = Beam(borders: self.frame)
            let beamShapeLayer = BeamShapeLayer(color: beamColor, beam: beam, point: touch.location(in: self), center: self.center)
            beams.append(beamShapeLayer)
            layer.addSublayer(beamShapeLayer)
        }
    }
}

