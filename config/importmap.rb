# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin_all_from "app/javascript/controllers", under: "controllers"
pin "three", to: "https://ga.jspm.io/npm:three@0.150.1/build/three.module.js"
pin "three/nodes", to: "https://ga.jspm.io/npm:three@0.150.1/examples/jsm/nodes/Nodes.js"
pin "three/addons/loaders/GLTFLoader.js", to: "https://ga.jspm.io/npm:three@0.150.1/examples/jsm/loaders/GLTFLoader.js"
pin "canvas-capture", to: "https://ga.jspm.io/npm:canvas-capture@2.0.6/dist/canvas-capture.js"
pin "buffer", to: "https://ga.jspm.io/npm:@jspm/core@2.0.1/nodelibs/browser/buffer.js"
pin "process", to: "https://ga.jspm.io/npm:@jspm/core@2.0.1/nodelibs/browser/process-production.js"
