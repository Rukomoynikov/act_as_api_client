# act_as_api_client

How to create api clients for your application? What is a better way to encapsualte interactions with third APIs? My answer is `act_as_api_client`.

Let's assume you have a typical Rails or any ruby application and want to play around with an API, Github for example. See the [Usage](#usage) section to find how to use existing preconfigured API's and encapsulate all logic inside `APIClient` classes.

_At the moment i experiment in order to make api clients behavior very similiar to `ActiveRecord` models, so out of the box most of the clients support these methods: find, where, delete, update, find_by, create, update_   

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'act_as_api_client'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install act_as_api_client

## Usage

**1. Folder for clients:**
Create a folder for examples api_clients inside your `lib` directory.

**2. Create API client class:**
For example you want to fetch and update Github repositoties, then you class may have a form like this:

```ruby
class GithubClient < ApiClient
  act_as_api_client for: :github
end
```

In case you want to provide and use auth token for Github: 

```ruby
class GithubClient < ApiClient
  act_as_api_client for: :github,
                    with: {
                      token: <your_token>
                    }
end
```

btw, all values from `with` hash will be availabe in tour clients as instance variable `@options`   

## List of supported api clients
1. [Github Repositories](https://docs.github.com/en/rest/repos/repos)

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/act_as_api_client. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/act_as_api_client/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the ActAsApiClient project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/act_as_api_client/blob/master/CODE_OF_CONDUCT.md).
