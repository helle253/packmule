import { Controller } from "@hotwired/stimulus"

import * as THREE from 'three';
import { cubeTexture, texture, normalMap, toneMapping } from 'three/nodes';

import { GLTFLoader } from 'three/addons/loaders/GLTFLoader.js';

// Connects to data-controller="shipment"
export default class extends Controller {
  submit() {
    let camera, scene, renderer, mesh;
    
    init();
    render();
    
    function init() {
      const container = document.createElement( 'div' );
      document.body.appendChild( container );
    
      camera = new THREE.PerspectiveCamera( 45, 1, 0.25, 20 );
      camera.position.set( 0, 1.5, 3 );
      camera.lookAt(0, 0, 0)
    
      scene = new THREE.Scene();
      const loader = new GLTFLoader();

      loader.load(
        // resource URL
        'https://res.cloudinary.com/dppe4mwtb/image/upload/v1679582450/birds-nest-tartlette_zjedcf.glb',
        // called when the resource is loaded
        function ( gltf ) {
          mesh = gltf.scene.children[0]
          camera.lookAt(mesh.position)
          scene.add( gltf.scene );
      });

      scene.add(new THREE.AmbientLight(0x404040))
    
      renderer = new THREE.WebGLRenderer( { antialias: false } );
      renderer.outputEncoding = THREE.sRGBEncoding;
    
      renderer.setPixelRatio( window.devicePixelRatio );
      renderer.setSize( 500, 500 );

      renderer.setAnimationLoop( render );
      renderer.toneMappingNode = toneMapping( THREE.LinearToneMapping, 1 );
      renderer.outputEncoding = THREE.sRGBEncoding;
      container.appendChild( renderer.domElement );
    }
    
    function render() {
      if (mesh?.rotation) {
        mesh.rotation.y = Date.now() / 1000;
      }
      renderer.render( scene, camera );
    }
  }
}
