

# New York Times Event Listing

### CLI

##### Available commands:

`search <KEYWORD><FILTER>`   Search events by keyword and filter(optional).

`favorites`                  Shows the user the their favorite events.

`help`                       Shows help.

##### Filters:
`-m` or `-Manhattan`         Filters the results for events in Manhattan only.

`-b` or `-Brooklyn`          Filters the results for events in Brooklyn only.

`-q` or `-Queens`            Filters the results for events in Queens only.

`-x` or `-Bronx`             Filters the results for events in Bronx only.

`-s` or `Staten Island`      Filters the results for events in Staten Island only.

### How to use the commands

Run the commands by typing `ruby bin/run.rb` before the command you want to use.

###### Example:

`ruby bin/run.rb search music`

You can apply a filter to limit the search for an specific borough

`ruby bin/run.rb search music  -m`
