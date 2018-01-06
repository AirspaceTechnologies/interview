/* custom JavaScript goes here */

(function(){
	var coordinates = []; // store coordinates to reverse geocode
	//public setter
	window.setCoordinates = function(array) {
		coordinates = array;
	};

	var addresses = []; // store addresses already reverse geocoded
	//public setter
	window.setAddresses = function(array) {
		addresses = array;
	};

	var map;
	var markers = [];
	var paths = []; // Store paths connecting each marker to the white house

	var running = false; // avoid double clicks before completion

	var whiteHouse = {};
	//public setter
	window.setWhiteHouse = function(obj) {
		whiteHouse = obj;
	};

	// store callbacks to execute upon return from async reverse geocoding
	// letting all the requests happen at once causes db locking in development mode
	var reverseGeocodingCallbacks = []; 

	// creates class name for address table row from lat and lng
	function latLngToClassName(lat, lng){
		var dataClass = `${lat.toFixed(4)}${lng.toFixed(4)}`;
		dataClass = dataClass.replace(/\./g, '_');
		return dataClass;
	}

	// finds the marker from the data class name created from latLngToClassName
	function markerForDataClass(dataClass) {
		for (i in markers) {
			var marker = markers[i];
			if(marker.get('dataClass') === dataClass) {
				return marker;
			}
		}
	}

	function addressToTableRow(address) {
		var full_address = address.full_address || "";
		var dataClass = latLngToClassName(address.lat, address.lng);
		return `<tr data-class="${dataClass}"><td>${address.lat}</td><td>${address.lng}</td><td>${full_address}</td><td>${address.miles_to_dc}</td><tr>`;
	}

	// Convert all addresses to table rows
	function fillTable() {
		$('#addresses > tbody').html(addresses.sort(function(a, b){ return a.miles_to_dc - b.miles_to_dc; }).map(addressToTableRow).join('\n'));
		// Add hover functionality
		$('#addresses > tbody > tr').mouseover(function() {
			var dataClass = $(this).attr('data-class');
			var marker = markerForDataClass(dataClass);
			if(marker) selectMarker(marker);
		});
		$('#addresses > tbody > tr').mouseout(function() {
			var dataClass = $(this).attr('data-class');
			var marker = markerForDataClass(dataClass);
			if(marker) deselectMarker(marker);
		});
	}

	window.fillAddressTable = fillTable; // Public accessor to fill the table
	

	function clearTable() {
		$('#addresses > tbody').html('');
	}

	function refreshTable() {
		clearTable();
		fillTable();
	}


	function reverseGeocodeCoordinate(coordinate) {
		$.ajax('/reverse_geocode', {
			method: 'POST',
			data: {lat: coordinate[0], lng: coordinate[1]}, 
			dataType: 'json',
			success: function(data){ 
				addAddressToMap(data);
				addresses.push(data);
				refreshTable();
				var callback = reverseGeocodingCallbacks.shift();
				if(typeof callback === 'function') callback();
				else running = false; // Enable clicking
			},
			error: function(data){ console.log(data); }
		});
	}

	// clears all addresses form the table, local cache, and db
	function clearAll(callback) {
		clearTable();
		clearMap();
		$.ajax('/clear_all', {
			method: 'DELETE',
			success: function(data){ 
				addresses = [];
				if(typeof callback === 'function') callback();
			},
			error: function(data){ console.log(data); }
		});
	}

	// clears addresses then reloads them via reverse geocoding
	function run() {
		clearAll(function(){
			reverseGeocodingCallbacks = coordinates.map(function(coordinate){ 
				return function(){ reverseGeocodeCoordinate(coordinate) }; 
			});
			reverseGeocodingCallbacks.shift()();
		});

	}

	// set the given selector to execute run
	window.setRunButtonClick = function(selector) {
		$(selector).click(function(){
			if(!running) {
				// Disable clicking
				running = true;
				run();
			}
		});
	};

	// Google maps

	// maps callback
	window.initMap = function(){
		map = new google.maps.Map(document.getElementById('map'), {
			zoom: 3, minZoom: 2,
			center: {lat: 47, lng: -100}
		});

		var whiteHouseIcon = {
    	path: google.maps.SymbolPath.CIRCLE,
	    fillColor: '#000',
	    fillOpacity: 1,
	    scale: 2,
	    strokeColor: 'green',
	    strokeWeight: 14
    };

		new google.maps.Marker({
        position: whiteHouse,
        map: map,
        icon: whiteHouseIcon
    });

		for (i in addresses) {
			addAddressToMap(addresses[i]);
		}
	};

	function clearMap() {
		var clearAndSetMapToNull = function(array) {
			var obj = array.pop();
			while(obj){
				obj.setMap(null);
				obj = array.pop();
			}
		};
		clearAndSetMapToNull(paths);
		clearAndSetMapToNull(markers);
	}

	function selectMarker(marker){
		var icon = marker.icon;
  	icon.scale = 5;
  	marker.setIcon(icon);
		$('[data-class="'+marker.get('dataClass')+'"]').toggleClass('active');
	}

	function deselectMarker(marker){
		var icon = marker.icon;
  	icon.scale = 3;
  	marker.setIcon(icon);
		$('[data-class="'+marker.get('dataClass')+'"]').toggleClass('active');
	}

	function addAddressToMap(address){
		if (map) {
			var icon = {
      	path: google.maps.SymbolPath.BACKWARD_CLOSED_ARROW,
		    fillColor: '#1f3aff',
		    fillOpacity: 0.8,
		    scale: 3,
		    strokeColor: '#000',
		    strokeWeight: 1
      };
      var marker = new google.maps.Marker({
        position: address,
        map: map,
        icon: icon
      });
      // Add hover functionality
      marker.addListener('mouseover', function(){
      	selectMarker(this);
      });
      marker.addListener('mouseout', function(){
      	deselectMarker(this);
      });
      marker.set('dataClass', latLngToClassName(address.lat, address.lng));
			markers.push(marker);
      paths.push(new google.maps.Polyline({
        path: [whiteHouse, address],
        geodesic: true,
        strokeColor: '#46b4ff',
        strokeOpacity: 0.8,
        strokeWeight: 2,
        map: map
      }));
		}
	}
	
})();