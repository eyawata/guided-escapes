// import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="map-experience"
// export default class extends Controller {
//   connect() {
//   }
// }

import { Controller } from "@hotwired/stimulus"
import mapboxgl from 'mapbox-gl';

export default class extends Controller {
  static targets = []

  connect() {
    console.log ("connected")
    mapboxgl.accessToken = 'pk.eyJ1IjoiZGVzZXJ0Zm94MTE3IiwiYSI6ImNseXpncXJ1cjIxNmcyanNobTk4ZW56bWwifQ.AOS84lXV36dmxBAzW2dMLw';
    this.map = new mapboxgl.Map({
      container: this.element,
      style: 'mapbox://styles/mapbox/streets-v12',
      center: [139.70822, 35.63392],
      zoom: 13
    });
  }
}





// // import { Controller } from "stimulus"
// import mapboxgl from 'mapbox-gl';

// export default class extends Controller {
//   static targets = ["map"]

//   connect() {
//     mapboxgl.accessToken = 'pk.eyJ1IjoiZGVzZXJ0Zm94MTE3IiwiYSI6ImNseXpncXJ1cjIxNmcyanNobTk4ZW56bWwifQ.AOS84lXV36dmxBAzW2dMLw';
//     this.map = new mapboxgl.Map({
//       container: this.mapTarget.id,
//       style: 'mapbox://styles/mapbox/streets-v12',
//       center: [139.70822, 35.63392],
//       zoom: 13
//     });
//   }
// }


// // Code I got from Yann //
// mapboxgl.accessToken = 'pk.eyJ1IjoieWFubmx1Y2tsZWluIiwiYSI6ImNqcnZmeHQwaDAxb2o0NGx2bG1tOWgwNGIifQ.q4zhKOCoH7nDIJNm88leXg';
// const map = new mapboxgl.Map({
//   container: 'map',
//   // Choose from Mapbox's core styles, or make your own style with Mapbox Studio
//   style: 'mapbox://styles/mapbox/streets-v12',
//   center: [139.70822, 35.63392],
//   zoom: 13
// });

// let direction;

// const renderDirection = (showInstructions = false) => {
//   // Part for the destination
//   if (direction) {
//     map.removeControl(direction)
//   }
//   direction = new MapboxDirections({
//       accessToken: mapboxgl.accessToken,
//       routePadding: 50,
//       controls: {
//         inputs: false,
//         instructions: showInstructions
//       }
//     })
//   map.addControl(
//     direction,
//     'top-left'
//   );
//   if (navigator.geolocation) {
//     navigator.geolocation.getCurrentPosition((position) => {

//       direction.setOrigin([position.coords.longitude, position.coords.latitude])
//       direction.addWaypoint(0, [position.coords.longitude, position.coords.latitude])

//       direction.addWaypoint(1, [139.6987107, 35.6645956]);

//       direction.addWaypoint(2, [139.74553595504963, 35.6584491]);
//       direction.setDestination([139.74553595504963, 35.6584491])

//       direction.on("route", () => {
//         const coords = direction.getWaypoints().map(points => points.geometry.coordinates);
//         console.log(coords);
//         console.log(coords.length);
//         const exampleGeojson = JSON.stringify({
//           type: "FeatureCollection",
//           name: "From Kanto to Kansai | 5 days, 400km",
//           instaLinks: ["https://www.instagram.com/stories/highlights/18304478332010006/"],
//           crs: { "type": "name", "properties": { "name": "urn:ogc:def:crs:OGC:1.3:CRS84" } },
//           features: [
//             {
//               type: "Feature",
//               properties: { "Name": "From Kanto to Kansai | 5 days, 400km" },
//               geometry: { "type": "LineString", "coordinates": coords }
//             }
//           ]
//         });
//         console.log(exampleGeojson);
//       });
//     });
//    }
//  }

// renderDirection()

// document.addEventListener("keyup", (event) => {
//   // Update MapboxDirections control with instructions set to true
//   if (event.key == "i") {
//     console.log("pressed i")
//     renderDirection(true)
//   }
// });
// // End of Code I got from Yann //
