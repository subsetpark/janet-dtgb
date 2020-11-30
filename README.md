# The Janet Datetime Grab-Bag

This is not a date library. Those require design and work. 

This is a grab-bag of functions that do things you might like a date
library to do. They have been added piecemeal and probably don't hang
together that well.

That said, there is one guarantee for any function in this module: if
it returns a struct representing a datetime, that struct's keys should
be the same as those returned by `(os/date)`, and their values should
be in the same range with the same semantics (for instance, number
values should be 0-indexed in all cases).x
