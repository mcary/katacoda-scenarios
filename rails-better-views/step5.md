extracting a helper or view component

---
Now we'll roll our posts#index changes into the [Rails scaffold generator
templates](https://guides.rubyonrails.org/generators.html#overriding-rails-generator-templates) so that future scaffolds will get the same treatment.

1. Create a directory for our customized template:
   ```
   mkdir lib/templates/erb/scaffold/
   ```{{execute T1}}

2. Create a new file at `lib/templates/erb/scaffold/index.html.erb.tt` with
   the following contents:

   <pre data-filename="lib/templates/erb/scaffold/index.html.erb.tt" data-target="append">
     <p style="color: green"><%%= notice %></p>

     <h1><%= human_name.pluralize %></h1>

     <table class="table table-hover table-striped table-bordered table-responsive">
       <thead>
         <tr>
           <th scope="col">#</th>
           <% attributes.reject(&:password_digest?).each do |attribute| %>
             <th scope="col"><%= attribute.human_name %></th>
           <% end %>
         </tr>
       </thead>
       <tbody>
         <%% @<%= plural_table_name %>.each do |<%= singular_table_name %>| %>
           <tr id="<%%= dom_id post %>">
             <th scope="row"><%%= link_to <%= singular_table_name %>.id, <%= singular_table_name %> %></th>
             <% attributes.reject(&:password_digest?).each do |attribute| %>
               <td><%%= <%= singular_name %>.<%= attribute.column_name %> %></td>
             <% end %>
           </tr>
         <%% end %>
       </tbody>
     </table>

     <%%= link_to "New <%= human_name.downcase %>", <%= new_helper(type: :path) %>, class: "btn btn-primary" %>
   </pre>

   This template is written in ERB.  It also outputs ERB.  To escape the
   ERB delimiter `<%` we must have doubled the percent signs as `<%%` if
   they are to remain in the rendered template.
   
   This template can be used for any model, so it doesn't know yet if we
   are working with a Post, a Comment, or something else.  Instead, it uses
   variables like `human_name` and `singular_table_name` to make the
   template specific to a particular model when the scaffold is generated.
   At that point, the model name and its attributes will be known.

3. Let's use this template to generate a Comment scaffold:

   ```
   rails generate scaffold Comment post:references body:text
   rails db:migrate &&
     git add . &&
     git commit -m 'Generate Comment with post_id and body'
   ```

   Examine the [Comments listing][comments] to see that the Comments
   listing was generated with bootstrap styling from the beginning.  We
   didn't need to re-apply the table styles to it.

We now have a way to generate nicely styled tables for any future scaffold
we generate, which is a big time saver.  However, as the application grows,
we'll accummulate many examples of this template, which presents some
maintenance problems:

* adding a new feature across all of them in a consistent way will become tedious
* they all need to be tested separately
* upgrading them to new Rails versions, if necessary, will be tedious and
  error-prone, especially if test coverage is not top-notch

In the next section, we'll see how to extract the duplicative bits of this
template to a helper or ViewComponent so that future maintenance is easier.
This would not necessarily be needed for an application that you only ever
expect to have a handful of resources, but would be a big help for an
ever-growing application over time.

[comments]:https://[[HOST_SUBDOMAIN]]-3000-[[KATACODA_HOST]].environments.katacoda.com/comments
