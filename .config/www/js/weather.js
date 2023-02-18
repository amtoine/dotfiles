window.onload = () => {
    let xhr = new XMLHttpRequest();
    // Request to open weather map
    xhr.open('GET', 'http://api.openweathermap.org/data/2.5/weather?id=4737316&units=imperial&appid=e5b292ae2f9dae5f29e11499c2d82ece');
    xhr.onload = () => {
        if (xhr.readyState === 4) {
            if (xhr.status === 200) {
                let json = JSON.parse(xhr.responseText);
                console.log(json);
                document.getElementById("temp").innerHTML = json.main.temp.toFixed(0) + " F";
                document.getElementById("weather-description").innerHTML = json.weather[0].description;
            } else {
                console.log('error msg: ' + xhr.status);
            }
        }
    }
    xhr.send();
    // Set up the clock
    document.getElementById("clock").innerHTML = getTime();
    // Set clock interval to tick clock
    setInterval( () => {
        document.getElementById("clock").innerHTML = getTime();
    },100);
}
