Once rails installation is completed:

1. Generate an app directory:
   ```
   rails new example-app
   ```{{execute T1}}
   _[editorial note: This should take about 25 seconds.]_

2. Commit your baseline app directory:
   ```
   cd example-app
   git add .
   git commit -m 'Pristine Rails application'
   ```{{execute T1}}

3. Start your rails dev server in a new terminal tab:

   <!--
   Let's run this in a 2nd terminal.
   ```
   # Editorial note: Why isn't the initial command run in the 2nd terminal??
   # To be resolved by INKA-1757; until then, we'll work-around by running
   # this throw-away command.
   echo "Warm up 2nd terminal."
   ```{{execute T2}}
   Wait for the terminal prompt to appear, then proceed with:
   -->

   ```
   exec bash -l
   export RAILS_DEVELOPMENT_HOSTS='[[HOST_SUBDOMAIN]]-3000-[[KATACODA_HOST]].environments.katacoda.com'
   cd example-app &&
     rails server -b 0.0.0.0
   ```{{execute T2}}
   <!--
   * The `-b 0.0.0.0` tells the development servers to accept outside
     connections.  This is necessary in this environment and may be needed
     from within docker containers, but you may want to avoid it when running
     _outside_ docker on your laptop for security reasons.
   * The `RAILS_DEVELOPMENT_HOSTS` part tells rails that it's ok to accept
     connections with that HTTP Host header.
   * The `bash -l` is to start a "login shell", because, on this host at
     least, RVM wouldn't load in this 2nd terminal otherwise, and the
     `ruby` command would not be found.
   -->

   (In many development environments, just a simple `rails console` would
   suffice.)

4. View your sample web application by clicking the "Your Web App" tab, or
   open [your development server][dev-server] in a new browser tab.

   You should see a placeholder page with a Rails logo.

You can edit the application files in `example-app`, run commands in the
first "Terminal" tab, or restart the server in the 2nd tab as needed.

[dev-server]:https://[[HOST_SUBDOMAIN]]-3000-[[KATACODA_HOST]].environments.katacoda.com

## When you're done

When you're finished exploring Ruby on Rails, click "Continue" to end this
session.
