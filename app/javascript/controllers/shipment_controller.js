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
    const gif_length = 2                  // Seconds
    const fps = 30

    let rotation = 0

    init().then(() => {
      render();
      _record();
    });

    function _record() {
      CanvasCapture.init(renderer.domElement, { showRecDot: true });
      CanvasCapture.beginGIFRecord({
        name: "out-"+Date.now(),
        fps: fps,
      });
      const frames = gif_length * fps;
      let frame = frames;
      while (frame--) {
        rotation = rotations * (frame / frames) * (Math.PI * 2)
        requestAnimationFrame(render);
        CanvasCapture.recordFrame();
      }
      rotation = null;
      CanvasCapture.stopRecord();
    };
    
    async function init() {
      const container = document.createElement( 'div' );
      document.body.appendChild( container );
    
      camera = new THREE.PerspectiveCamera( 45, 1, 0.25, 20 );
      camera.position.set( 0, 1.5, 3 );
      camera.lookAt(0, 0, 0)
    
      scene = new THREE.Scene();
      scene.add(new THREE.AmbientLight(0x404040))
    
      renderer = new THREE.WebGLRenderer( { antialias: false } );
      renderer.outputEncoding = THREE.sRGBEncoding;
    
      renderer.setPixelRatio( window.devicePixelRatio );
      renderer.setSize( 500, 500 );

      renderer.setAnimationLoop( render );
      renderer.toneMappingNode = toneMapping( THREE.LinearToneMapping, 1 );
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

    function render() {
      if (mesh?.rotation) mesh.rotation.y = Date.now() / 1000;
      renderer.render( scene, camera );
    }
  }
}
