# Interview exercise

## Get started
Assuming you have a working Ruby environment, from the repo root do:

1. `bundle install`
2. `rackup -p 4567`
3. Browse to [http://localhost:4567](http://localhost:4567)

Upon success you should see the site working.

4. Run tests with `rspec spec`

## Notes
When first loaded, the site will show the reversed geocoded addresses on the map and table.

Click run at the top and the table, map, and database cache will be cleared. Then each coordinate will be reverse geocoded one by one and added back to the map, table, and database where they will be cached for the next page load.



