class Restaurant {
    constructor(id, name, phone, address, city, state) {
        this.id = id;
        this.name = name;
        this.phone = phone;
        this.address = address;
        this.city = city;
        this.state = state;
    }
}

Restaurant.prototype.fullAddress = function() {
    return `${this.address}, ${this.city}, ${this.state}`;
}

class Experience {
    constructor(description, rating, user_name) {
        this.description = description;
        this.rating = rating;
        this.user_name = user_name;
    }
}

function addEventListeners() {
    $("a#all-restaurants").on('click', allRestaurantsListener);

    $("form.new_restaurant").on('submit', newRestaurantListener);

    $(document).on("click", "a.show-restaurant", showRestaurantListener);

    $("a#sort-all").on('click', sortListener);
}

function allRestaurantsListener(e) {
    e.preventDefault();
    clearRestaurant();

    $.get('/restaurants.json', function (data) {
        data.forEach(function (element) {
            let r = new Restaurant(element["id"], element["name"], element["phone"], element["address"], element["city"], element["state"]);
            let addR = "<div>";
            addR += `<h3>${r.name}</h3>`;
            addR += `<strong>Phone: </strong> ${r.phone}<br>`;
            addR += `<strong>Address: </strong> ${r.fullAddress()}<br>`;
            addR += `<a class="show-restaurant" href='#' data-id="${r.id}"> View Restaurant</a>`
            addR += "</div>";
            $("div#restaurants").append(addR);
        });
    });

    $("a#sort-all").removeAttr("hidden");
}

function newRestaurantListener(e) {
    e.preventDefault();

    let values = $(this).serialize();

    let posting = $.post("/restaurants", values);

    posting.done(function (data) {
        if (data["errors"] != null) {
            data["errors"].forEach(function (error) {
                $(".errors").append(`<li>${error}</li>`);
            });
            $(".errors").addClass("field_with_errors");
        } else {
            let r = new Restaurant(data["id"], data["name"], data["phone"], data["address"], data["city"], data["state"], data["price"]);
            $(".restaurantName").html(r.name);
            $(".restaurantPhone").html(r.phone);
            $(".restaurantAddress").html(r.fullAddress());
            $(".restaurantPrice").html(r.price);
            $("a.newRestaurant").removeAttr("hidden");
        }
        // Add a link to write a review and do that via AJAX too
    });
}

function showRestaurantListener(e) {
    e.preventDefault();
    let id = $(this).data('id');
    $.get(`/restaurants/${id}.json`, function (data) {
        let r = new Restaurant(data["id"], data["name"], data["phone"], data["address"], data["city"], data["state"]);
        $(".restaurantName").html(r.name);
        $(".restaurantPhone").html(r.phone);
        $(".restaurantAddress").html(r.fullAddress());
        $(".restaurantPrice").html(r.price);

        if (data["experiences"].length > 0) {
            data["experiences"].forEach(function (experience) {
                let e = new Experience(experience["description"], experience["rating"], experience["user"]["name"]);
                let eDiv = "<div>";
                eDiv += `<h3>${e.user_name} says...</h3>`
                eDiv += `<p>${e.description}</p>`
                eDiv += `<p>${e.rating}</p>`
                eDiv += "</div>"

                $('div#experiences').append(eDiv);
            });
        } else {
            $('div#experiences').append("No Reviews Yet!");
        }
    });
    $("div#restaurants").html("");
}

function sortListener(e) {
    e.preventDefault();

    $('div#restaurants').html('');
    $.get('/restaurants.json', function(data) {
        data.sort(function(a, b) {
            var nameA = a.name.toUpperCase(); // ignore upper and lowercase
            var nameB = b.name.toUpperCase(); // ignore upper and lowercase
            if (nameA < nameB) {
                return -1;
            }
            if (nameA > nameB) {
                return 1;
            }

            // names must be equal
            return 0;
        });

        data.forEach(function (element) {
            let r = new Restaurant(element["id"], element["name"], element["phone"], element["address"], element["city"], element["state"]);
            let addR = "<div>";
            addR += `<h3>${r.name}</h3>`;
            addR += `<strong>Phone: </strong> ${r.phone}<br>`;
            addR += `<strong>Address: </strong> ${r.fullAddress()}<br>`;
            addR += `<a class="show-restaurant" href='#' data-id="${r.id}"> View Restaurant</a>`
            addR += "</div>";
            $("div#restaurants").append(addR);
        });
    });
}

function clearRestaurant() {
    $(".restaurantName").html("");
    $(".restaurantPhone").html("");
    $(".restaurantAddress").html("");
    $(".restaurantPrice").html("");
    $("div#experiences").html("");
}
