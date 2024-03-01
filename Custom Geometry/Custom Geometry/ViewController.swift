//
//  ViewController.swift
//  Custom Geometry
//
//  Created by Elina Karapetian on 03.02.2024.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sceneView.delegate = self
        createBolt()
        sceneView.autoenablesDefaultLighting = true // добавляет тени к объекту
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    func createBolt() {
        // рисуем фигуру из линий
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0.1, y: 0.5)) // A
        path.addLine(to: CGPoint(x: 0.1, y: 0.1)) // B
        path.addLine(to: CGPoint(x: 0.3, y: 0.1)) // C
        path.addLine(to: CGPoint(x: -0.1, y: -0.5)) // D
        path.addLine(to: CGPoint(x: -0.1, y: -0.1)) // E
        path.addLine(to: CGPoint(x: -0.3, y: -0.1)) // F
        path.close()
        
        //Create a geometry
        let shape = SCNShape(path: path, extrusionDepth: 0.2)
        let color = UIColor.yellow
        shape.firstMaterial?.diffuse.contents = color
        shape.chamferRadius = 0.1 // скругляем углы
        
        //Create a node
        let boltNode = SCNNode(geometry: shape)
        
        // position the node and add to the scene
        boltNode.position.z = -1 // стоит в 1 метре от устройства
        
        sceneView.scene.rootNode.addChildNode(boltNode)
        
    }
}
