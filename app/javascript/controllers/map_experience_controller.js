import { Controller } from "@hotwired/stimulus"
import mapboxgl from 'mapbox-gl';

export default class extends Controller {
  static targets = ["locationInput", "map"]

  connect() {
    console.log ("connected")
    mapboxgl.accessToken = 'pk.eyJ1IjoiZGVzZXJ0Zm94MTE3IiwiYSI6ImNseXpncXJ1cjIxNmcyanNobTk4ZW56bWwifQ.AOS84lXV36dmxBAzW2dMLw';
    this.map = new mapboxgl.Map({
      container: this.mapTarget,
      style: 'mapbox://styles/mapbox/streets-v12',
      center: [139.70822, 35.63392],
      zoom: 13
    });
    this.currentMarker = null;
    this.map.on("click", (event) => {
      // alert(`Coords: ${event.lngLat}`);
      let markerLng = event.lngLat.lng;
      let markerLat = event.lngLat.lat;
      this.#addMarkersToMap(markerLng, markerLat);

      const url = `https://api.mapbox.com/search/geocode/v6/reverse?longitude=${event.lngLat.lng}&latitude=${event.lngLat.lat}&access_token=${mapboxgl.accessToken}`;
      fetch(url)
      .then(r => r.json())
      .then((data) => {
        // alert(`Address: ${data.features[0].properties.full_address}`)
        const address = data.features[0].properties.full_address;
        // document.getElementById("location-input").value = address
        this.locationInputTarget.value = address;
        console.log(this.locationInputTarget)
      })
    });
  }
   #addMarkersToMap(markerLng, markerLat) {
    // Remove the existing marker if it exists
    if (this.currentMarker) {
      this.currentMarker.remove();
    }

    // Create a new marker and add it to the map
    this.currentMarker = new mapboxgl.Marker()
      .setLngLat([markerLng, markerLat])  // Coordinates as an array
      .addTo(this.map);
  }
  // searchLocation(event) {
  //   const location = event.target.value;
  //   console.log("search connected")

  //   if (location.length > 3) {  // Start searching only after a few characters are typed
  //     const url = `https://api.mapbox.com/geocoding/v5/mapbox.places/${encodeURIComponent(location)}.json?access_token=${mapboxgl.accessToken}`;

  //     fetch(url)
  //       .then(response => response.json())
  //       .then((data) => {
  //         if (data.features.length > 0) {
  //           const coordinates = data.features[0].geometry.coordinates;
  //           this.#addMarkersToMap(coordinates[0], coordinates[1]);
  //           this.map.setZoom(13);  // Optionally, adjust the zoom level
  //         } else {
  //           console.error("No results found for the location.");
  //         }
  //       })
  //       .catch(error => console.error("Error fetching the geocode data:", error));
  //   }
  // }
}
