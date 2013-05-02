

  <% @skills.each do |skill| %>
      <input type="checkbox" name="skill" value="<%= skill.name %>"><%= skill.name %></option><br>
      <% end %>
    </select>
