# NotificationPusher for ActionMailer

[![Gem Version](https://badge.fury.io/rb/notification-pusher-actionmailer.svg)](https://badge.fury.io/rb/notification-pusher-actionmailer) <img src="https://travis-ci.org/jonhue/notifications-rails.svg?branch=master" />

A pusher to send your notifications via email utilizing ActionMailer.

---

## Table of Contents

* [Installation](#installation)
* [Usage](#usage)
    * [Options](#options)
* [To Do](#to-do)
* [Contributing](#contributing)
    * [Contributors](#contributors)
    * [Semantic versioning](#semantic-versioning)
* [License](#license)

---

## Installation

NotificationPusher for ActionMailer works with Rails 5 onwards. You can add it to your `Gemfile` with:

```ruby
gem 'notification-pusher-actionmailer'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install notification-pusher-actionmailer

If you always want to be up to date fetch the latest from GitHub in your `Gemfile`:

```ruby
gem 'notification-pusher-actionmailer', github: 'jonhue/notifications-rails'
```

---

## Usage

Define this pusher in your `NotificationPusher` configuration:

```ruby
NotificationPusher.configure do |config|
    config.define_pusher :ActionMailer
end
```

You can pass a `from` parameter, which will override the default email address specified in `ApplicationMailer`:

```ruby
NotificationPusher.configure do |config|
    config.define_pusher :ActionMailer, from: 'my@email.com'
end
```

Then add a renderer called `_actionmailer.html.erb` to every notification type you aim to support. Learn more [here](https://github.com/jonhue/notifications-rails/tree/master/notification-renderer).

Now you can push your notifications:

```ruby
notification = Notification.create target: User.first, object: Recipe.first
notification.push :ActionMailer, to: 'another@email.com'
```

**Note:** If the email address, you want to push to, is the same as `notification.target.email` you can omit the `to` parameter.

It is also possible to override the email address sending this notification, by passing a `from` parameter.

### Options

**`to`** Receiver email address. Takes a string.

**`from`** Sender email address. Takes a string. Defaults to email specified in `ApplicationMailer`.

**`renderer`** Specify a renderer. Takes a string. Defaults to `'actionmailer'`.

**`layout`** Layout used for template rendering. Takes a string. Defaults to layout specified in `ApplicationMailer`.

---

## To Do

[Here](https://github.com/jonhue/notifications-rails/projects/6) is the full list of current projects.

To propose your ideas, initiate the discussion by adding a [new issue](https://github.com/jonhue/notifications-rails/issues/new).

---

## Contributing

We hope that you will consider contributing to NotificationPusher for ActionMailer. Please read this short overview for some information about how to get started:

[Learn more about contributing to this repository](https://github.com/jonhue/notifications-rails/blob/master/CONTRIBUTING.md), [Code of Conduct](https://github.com/jonhue/notifications-rails/blob/master/CODE_OF_CONDUCT.md)

### Contributors

Give the people some :heart: who are working on this project. See them all at:

https://github.com/jonhue/notifications-rails/graphs/contributors

### Semantic Versioning

NotificationPusher for ActionMailer follows Semantic Versioning 2.0 as defined at http://semver.org.

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
