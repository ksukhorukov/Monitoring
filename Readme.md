# Servers monitoring application

Hello!

You could find all the components of the application at "Source" directory.

# Installation of monitor

```
$ cd monitoring
$ rvm use ruby-2.1.5@crossover --create
$ bundle
```

Then you should edit user & password settings at config/database.yml file in order
to be able to setup the database with this command:

``
$ rake db:setup
``

At this step you are ready to launch monitoring server:

``
$ rails s
``

Go to http://localhost:3000 and add some server instance, rember the server id and copy api key, you will need it later for the authorization of the agent.

## Installation of agent 

All settings of monitoring agent are stored at ``config/settings.yml`` so you need to edit it properly in order to initialize the agent.
Example:

```
server_id: 1
api_url: http://localhost:3000/statistics
api_key: 3e8a6862c583d217b63dc286b67c0c4212fed940
```

If you want to launch agent.rb right after the system starts you need to
edit your cron daemon by doing this:

```
$ crontab -e
 @reboot /Users/kirill/workspace/crossover/agent/agent.rb
```

Now you are ready to launch the monitoring agent.
And if you want to daemonize the agent execute this command:

``
$ nohup ./agent.rb > /dev/null 2>&1 &
``

Agent sends an information to monitoring server every 5 seconds, so you could 
wait for a while and then check "Statistics" page on the side of monitoring server:

http://localhost:3000/statistics

If you need a PDF report, you could download it by pressing "Download" link on the right side of the server record.

Monitoring one server can be boring, but you are able to add more servers and launch more agents! Experement and enjoy!

# [EOF]