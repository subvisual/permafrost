Permafrost
==========

Freeze the environment (i.e. `ENV`) in a limited scope.

Inspired by [Timecop].


Installation
------------

Add this line to your application's Gemfile:

```ruby
gem "permafrost"
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install permafrost


Usage
-----

Freeze the environment, and change it at will inside a sandbox:

```ruby
ENV # { "RAILS_ENV" => "production", ... }

Permafrost.freeze do
  ENV.clear # {}
end

ENV # { "RAILS_ENV" => "production", ... }
```

Or, set the environment to use inside the sandbox:

```ruby
ENV # { "RAILS_ENV" => "production", ... }

Permafrost.freeze("foo" => "bar") do
  ENV # { "foo" => "bar" }
end

ENV # { "RAILS_ENV" => "production", ... }
```

You can also just change something in the environment, leaving the rest as it
is:

```ruby
ENV # { "RAILS_ENV" => "production", ... }

Permafrost.merge("foo" => "bar") do
  ENV # { "RAILS_ENV" => "production", ..., "foo" => "bar" }
end

ENV # { "RAILS_ENV" => "production", ... }
```


Development
-----------

After checking out the repo, run `bin/setup` to install dependencies. Then, run
`rake` to run the linter and tests. You can also run `bin/console` for an interactive
prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To
release a new version, update the version number in `version.rb`, and then run
`bundle exec rake release`, which will create a git tag for the version, push
git commits and tags, and push the `.gem` file to [rubygems.org].


Contributing
------------

Bug reports and pull requests are welcome on GitHub at
https://github.com/subvisual/permafrost.


License
-----

Permafrost is copyright &copy; 2020 Subvisual, Lda.

It is open-source, made available for free, and is subject to the terms in
its [license].


About
-----

Permafrost was created and is maintained with :heart: by
[Subvisual][subvisual].

[![Subvisual][subvisual-logo]][subvisual]


[Timecop]: https://github.com/travisjeffery/timecop
[license]: ./LICENSE.txt
[rubygems.org]: https://rubygems.org
[subvisual]: http://subvisual.com
[subvisual-logo]: https://raw.githubusercontent.com/subvisual/guides/master/github/templates/logos/blue.png