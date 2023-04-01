import { Controller } from "@hotwired/stimulus"

import * as THREE from 'three';
import { toneMapping } from 'three/nodes';

import { GLTFLoader } from 'three/addons/loaders/GLTFLoader.js';

import { CanvasCapture } from 'canvas-capture';

// Connects to data-controller="shipment"
export default class extends Controller {

  record() {
    let camera, scene, renderer, mesh;
    const rotations = 1                   // Number of rotations
    const gif_length = 6                  // Seconds
    const fps = 24
    const height = 500;
    const width = height;

    init().then(() => {
      startRecording();
      requestAnimationFrame(render);
    });

    function startRecording() {
      CanvasCapture.init(renderer.domElement);
      CanvasCapture.beginGIFRecord({
        name: "out-"+Date.now(),
        fps: fps,
      });
    };
    
    async function init() {
      const container = document.createElement( 'div' );
      document.body.appendChild( container );
    
      camera = new THREE.PerspectiveCamera( 45, 1, 0.25, 20 );
      camera.position.set( 0, 1.5, 3 );
      camera.lookAt(0, 0, 0)
    
      scene = new THREE.Scene();
      scene.add(new THREE.AmbientLight(0x404040))
    
      renderer = new THREE.WebGLRenderer();
    
      renderer.setSize( height, width );

      renderer.setAnimationLoop( render );
      renderer.outputEncoding = THREE.sRGBEncoding;
      container.appendChild( renderer.domElement );

      const loader = new GLTFLoader();

      return loader.loadAsync(
        // resource URL
        'https://res.cloudinary.com/dppe4mwtb/image/upload/v1679582450/birds-nest-tartlette_zjedcf.glb',
      ).then((gltf) => {
        mesh = gltf.scene.children[0]
        camera.lookAt(mesh.position)
        scene.add( gltf.scene );
      });
    }

    let frameCtr = 1
    function render() {
      if (!mesh) return;
      const frames = gif_length * fps
      const doneRecording = frameCtr > frames

      if (!doneRecording) {
        frameCtr+=1;
        const rotation = (frameCtr / frames) * rotations * Math.PI * 2;
        mesh.rotation.y = rotation
      } else {
        if (CanvasCapture.isRecording()) CanvasCapture.stopRecord();
      }

      renderer.render( scene, camera );
      if (CanvasCapture.isRecording()) CanvasCapture.recordFrame();
    }
  }
}
