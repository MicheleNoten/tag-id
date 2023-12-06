import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="fabric-list"
export default class extends Controller {
  static targets = ["fabric", "list", "counter", "deletedItems"];
  static values = { imageUrl: String };

  connect() {
    console.log("Hello from fabric list controller");
  }

  add() {
    const counter = this.fabricTargets.length + 1;
    console.log(counter);
    const input =
                  `<div class="fabric-container" data-fabric-list-target="fabric">
                    <div class="fabric-labels">
                      <label for="fabric_type_${counter}" class="form-label">Fabric type</label>
                      <label for="fabric_composition_${counter}" class="form-label ms-2">Percentage (%)</label>
                    </div>
                    <div class="fabric-inputs">
                      <input type="text" class="form-control" name="fabric_type_${counter}" id="fabric_type_${counter}">
                      <input type="text" name="fabric_composition_${counter}" class="form-control ms-2" id="fabric_composition_${counter}">
                      <button type="button" data-id=${counter} data-action="click->fabric-list#removeFabric" class="form-button"> <img src="${this.imageUrlValue}" alt="text"></button>
                    </div>
                  </div>`;

    this.listTarget.insertAdjacentHTML("beforeend", input);
    this.counterTarget.value = counter;
  }

  removeFabric(event) {
    this.deletedItemsTarget.value += event.currentTarget.dataset.type + ",";
    event.currentTarget.parentElement.parentElement.remove();
  }
}
