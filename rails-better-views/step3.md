Next we'll enhance the Post listing itself by applying the Bootstrap
[table](https://getbootstrap.com/docs/5.3/content/tables/) styles:

1. Open the `posts#index` view in `app/views/posts/index.html.erb`{{open}}
   and review the `div` and `p` tag markup that is already there.

   The `render post` call renders the post partial in
   `app/views/posts/_post.html.erb`.

   We'll want to be sure to keep the `notice` up top and the "New post"
   link at the bottom.

2. Replace the middle stanza with a Bootstrap-styled table:

   <pre class="file" data-filename="app/views/posts/index.html.erb" data-marker='<div id="posts">
  <% @posts.each do |post| %>
    <%= render post %>
    <p>
      <%= link_to "Show this post", post %>
    </p>
  <% end %>
</div>'>
     &lt;table class="table table-hover table-striped table-bordered table-responsive">
       &lt;thead>
         &lt;tr>
           &lt;th scope="col">#&lt;/th>
           &lt;th scope="col">Ttile&lt;/th>
           &lt;th scope="col">Body&lt;/th>
         &lt;/tr>
       &lt;/thead>
       &lt;tbody>
         &lt;% @posts.each do |post| %>
           &lt;tr id="&lt;%= dom_id post %>">
             &lt;th scope="row">&lt;%= link_to post.id, post %>&lt;/th>
             &lt;td>&lt;%= post.title %>&lt;/td>
             &lt;td>&lt;%= post.body %>&lt;/td>
           &lt;/tr>
         &lt;% end %>
       &lt;/tbody>
     &lt;/table>
   </pre>

   Visit the [Post listing][posts] to see the table.

3. Bootstrap doesn't style _all_ tables; the basic styles must be
   explicitly introduced with the `table` class.

   Additional classes:
   * table-hover - highlight the row under the mouse cursor
   * table-striped - add subtle accent behind alternating rows
   * table-bordered - show vertial and exterior borders, not just
     horizontal
   * table-responsive - scroll the table horizontally if it doesn't fit
   * table-sm - reduce padding in table cells to fit more data on the page

   Try toggling each of these classes in the table element.  Refresh the
   [Post listing][posts] to see the effect.

4. Next, let's change the "New post" link to look like a button.  We'll
   style it as the _primary_ button, which is a queue to the user that is
   is the most common or default action to take.

   <pre class="file" data-filename="app/views/posts/index.html.erb" data-marker='<%= link_to "New post", new_post_path %>'>
     <%= link_to "New post", new_post_path, class: "btn btn-primary" %>
   </pre>

   Refresh the [Post listing][posts] to see the new button.

With these stylistic changes, the data in the table has become much more
scannable to a human eye, and the primary button suggests a default action
for a user.

Unlike the changes from the previous step, these changes will not apply to
any new scaffolds that we generate.

[posts]:https://[[HOST_SUBDOMAIN]]-3000-[[KATACODA_HOST]].environments.katacoda.com/posts
