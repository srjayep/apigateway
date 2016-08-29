# Docker::Tools

A set of tasks for Rake and Docker workflows, including local use of Docker Compose for testing, style enforcement and security checking where appropriate.


## Installation

Add this line to your application's Gemfile:

```ruby
gem "docker-tasks", require: false,
                    git: "git@git.corp.adobe.com:adobe-apis/docker-tasks.git"
```

And then execute:

    $ bundle install

## Usage

TODO: Write usage instructions here

### Setup

1. In `Rakefile`, add this -- replacing the domain name with the URL of your private Docker registry:
    ```ruby
    require "rubygems"
    require "bundler/setup"
    Bundler.require(:default, :development, :test)
    Dotenv.load(".common.env", ".env")

    require "docker/tools"

    # The first path should allow `docker push`, with authentication.
    # The second path should only allow `docker pull`, without authentication, and only from your private VPC.
    Docker::Tools.init!("registry.myorg.com:5000", "registry.myorg.com:5000")
    ```
1. Create a file named `.rubocop.local.yml` with your own Rubocop rules / configuration.
    * This will be merged with the saner defaults provided by `docker-tools` when running `rake lint:rubocop`.

### Running The Tools

```bash
rake lint # Run all `lint:*` tasks.  Includes `bundler-audit` and Rubocop by default.

rake docker:build docker:tag docker:push

# If you have a `docker-compose.yml` file:

rake compose:kill compose:rm compose:up
```

### Custom Lint Tasks

To add a task that gets executed when you run `rake lint`, simply create it in the `lint` namespace:

```ruby
namespace :lint do
  desc "Some sort of lint check for your project.  Will be included in `rake lint` automatically."
  task :my_check do
  end
end
```


1. Fork it
2. Create your feature branch (`git checkout -b jirastory_number`)
3. Commit your changes (`git commit -am 'Adding new features'`)
4. Push to the branch (`git push origin jirastory_number`)
5. Create a new Pull Request
