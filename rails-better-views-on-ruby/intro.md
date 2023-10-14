<img alt="Ruby on Rails logo" style="float: right; padding: 0 0.5em 0.8em 2em; max-width: 40%" src="https://upload.wikimedia.org/wikipedia/commons/6/62/Ruby_On_Rails_Logo.svg" />

This lab explores ways to improve the visual quality of the views generated
by Ruby on Rails.

[This is a earlier version of a [Rails Better Views](https://www.katacoda.com/orm-mcary/scenarios/rails-better-views) lab that runs commands in the background and shows which command is being run in the foreground.  The lastest version of the lab instead builds on a rails:7.1 image that has most of those commands already run, but this foreground/background approach could be worth replicating elsewhere.]

Rails can generate a scaffold to get your application off an running
quickly, creating files to hold all the details necessary to get a model,
controller, views, routes, tests, and more, all working together.  However,
the templates it generates are not intended for production use; they are
just a starting point.

This lab will expand upon those templates in various ways:

* Customize the scaffolded view with Bootstrap
* Push our customizations into scaffold templates so that additional
  scaffolds will benefit
* Extract something truly reusable -- a template or even a view component

## Prerequisites

This lab assumes basic familiarity with model, view, and controller layers
of Ruby on Rails.  If these topics are new to you, check out these
interactive labs first:

* Intro to Ruby on Rails
* Rails Models
* Rails Views
* Rails Controllers
