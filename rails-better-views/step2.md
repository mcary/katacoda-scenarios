Let's enhance the visual appearance of our Posts scaffold with a primary
goal of making it easier to digest the information on the page.

In this lab we will use the Twitter Bootstrap CSS framework to enhance our
views, but Rails also integrates well with Tailwind and other CSS
frameworks.

1. Install `bootstrap` rubygem:
   <!-- Report of breaking change with 5.3.2:
        https://github.com/twbs/bootstrap-rubygem/issues/267 -->
   ```
   bundle add bootstrap -v '~> 5.3.1'
   bundle add dartsass-sprockets -v '~> 3.0.0'
   ```{{execute T1}}

   The `bundle add` command has appended a dependency to the Gemfile:
   <!-- The additional dependency unfortunately tends to exceed terminal
        height and cause "less" to stay open.  This is a problem for
        testing and for anyone who doesn't know how to exit "less".

        Maybe best is to explain how to do it?  Space, q w/ kbd? -->
   <!-- Breaking this command by placing "--color" after "Gemfile" wasn't
        caught by the test.  Should we enable pipefail when testing?  -->
   ```
   git diff --color Gemfile | tail
   ```{{execute T1}}

2. Following the installation instructions from the [README
   file](https://github.com/twbs/bootstrap-rubygem#readme) of the gem we
   have installed, we'll rename the application.css file to
   application.scss:
   ```
   git mv app/assets/stylesheets/application.css app/assets/stylesheets/application.scss
   ```{{execute T1}}

   Then open
   `app/assets/stylesheets/application.scss`{{open}} to import the
   `bootstrap` styles:

   <pre class="file" data-filename="xapp/assets/stylesheets/application.scss" data-target="append">
   // Custom bootstrap variables must be set or imported *before* bootstrap.
   @import "bootstrap";
   </pre>

   We'll also want to remove the require lines; if you add other .css or
   .scss files, you'll need to `@import` them instead.
   ```
   sed -i '/= require/d' app/assets/stylesheets/application.scss
   ```{{execute T1}}

3. Now open `app/javascript/application.js`{{open}} to import
   `bootstrap`:

   <pre class="file" data-filename="app/javascript/application.js" data-target="append">

   import "popper"
   import "bootstrap"
   </pre>

4. Configure importmaps:

   <pre class="file" data-filename="config/importmap.rb" data-target="append">
   pin "popper", to: 'popper.js', preload: true
   pin "bootstrap", to: 'bootstrap.min.js', preload: true
   </pre>

5. Create an initializer to compile these assets in production:

   <pre class="file" data-filename="config/initializers/bootstrap.rb" data-target="append">
   Rails.application.config.assets.precompile += %w( bootstrap.min.js popper.js)
   </pre>

6. Restart the server:
   <!-- How to ensure we don't match the prior occurence of this?? -->
   <div data-test-output="Listening on http://0.0.0.0:3000">
   ```
   rails server -b 0.0.0.0
   ```{{execute T2 interrupt test-no-wait}}
   </div>

   Already, you'll see a change on the [Post listing][posts]: the font is
   changed from serif to sans-serif.

7. Taking this one step further, let's change the page layout to add some
   margin and an example navigation bar, which is adapted from Bootstrap
   [navbar](https://getbootstrap.com/docs/5.3/components/navbar/) docs:

   <!-- Leave extra code indentation to match the target erb file. -->
   <pre class="file" data-filename="app/views/layouts/application.html.erb" data-target="insert" data-marker="    <%= yield %>">
       &lt;nav class="navbar navbar-expand-lg bg-body-tertiary" style="background-color: #eee !important">
         &lt;div class="container">
           &lt;a class="navbar-brand" href="/">Your Logo&lt;/a>
           &lt;button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
             &lt;span class="navbar-toggler-icon">&lt;/span>
           &lt;/button>
           &lt;div class="collapse navbar-collapse" id="navbarSupportedContent">
             &lt;ul class="navbar-nav me-auto mb-2 mb-lg-0">
               &lt;li class="nav-item">
                 &lt;a class="nav-link active" aria-current="page" href="/posts">Posts&lt;/a>
               &lt;/li>
             &lt;/ul>
             &lt;form class="d-flex" role="search">
               &lt;input class="form-control me-2" type="search" placeholder="Search" aria-label="Search">
               &lt;button class="btn btn-outline-success" type="submit">Search&lt;/button>
             &lt;/form>
           &lt;/div>
         &lt;/div>
       &lt;/nav>

       &lt;div class="container">
         &lt;%= yield %>
       &lt;/div>
   </pre>

   Visit the [Post listing][posts] once more to see the padding and
   navigation.  (The search is not implemented; it's only included as a
   visual sample.)

So far, all the changes we have made are to the application.html.erb
layout, so any new scaffold or page that we add going forward will
automatically benefit from this CSS and navigation.

Although these improvements are visible on the posts page, we still haven't
changed the posts template itself -- that's next!

[posts]:https://[[HOST_SUBDOMAIN]]-3000-[[KATACODA_HOST]].environments.katacoda.com/posts
