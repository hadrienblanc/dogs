# Ruby on Rails - Showcase

This Ruby on Rails project is designed to showcase a modern web application development stack.

Let's break down each of these technologies, especially in the context of building a single-page application (SPA) that emphasizes productivity and follows Ruby on Rails conventions.

## Stack :

### 1. **Rails 7**
   - **Technology**: Rails 7 is the latest major version of the Ruby on Rails framework. It's a web application framework written in Ruby, known for its convention over configuration philosophy.
   - **Goal**: Rails 7 aims to simplify the process of building modern web applications. It includes support for JavaScript frameworks, better database management, and more straightforward ways to handle background jobs. By embracing latest practices, it increases developer productivity, allowing for rapid development and clean, maintainable code.

### 2. **Ruby 3.2**
   - **Technology**: Ruby 3.2 is a version of the Ruby programming language. Ruby is known for its elegant syntax and is the language underlying Ruby on Rails.

### 3. **Stimulus**
   - **Technology**: Stimulus is a modest JavaScript framework designed to enhance HTML by connecting elements to JavaScript objects automatically. It's part of the Hotwire suite, which includes Turbo and is developed by the same team as Rails.


### 4. **Turbo**
   - **Technology**: Turbo is another part of the Hotwire suite. It consists of several libraries, including Turbo Drive, Turbo Frames, and Turbo Streams, each aiding in creating faster and more dynamic applications without the need for much custom JavaScript.
   More info : https://turbo.hotwired.dev

### 5. **ActionCable**
   - **Technology**: ActionCable is a Rails framework that seamlessly integrates WebSockets with the rest of a Rails application. It allows for real-time features, such as chat and notifications.
   - **Goal**: The goal of ActionCable is to bring real-time functionality to Rails applications with minimal fuss. It's designed to be easy to work with for Rails developers, using familiar tools and patterns.

## Integration and Use in SPAs
In the context of SPAs, these technologies work together to create a seamless, interactive user experience typical of single-page applications but with the simplicity and convention of Rails. 

- **Turbo Frames**: By using `turbo_frame_tag`, parts of the page can be updated without a full reload. This tag allows content inside it to be updated independently, enabling dynamic, partial page updates.
  
- **Convention over Configuration**: This core Rails philosophy is evident in how these technologies are integrated. They are designed to work well together with minimal setup, allowing developers to focus on building features rather than configuring basic functionalities.


## Code

### Index page
```ruby
  <%= turbo_frame_tag 'dog_requests' do %>
    <%= render @dog_requests %>
  <% end %>
```

### Objet creation :
```ruby
<%= turbo_stream.prepend 'dog_requests', partial: 'dog_request', locals: { dog_request: @dog_request } %>

```

### The event from ActiveJob (when we fetch the dog image)

```ruby
    Turbo::StreamsChannel.broadcast_replace_to(
      'dog_request_channel',
      partial: 'dog_requests/dog_request',
      target: "dog_request_#{dog_request.id}",
      locals: { dog_request: }
    )
```


## A lazy loading frame

```ruby
  <%= turbo_frame_tag :dog_requests,
    src: dog_requests_index_lazy_path,
    loading: :lazy do %>
    <!-- example : html for a spinner -->
  <% end %>
```
