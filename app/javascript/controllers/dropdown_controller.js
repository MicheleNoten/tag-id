import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="dropdown"
export default class extends Controller {
  static targets = [ "middle", "cross", "dropdown" ]

  connect() {
    console.log('helloooo');
  }

  toggle() {
    this.middleTarget.classList.toggle('active');
    this.crossTarget.classList.toggle('active');
    this.dropdownTarget.classList.toggle('active');
  }
}
