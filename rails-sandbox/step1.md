This host comes with Ruby pre-installed via RVM:
```
which ruby
ruby --version
```{{execute}}

Let's get started with Ruby on Rails:

1. Install Rails:
   ```
   gem install rails --no-document
   ```{{execute T1}}
   The `--no-document` skips a documentation build process that would be
   useful if you couldn't look up API docs in a browser.
  
   _[editorial note: This should take about 10 seconds.]_

2. Install standard timezone data that is not already available on this
   host:
   ```
   apt-get update -q &&
     DEBIAN_FRONTEND=noninteractive apt-get install -yq tzdata
   ```{{execute T1}}
   _[editorial note: This should take about 6 seconds.]_

3. Generate an app directory:
   ```
   rails new example-app
   ```{{execute T1}}
   _[editorial note: This should take about 25 seconds.]_

4. Commit your baseline app directory:
   ```
   cd example-app
   git add .
   git commit -m 'Pristine Rails application'
   ```{{execute T1}}

5. Start your rails dev server in a new terminal tab:
   Let's run this in a 2nd terminal.
   ```
   # Editorial note: Why isn't the initial command run in the 2nd terminal??
   # To be resolved by INKA-1757; until then, we'll work-around by running
   # this throw-away command.
   echo "Warm up 2nd terminal."
   ```{{execute T2}}
   Wait for the terminal prompt to appear, then proceed with:

   <div data-test-output="Listening on http://0.0.0.0:3000">
   ```
   exec bash -l
   export RAILS_DEVELOPMENT_HOSTS='[[HOST_SUBDOMAIN]]-3000-[[KATACODA_HOST]].environments.katacoda.com'
   cd example-app &&
     rails server -b 0.0.0.0
   ```{{execute T2 test-no-wait}}
   </div>

   * The `-b 0.0.0.0` tells the development servers to accept outside
     connections.  This is necessary in this environment and may be needed
     from within docker containers, but you may want to avoid it when running
     _outside_ docker on your laptop for security reasons.
   * The `RAILS_DEVELOPMENT_HOSTS` part tells rails that it's ok to accept
     connections with that HTTP Host header.
   * The `bash -l` is to start a "login shell", because, on this host at
     least, RVM wouldn't load in this 2nd terminal otherwise, and the
     `ruby` command would not be found.

   (In many development environments, just a simple `rails server` would
   suffice.)

   Subsequent commands will run in the first terminal, but you can flip
   back to this 2nd terminal any time to view the logging and diagnostics
   emitted by `rails server` to:
   * Understand what requests are made of the server, their query parameters,
     and how they are routed
   * Inspect the SQL queries produced by your app and their performance
   * Resolve errors

6. View your sample web application by clicking the "Your Web App" tab, or
   open [your development server][dev-server] in a new browser tab.  

   You should see a placeholder page with a Rails logo.

7. Generate a baseline schema:
   ```
   rails db:migrate &&
     git add db/ &&
     git commit -m 'Generate initial schema'
   ```{{execute T1}}

8. Generate a scaffold to get you started.  This one is for a very simple
   blog post:
   ```
   rails generate scaffold Post title:string body:text
   rails db:migrate &&
     git add . &&
     git commit -m 'Generate Post scaffold with title and body'
   ```{{execute T1}}

9. Now visit the [Post controller][posts] and create a Post or two.  (Click
   "New post".)

10. Open `app/controllers/posts_controller.rb`{{open}} to see some code
    behind that workflow.

11. Open the Rails console to see your posts in an interactive
    Ruby environment called the Rails Console:

    <div data-test-output="3.2.2 :001 >">
    ```
    rails console
    ```{{execute T1 test-no-wait}}
    </div>

    ```ruby
    Post.all.pluck(:title)
    ```{{execute T1}}

    <div data-test-output="$ ">
    ```ruby
    exit()
    ```{{execute T1 test-no-wait}}
    </div>

12. Open `app/models/posts.rb`{{open}} to see some code behind that model.

13. Edit templates in `app/views/posts/` to customize the pages shown as
    part of that workflow.

Learn more about Rails with:
* Michael Hartl's
  [Ruby on Rails Tutorial book](https://learning.oreilly.com/library/view/-/9780138050061/) or
  [video course](https://learning.oreilly.com/videos/-/9780138050351/)
* Official [Rails Guides](https://guides.rubyonrails.org/)
* [other rails resources](https://learning.oreilly.com/search/?q=rails&type=*&rows=10)

[dev-server]:https://[[HOST_SUBDOMAIN]]-3000-[[KATACODA_HOST]].environments.katacoda.com
[posts]:https://[[HOST_SUBDOMAIN]]-3000-[[KATACODA_HOST]].environments.katacoda.com/posts

## When you're done

When you're finished exploring Ruby on Rails, click "Continue" to end this
session.
