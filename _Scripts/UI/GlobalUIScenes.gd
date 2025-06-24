extends Node

## Stores a reference to useful UI scenes globally
## so they can be used by any object
##
## Scenes need to subscribe themselves to this global script,
## so that may create some funky race conditions


# The discussion popup box
var DiscussionPopup
