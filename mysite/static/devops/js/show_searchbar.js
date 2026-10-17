//when search button is clicked, toggle between the nav links and search bar

var bt = document.getElementById("bt")
var navbar = document.getElementById("navbar")
var search = document.getElementById("search")

bt.onclick = function () {
    var searching = search.hidden
    search.hidden = !searching
    navbar.hidden = searching
    if (searching) {
        search.querySelector("input").focus()
    }
}
