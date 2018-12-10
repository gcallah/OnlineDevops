
//when search button is clicked, toggle to search bar

var bt = document.getElementById("bt")
var navbar = document.getElementById("navbar")
var search = document.getElementById("search")

bt.onclick=function () {

        if(navbar.style.display==="none"){
            navbar.style.display='block'
        }else{
             navbar.style.display='none'
        }

        if(  search.style.display==="block"){
            search.style.display='none'
        }
        else{
             search.style.display='block'
        }
    }

