# SpreedlyAirlines

A sample application to learn how to do some basic operations
with the Spreedly API and Express.

# Questions

Here are some questions I ran into along the way that I would like
some more experienced Elixir-est to point me to a resource on (or
that I expect to learn as I get into more Elixir resources):

* Where do people typically put format logic? Ex: Currency, date
* Loading dependent data from Ecto - is Repo.get most appropriate way? (Ex: SpreedlyAirlines.BookingController.show)
* Tests - do they always interact with database/external APIs or are there patterns for mocking or intercepting these?
* How do I access configs from modules? (like not hardcoding the values in my SpreedlyApi module?)

# Bleh code

And here is some known bleh code:

* Not crazy about the JS flow, but didn't seem valuable to rewrite it as I learned the intended flow better
* probably others I've forgotten (time keeps on slipping, slipping, slipping...)

# Things I wouldn't do in a real app

And things I intended to do and forgot about:

* Basic validation on the JS code
* hardcoded API keys, etc - these have been disabled/rotated
