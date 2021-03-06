require 'rubygems'
require 'bundler/setup'

require 'git'
require 'redcarpet'
require 'rouge'
require 'rouge/plugins/redcarpet'
require 'rubypants'

require './extensions'
require_relative 'app/models/page'
require_relative 'app/models/query'


REPO_LOCATIONS = ["#{ENV['HOME']}/wiki", "#{ENV['HOME']}/.wiki"]

def is_repo?(location)
  File.exists?(location) && File.directory?(location)
end

def find_repo(locations = REPO_LOCATIONS)
  locations.detect do |location|
    is_repo?(location)
  end
end

def create_repo(location = REPO_LOCATIONS.first)
  puts "Initializing repository in #{location}..."
  Git.init(location)
  location
end

def find_or_create_repo
  find_repo || create_repo
end

GIT_REPO = find_or_create_repo
HOMEPAGE = 'home'

$repo = Git.open(GIT_REPO)



MARKDOWN_EXTENSIONS = {
  autolink: true,
  fenced_code_blocks: true,
  no_intra_emphasis: true,
  space_after_headers: true,
  strikethrough: true,
  tables: true }
REDERER_OPTIONS = {
  with_toc_data: true
}

class MyHTML < Redcarpet::Render::HTML
  include Rouge::Plugins::Redcarpet # hightlight code blocks with Rouge
end

renderer = MyHTML.new(REDERER_OPTIONS)
$markdown = Redcarpet::Markdown.new(renderer, MARKDOWN_EXTENSIONS)
$markdown_toc = Redcarpet::Markdown.new(Redcarpet::Render::HTML_TOC, MARKDOWN_EXTENSIONS)
