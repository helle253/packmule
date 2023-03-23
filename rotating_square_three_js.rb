# This example is adapted from three.js README document.

require 'js_wrap/three'

def init_camera
  Three::PerspectiveCamera.new(
    70,
    JSGlobal.inner_width / JSGlobal.inner_height,
    0.01,
    10,
  ).tap do |c|
    c.position.z = 1
    c.position.y = 0.5
    c.rotation.x = -0.5
  end
end

def animate(time, renderer, mesh, scene, camera)
  mesh.rotation.y = time / 2000

  renderer.render(scene, camera)
end

def init
  camera = init_camera
  scene = Three::Scene.new
  geometry = Three::BoxGeometry.new(0.2, 0.2, 0.2)
  material = Three::MeshNormalMaterial.new

  mesh = Three::Mesh.new(geometry, material)
  scene << mesh
  [mesh, scene, camera]
end

def run
  mesh, scene, camera = init
  renderer = Three::WebGLRenderer.new(antialias: true).tap do |r|
    r.set_size(JSGlobal.inner_width, JSGlobal.inner_height)
    r.set_animation_loop { |time| animate(time, r, mesh, scene, camera) }
  end

  JSGlobal.add_event_listener('DOMContentLoaded') do
    JSGlobal.document.body.append_child(renderer.dom_element)
  end
end

run
