# Paddock

    "...even Nedry knew better than to mess with the raptor fences."

Paddock is a feature switch system.

Define which features should be used in certain environments.

## Setup

Put this somewhere like: `config/initializers/paddock.rb`

    include Paddock

    Paddock(Rails.env) do
      enable  :phone_system,  :in => [:development, :test]
      enable  :door_locks,    :in => :development
      enable  :raptor_fences
      disable :cryo_security
      disable :tyranosaur_fences, :in => :production
    end

You name it, we got it.

## Usage

    # Check if feature is enabled
    if feature(:perimeter_fence)
      # do work
    end

    # Guard a block
    feature(:perimeter_fence) do
      # do work
    end

This is a unix system. I know this.

## Testing

This might need some work.

You can define which features are enabled in a test:

    before(:each) do
      Paddock.enable :feature_i_am_testing
    end

You think that kind of automation is easy? Or cheap?

## Authors

We're not computer nerds. We prefer to be called "hackers."

* Pat Nakajima
* Brandon Keene

![system secured](http://ak2.static.dailymotion.com/static/video/024/680/8086420:jpeg_preview_large.jpg)

(c) Copyright 2010 Pivotal Labs, see LICENSE
