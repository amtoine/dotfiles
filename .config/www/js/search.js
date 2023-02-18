// Search on enter key event
document.getElementById("search-field").addEventListener("keydown",  event => {
    if (event.keyCode === 13) {
        var val = document.getElementById("search-field").value;
        window.open("https://google.com/search?q=" + val);
    }
});

document.addEventListener("keydown", event => {
    if (event.keyCode == 32) {          // Spacebar code to open search
        document.getElementById('search').style.display = 'flex';
        document.getElementById('search-field').focus();
    } else if (event.keyCode == 27) {   // Esc to close search
        document.getElementById('search-field').value = '';
        document.getElementById('search-field').blur();
        document.getElementById('search').style.display = 'none';
    }
});
