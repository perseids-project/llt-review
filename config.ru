require 'haml'
require 'sass/plugin/rack'
require 'llt/review/api'

Sass::Plugin.options[:style] = :compressed
use Sass::Plugin::Rack

run Api
