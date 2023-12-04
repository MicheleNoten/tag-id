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
    // Select the element with the class 'scan-container'
    const scanContainer = document.querySelector('.camera-wrapper');
    // Get the width and height of the scan-container
    let containerWidth = scanContainer.clientWidth;
    let containerHeight = scanContainer.clientHeight;

    // TODO: Check devise type and set constraints accordingly
    // For mobile facingMode should be "environment" and desktop "user"
    // Set the constraints for the video stream

    var userAgent = navigator.userAgent;
    let faceMode = "user";
    let videoWidth = containerWidth;
    let videoHeight = containerHeight;

    if (userAgent.match(/Android/i) || userAgent.match(/iPhone|iPad|iPod/i)) {
        // Code for mobile devices
        console.log("Mobile device detected", userAgent);
        faceMode = "environment";
        videoWidth = containerHeight;
        videoHeight = containerWidth;
    } else {
        // Code for desktop devices
        console.log("Desktop device detected", userAgent);
        videoWidth = containerHeight;
        videoHeight = containerWidth;
    }

    const constraints = {
      video: {
        facingMode: faceMode, //{ exact: "environment" },
        width: {ideal: videoWidth},
        height: {ideal: videoHeight},
        focusMode: { ideal: "continuous" }
      },
      audio: false
    }

    navigator.mediaDevices.getUserMedia(constraints)
    .then((stream) => {
      this.stream = stream;
      this.videoTarget.srcObject = stream;
    })
    .catch((err) => {
      console.log("An error occurred: " + err);
    });



    this.videoTarget.addEventListener('canplay', () => {
      console.log("Video can start, but not sure it will play through.");
      // Set the width and height of the video to match the scan-container
      this.videoTarget.setAttribute('width', containerWidth);
      this.videoTarget.setAttribute('height', containerHeight);
      this.videoTarget.play();
    });

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

        console.log("Sending form data", formData);
        // TODO: Use fetch instead of Rails.ajax
        Rails.ajax({
          url: '/scans',
          type: 'POST',
          data: formData,
          success: (response) => {
            console.log("Success", response);
          },
          error: (response) => {
            console.log("Error", response);
          }
        });
        location.replace("/scans");
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
