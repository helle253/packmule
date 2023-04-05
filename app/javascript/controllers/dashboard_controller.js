import { Controller } from "@hotwired/stimulus"

import * as THREE from 'three';

import { GLTFLoader } from 'three/addons/loaders/GLTFLoader.js';

import { CanvasCapture } from 'canvas-capture';

// Connects to data-controller="shipment"
export default class extends Controller {

  connect() {
    this.container = document.createElement( 'div' );
    document.body.appendChild( this.container );

    
    this.camera = new THREE.PerspectiveCamera( 45, 1, 0.25, 20 );
    this.camera.position.set( 0, 1.5, 3 );
    this.camera.lookAt(0, 0, 0)

    this.scene = new THREE.Scene();
    this.scene.add(new THREE.AmbientLight(0x404040))

    this.renderer = new THREE.WebGLRenderer();
    this.container.appendChild( this.renderer.domElement );
    this.renderer.setSize( 500, 500 );
    this.renderer.outputEncoding = THREE.sRGBEncoding;
    this.renderer.setAnimationLoop(() => { this.loop(this) });

    this.lastFrameTime = Date.now();
    this.fps = 60;
  }

  loop(self) {
    const rotations = 1;  // Number of rotations
    const gif_length = 12; // Seconds
    const rps = (rotations / gif_length);

    const delta = Date.now() - self.lastFrameTime;
    self.lastFrameTime = Date.now();

    if (!self.mesh) return;
    const frames = gif_length * this.fps;
    const doneRecording = this.frameCtr > frames

    if (!doneRecording) {
      this.frameCtr+=1;
      const rotation = (this.frameCtr / frames) * rotations * Math.PI * 2;
      self.mesh.rotation.y = rotation
    } else {
      if (CanvasCapture.isRecording()) CanvasCapture.stopRecord();
      self.mesh.rotation.y += rps * (delta / 1000) * (Math.PI * 2);
    }

    self.renderer.render( self.scene, self.camera );
    if (CanvasCapture.isRecording()) CanvasCapture.recordFrame();
  }

  record() {
    this.frameCtr = 1
    const loader = new GLTFLoader();
    return loader.loadAsync(
      // resource URL
      'https://res.cloudinary.com/dppe4mwtb/image/upload/v1679582450/birds-nest-tartlette_zjedcf.glb',
    ).then((gltf) => {
      this.mesh = gltf.scene.children[0]
      this.camera.lookAt(this.mesh.position)
      this.scene.add( gltf.scene );
    
      CanvasCapture.init(this.renderer.domElement);
      CanvasCapture.beginVideoRecord({
        name: "out-"+Date.now(),
        format: CanvasCapture.WEBM,
        fps: this.fps,
      });
    });
  }
}
