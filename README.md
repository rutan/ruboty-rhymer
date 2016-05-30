# Ruboty::Rhymer

[![Build Status](https://travis-ci.org/rutan/ruboty-rhymer.svg?branch=master)](https://travis-ci.org/rutan/ruboty-rhymer)

[rhymer](https://github.com/suzuki86/rhymer) handler for [Ruboty](https://github.com/r7kamura/ruboty).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rhymer', github: 'suzuki86/rhymer'
gem 'ruboty-rhymer'
```

## Usage

```
$ bundle exec ruboty
Type `exit` or `quit` to end the session.

> 今日はとても良い天気ですね。
> いや、そうでもないか？
> でも、こんな日は自然に元気になります。
今日は良い天気　こんな日は自然に元気
```

## ENV

- `RHYMER_STORE` : The border score of rhymer (optional. default: 10)
- `RHYMER_STOCK_MIN` : Minimum size of stocked messages (optional. default: 10)
- `RHYMER_STOCK_MAX` : Maximum size of stocked messages (optional. default: 10)
- `RHYMER_OVERRIDE_TO` : Override `to` parameter of Ruboty (optional)

## License

MIT

