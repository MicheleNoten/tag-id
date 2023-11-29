import { Controller } from "@hotwired/stimulus"
import Rails from "@rails/ujs";

// Connects to data-controller="scan"
export default class extends Controller {
  static targets = ["video", "startbutton", "photo"];
  stream = null;

  connect() {
    console.log("Hello from StimulusJS");
    this.canvas = document.createElement('canvas'); // Create a canvas element
    this.initScan();
  }

  initScan() {
    let width = 400;
    let height = 0;
    let streaming = false;

    navigator.mediaDevices.getUserMedia({ video: true, audio: false })
      .then((stream) => {
        this.stream = stream;
        this.videoTarget.srcObject = stream;
        this.videoTarget.play();
      })
      .catch((err) => {
        console.log("An error occurred: " + err);
      });

    this.videoTarget.addEventListener('canplay', (ev) => {
      if (!streaming) {
        height = this.videoTarget.videoHeight / (this.videoTarget.videoWidth / width);
        this.videoTarget.setAttribute('width', width);
        this.videoTarget.setAttribute('height', height);
        streaming = true;
      }
    }, false);
  }

  takePicture() {
    let context = this.canvas.getContext('2d');
    this.canvas.width = 400;
    this.canvas.height = this.videoTarget.videoHeight / (this.videoTarget.videoWidth / 400);

    context.drawImage(this.videoTarget, 0, 0, this.canvas.width, this.canvas.height);
    // Store the last snapshot as a data URL
    this.lastSnapshot = this.canvas.toDataURL('image/png');

    // Set the source of the image element to the last snapshot
    // Make the image element visible
    this.photoTarget.src = this.lastSnapshot;
    this.photoTarget.style.display = 'block';


    this.canvas.toBlob((blob) => {
      console.log(blob);
      if (blob) {
        const formData = new FormData();
        formData.append('scan[photo]', blob, 'scan.png');
        // formData.append('scan[title]', `Picture taken on ${(new Date).toString()}`);

        this.startbuttonTarget.innerText = "✅";
        this.startbuttonTarget.dataset.action = "click->scan#restartCamera";
        this.videoTarget.pause();

        Rails.ajax({
          url: "/scans",
          type: "post",
          data: formData
        });
      } else {
        console.error('Failed to create blob');
      }
      // Stop the camera after taking a picture
      if (this.stream) {
        this.stream.getTracks().forEach(track => track.stop());
        this.videoTarget.srcObject = null; // Remove the video source
        this.videoTarget.style.display = 'none';
      }
    }, 'image/png');
  }

  restartCamera() {
    // Hide the photo target and show the video element
    this.photoTarget.style.display = 'none';
    this.videoTarget.style.display = 'block';

    // Reset the start button text and action
    this.startbuttonTarget.innerText = "📸";
    this.startbuttonTarget.dataset.action = "click->scan#takePicture";

    // Reinitialize the camera
    this.initScan();
  }
}
