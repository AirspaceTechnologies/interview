# Interview exercise

This exercise is, first and foremost, something fun to work on. It's designed to give you a taste of what it's like to 
work at Airspace and for us to get a sense of how you program. There are 3 tasks to work through. If you have any questions 
at all please shoot us an email and we'll reply as soon as we can. 

## Get started
Assuming you have a working Ruby environment, from the repo root do:

1. `bundle install`
2. `rackup -p 4567`
3. Browse to [http://localhost:4567](http://localhost:4567)

Upon success you'll have a working [Sinatra](https://github.com/sinatra/sinatra) application to play with.

4. Run tests with `rspec spec`

## Task #1: Reverse geocode and display addresses
Given the following coordinates:

```
   Latitude   Longitude
  ----------------------
  61.582195, -149.443512
  44.775211, -68.774184
  25.891297, -97.393349
  45.787839, -108.502110
  35.109937, -89.959983
```

render a web page that displays the addresses of each. Use the [Geocoder gem](https://github.com/alexreisner/geocoder) 
to get the addresses.

## Task #2: Improve display
Use [Bootstrap](https://getbootstrap.com/) to make the page from task #1 look better.

## Task #3: Calculate and display distance
Calculate the distance between each of the above coordinates and The White House, which is located at
**1600 Pennsylvania Avenue NW Washington, D.C. 20500**. Update the web page from task #2 to list each address and its
determined distance in ascending order.
