var map = L.map('map').setView([51.3442, 12.3804], 13);

L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
    attribution: '© OpenStreetMap contributors'
}).addTo(map);

// add a marker on to the map
var marker = L.marker([51.3442, 12.3804], {draggable: 'true'}).addTo(map);
var circle = L.circle([51.3442, 12.3804], {radius: 500}).addTo(map);

marker.on('drag', function(e) {
    var newLocationPoint = e.target.getLatLng();
    circle.setLatLng(newLocationPoint);
});

marker.on('dragend', function(e) {
    var newLocationPoint = e.target.getLatLng();
    document.getElementById('location_point').value = newLocationPoint.lat + ',' + newLocationPoint.lng;
});

var distInput = document.getElementById('dist');
distInput.onchange = function(e) {
    circle.setRadius(e.target.value);
};

var networkForm = document.getElementById('networkForm');
var slider = document.getElementById("dist");
var output = document.getElementById("distValue");
output.innerHTML = slider.value;

slider.oninput = function() {
output.innerHTML = this.value;
}

networkForm.onsubmit = function(e) {
    e.preventDefault();

    // Show the spinner
    document.getElementById('spinner').style.display = 'block';
    document.getElementById('spinner-message').textContent = "Loading network from point...";

    var xhr = new XMLHttpRequest();
    xhr.open("POST", 'http://localhost:5000/get_network', true);
    xhr.onreadystatechange = function () {
        // readystate 3 means the response is not yet complete.
        if (xhr.readyState === 3) {
            var currentProgress = xhr.responseText;
            // Post a message underneath the spinner
            document.getElementById('spinner-message').textContent = currentProgress;
        }
    }
    xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    xhr.send("location_point=" + encodeURIComponent(document.getElementById('location_point').value)
        + "&dist=" + encodeURIComponent(document.getElementById('dist').value)
        + "&filename=" + encodeURIComponent(document.getElementById('filename').value));
    xhr.onload = function (e) {
        // Hide the spinner
        document.getElementById('spinner').style.display = 'none';
        document.getElementById('spinner-message').textContent = "";

        if (xhr.readyState === 4) {
            if (xhr.status === 200) {
                console.log(xhr.responseText);
                var downloadLink = document.getElementById("download_link");
                downloadLink.style.display = "block"; // make the link visible
                downloadLink.href = "/data/" + encodeURIComponent(document.getElementById("filename").value) + ".gpkg";
                // download when done
                downloadLink.download = document.getElementById("filename").value + ".gpkg";
                var message = "Network loading completed! Click the link to download.";
                document.getElementById("spinner-message").textContent = message;
            } else {
                console.error(xhr.statusText);
            }
        }
    }
    xhr.onerror = function (e) {
        // Handles network errors
        console.error('An error occurred while performing the request.');
        // Hide the spinner
        document.getElementById('spinner').style.display = 'none';
        // Clear the message
        document.getElementById('spinner-message').textContent = "An error occurred. Please try again.";
    }
}