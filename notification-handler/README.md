# NotificationHandler

[![Gem Version](https://badge.fury.io/rb/notification-handler.svg)](https://badge.fury.io/rb/notification-handler) <img src="https://travis-ci.org/jonhue/notifications-rails.svg?branch=master" />

Create and modify your notifications through a simple API.

---

## Table of Contents

* [Installation](#installation)
* [Usage](#usage)
    * [`Notification` API](#notification-api)
    * [`notification_target`](#notification_target)
    * [`notification_object`](#notification_object)
    * [Groups](#groups)
        * [Defining a group](#defining-a-group)
        * [Using a group](#using-a-group)
    * [Caching](#caching)
* [Configuration](#configuration)
* [To Do](#to-do)
* [Contributing](#contributing)
    * [Contributors](#contributors)
    * [Semantic versioning](#semantic-versioning)
* [License](#license)

---

## Installation

NotificationHandler works with Rails 5 onwards. You can add it to your `Gemfile` with:

```ruby
gem 'notification-handler'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install notification-handler

If you always want to be up to date fetch the latest from GitHub in your `Gemfile`:

```ruby
gem 'notification-handler', github: 'jonhue/notifications-rails'
```

Now run the generator:

    $ rails g notification_handler:install

To wrap things up, migrate the changes to your database:

    $ rails db:migrate

---

## Usage

### `Notification` API

You can use all the ActiveRecord methods you know and love on your `Notification` class. So creating a new notification is dead simple:

```ruby
notification = Notification.new
```

Every `Notification` object has a `target` record. This target record is the object, that this notification belongs to (or targets). Usually it's a user, but it can be a record of any class:

```ruby
notification.target = User.first
```

To store information in your `Notification` record you can use the `metadata` attribute that gets serialized as a `Hash`:

```ruby
notification.metadata = {
    title: 'My first notification',
    content: "It looks great, doesn't it?"
}
```

Another form of adding information is by associating an object to the notification. This can be a record of any class you like:

```ruby
notification.object = Recipe.first
```

The `read` attribute determines whether a notification has been seen or not:

```ruby
notification.read = true
notification.read? # true
notification.unread? # false
```

You can use scopes to filter for read or unread notifications:

```ruby
# Return all read notifications
Notification.read

# Return all unread notifications
Notification.unread

# Number of unread notifications
Notification.unread.count
```

### `notification_target`

To use records of an ActiveRecord class as notification targets, add the following to your class:

```ruby
class User < ApplicationRecord
    notification_target
end
```

Now belonging notifications are easy to access:

```ruby
notifications = User.first.notifications
```

You can create a notification from a `target`:

```ruby
User.first.notify object: Recipe.first
```

...

### `notification_object`

When using records of an ActiveRecord class as notification objects, add this to your class:

```ruby
class Recipe < ApplicationRecord
    notification_object
end
```

Now associated notifications are easy to access:

```ruby
notifications = Recipe.first.belonging_notifications
```

...

### Groups

Groups are a powerful way to bulk-create notifications for multiple objects that don't necessarily have a common class.

#### Defining a group

You define groups in your `NotificationHandler` configuration:

```ruby
NotificationHandler.configure do |config|
    config.define_group :subscribers, User.where(subscriber: true)
end
```

When creating a notification for the group `:subscribers`, one notification will be added for every target that fulfills this scope: `User.where(subscriber: true)`. You can also target objects from different classes:

```ruby
NotificationHandler.configure do |config|
    config.define_group :subscribers, User.where(subscriber: true) + Admin.all
end
```

#### Using a group

Bulk-creation of notifications for a certain group is fairly simple:

```ruby
notification = Notification.create object: Recipe.first, group: :subscribers
```

**Note:** You are not able to set the `target` attribute when a `group` has been specified.

### Caching

You can cache the amount of unread and read notifications for notification targets by settings the [`cache`](#configuration) configuration option to `true`.

Then add the following columns to the database tables of ActiveRecord classes acting as notification targets:

```ruby
add_column :user, :read_notification_count, :integer
add_column :user, :unread_notification_count, :integer
```

---

## Configuration

You can configure NotificationHandler by passing a block to `configure`. This can be done in `config/initializers/notification-handler.rb`:

```ruby
NotificationHandler.configure do |config|
    config.cache = true
end
```

**`cache`** Cache amount of unread and read notifications for notification targets. Takes a boolean. Defaults to `false`.

---

## To Do

[Here](https://github.com/jonhue/notifications-rails/projects/2) is the full list of current projects.

To propose your ideas, initiate the discussion by adding a [new issue](https://github.com/jonhue/notifications-rails/issues/new).

---

## Contributing

We hope that you will consider contributing to NotificationHandler. Please read this short overview for some information about how to get started:

[Learn more about contributing to this repository](https://github.com/jonhue/notifications-rails/blob/master/CONTRIBUTING.md), [Code of Conduct](https://github.com/jonhue/notifications-rails/blob/master/CODE_OF_CONDUCT.md)

### Contributors

Give the people some :heart: who are working on this project. See them all at:

https://github.com/jonhue/notifications-rails/graphs/contributors

### Semantic Versioning

NotificationHandler follows Semantic Versioning 2.0 as defined at http://semver.org.

## License

MIT License

Copyright (c) 2017 Jonas Hübotter

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
