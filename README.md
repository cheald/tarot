# Tarot

Tarot is a quick, simple, and useful configuration manager for Rails applications. It supports easy-to-use deeply-nested configuration trees, default values, and multiple environments. Tarot leverages YAML to enable DRY configurations, and features I18n-style access to subtrees.

## Getting Started

Add Tarot to your gemfile:

    gem "tarot"

Next, install the Tarot configuration:

    bundle install
    script/generate tarot

This installs config/tarot.yml (your primary configuration), and an initializer to help you get up and running quickly.

## Usage

Tarot installs a helper method, `config`, with the following signature:

    config(path, default = nil, override_environment = nil)

Assuming you have a config file like so:

    ---
    base: &base
      foo: bar
      nested:
        tree: value
      array:
        - value 1
        - value 2

    development: &development
      <<: *base

    test: &test
      <<: *base

    production: &production
      <<: *base
      foo: baz

You could can access values by key, or by dot-delimited path:

    config('foo') => 'bar'
    config('nested.tree') => value

Default values are similarly easy.

    config('foo.missing', 42) => 42

Finally, while Tarot will read your current application environment's config, if you want to reach into another environment, that's likewise easy:

    config('foo', nil, 'production') => 'baz'

This lets you build out config files easily while sharing common configuration between environments.

## Credits
 
Tarot was written by Chris Heald (cheald@gmail.com). See LICENSE for license details.
