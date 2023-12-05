import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="fabric-list"
export default class extends Controller {
  static targets = ["fabric", "list", "counter", "deletedItems"];

  connect() {
    console.log("Hello from fabric list controller");
  }

  add() {
    const counter = this.fabricTargets.length + 1;
    console.log(counter);
    const input = `<div class="fabric-container" data-fabric-list-target="fabric">
                    <div class="fabric mb-3">
                    <label for="fabric_type_${counter}" class="form-label">Fabric type</label>
                    <input type="text" class="form-control" name="fabric_type_${counter}" id="fabric_type_${counter}">
                  </div>
                  <div class="fabric">
                    <label for="fabric_composition_${counter}" class="form-label">Percentage (%)</label>
                    <input type="text" name="fabric_composition_${counter}" class="form-control" id="fabric_composition_${counter}">
                  </div>
                  <button type="button" data-id=${counter} data-action="click->fabric-list#removeFabric" style="background: none; border: none; color: black; cursor: pointer;">X</button>
                  </div>`;
    this.listTarget.insertAdjacentHTML("beforeend", input);
    this.counterTarget.value = counter;
  }

  removeFabric(event) {
    this.deletedItemsTarget.value += event.currentTarget.dataset.type + ",";
    event.currentTarget.parentElement.remove();
  }
}
