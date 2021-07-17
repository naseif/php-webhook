# php-webhook
A php github webhook script

## description

This repository contains two PHP scripts:
1) index.php
2) webhook.php

### webhook.php

Put this into the configuration of your github-Repository to collect push information from github.

(Repostiory->Settings->Webhooks; add webhook; add this as payload url)

Example:
https://yourserver.com/webhook.php -> github-repo-Settings

Content Type is application/x-www-form-urlencoded.

### index.php

Request the timestamp of the last push for the given repository on github.

Example request for "githubuser/githubrepo" :

https://yourserver.com/index.php?username=githubuser&repository=githubrepo

Returns the timestamp of the last push to github for the given repository.

## usage

You put the webhook url in your github repository configuration.
Then you need to have a script ready that executes somewhere on your server that requests the last timestamp from your index.php-copy. 
Every time the timestamp changes perform certain actions.

## setup

- Copy the php files onto your server into your php supporting webspace.
- Create a mysql database.
- execute the contents of the mysql.sql file so that the stored procedure and the table are created
- enter the correct connection information into the php files
- have a lot of fun

