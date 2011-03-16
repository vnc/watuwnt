# watuwnt #

## todo ##

* Remove Description from table
* Make Name column wider
* Remove Created from table
* Remove Account from table
* Add description as large tooltip
* Add click row to change status (green: vote for, red: vote against, regular: no vote)
 * add status to Feature model
 * each click on a row creates an ajax vote post request
 * add a Votes record
 * ajax response includes color based on vote request (for, against, or no vote)
 * ajax response also includes user's remaining point balance
* On initial load, rows are colored based on user's most recent vote on each feature
* Sort Features list by votes (and by status)
* Remove Votes tab for 'user' role
* Remove "Profile" link on top right
* Update text block on right side
* Update or remove links on right side
* Update Dashboard text with instructions for user and how it fits in to prioritization process
 * include link to submit new feature via email or form
* solidify feature status as "draft", "voteable", "scheduled", "in progress", "implemented"