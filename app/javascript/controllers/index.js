// Import and register all your controllers from the importmap under controllers/*

import { application } from "controllers/application"

// Eager load all controllers defined in the import map under controllers/**/*_controller
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
eagerLoadControllersFrom("controllers", application)

// Lazy load controllers as they appear in the DOM (remember not to preload controllers in import map!)
// import { lazyLoadControllersFrom } from "@hotwired/stimulus-loading"
// lazyLoadControllersFrom("controllers", application)
// let kebab = document.querySelector('.kebab'),
//     middle = document.querySelector('.middle'),
//     cross = document.querySelector('.cross'),
//     dropdown = document.querySelector('.dropdown');

// kebab.addEventListener('click', function() {
//   middle.classList.toggle('active');
//   cross.classList.toggle('active');
//   dropdown.classList.toggle('active');
// })
