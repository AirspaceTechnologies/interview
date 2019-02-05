# Interview exercise

This exercise is first and foremost something fun to work on. It's designed to give you a taste of what it's like to work at Airspace and for us to get a sense of how you program.

## Getting started
Assuming you've cloned this repository and have a working Ruby environment, from the root of the repository do:

1. `bundle install`: Install dependencies
1. `rake`: Run unit tests
1. `rake dev`: Start the application
1. Browse to [http://localhost:9292](http://localhost:9292)

You should see a working [Sinatra](https://github.com/sinatra/sinatra) application!

## Task #1: Reverse geocode and display addresses
Create a web page that displays the address of each of the following locations:
```
   Latitude   Longitude
  ----------------------
  61.582195, -149.443512
  44.775211, -68.774184
  25.891297, -97.393349
  45.787839, -108.502110
  35.109937, -89.959983
```

Use the [Geocoder gem](https://github.com/alexreisner/geocoder) 
to get the addresses.

## Task #2: Improve display
Use [Bootstrap](https://getbootstrap.com/) to make the page from task #1 look better.

## Task #3: Calculate and display distance
 Update the web page to display for each address its distance to the White House,
**1600 Pennsylvania Avenue NW Washington, D.C. 20500**. Sort the list of addresses by distance to the White House, ascending.
