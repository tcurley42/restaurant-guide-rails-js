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
    constructor(description, rating, user_id) {
        this.description = description;
        this.rating = rating;
        this.user_id = user_id;
    }
}

function addEventListeners() {
    $("a#all-restaurants").on('click', function(e) {
        e.preventDefault();
        $.get('/restaurants.json', function(data) {
            data.forEach(function (element) {
                let r = new Restaurant(element["id"], element["name"], element["phone"], element["address"], element["city"], element["state"]);
                let addR = "<div>";
                addR += `<h3>${r.name}</h3>`;
                addR += `<strong>Phone: </strong> ${r.phone}<br>`;
                addR += `<strong>Address: </strong> ${r.fullAddress()}<br>`;
                addR += `<a href='/restaurants/${r.id}'> View Restaurant</a>`
                addR += "</div>";
                $("div#restaurants").append(addR);
            });
        });
    });

    $("form.new-restaurant-form").on('submit', function(e) {
        e.preventDefault();

        let values = $(this).serialize();

        let posting = $.post("/restaurants", values);

        posting.done(function(data) {
            if (data["errors"] != null) {
                data["errors"].forEach(function(error){
                    $(".errors").append(`<li>${error}</li>`);
                });
                $(".errors").addClass("field_with_errors");
            } else {
                let r = new Restaurant(data["id"], data["name"], data["phone"], data["address"], data["city"], data["state"], data["price"]);
                $(".restaurantName").html(r.name);
                $(".restaurantPhone").html(r.phone);
                $(".restaurantAddress").html(r.fullAddress());
                $(".restaurantPrice").html(r.price);
            }
            // Add a link to write a review and do that via AJAX too
        });
    });
}

