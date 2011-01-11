# Require external libraries
# require 'rubygems'
require 'fileutils'
require 'date'
require 'digest/md5'
require 'nokogiri'
require 'gtk2'
require 'gtksourceview'

# Change working directory so that relative paths work
Dir.chdir(File.dirname(__FILE__))

# Require AE files
require 'lib/domain.rb'
require 'lib/main.rb'
require 'lib/utils.rb'
require 'lib/navigate.rb'
require 'lib/search.rb'
require 'lib/xml_to_markup.rb'
require 'lib/xsl_transform.rb'
require 'lib/rdadoc.rb'
require 'lib/current_node.rb'
require 'lib/sourceview.rb'
require 'lib/reviewview.rb'
require 'lib/formview_main.rb'
require 'lib/formview_treemenu.rb'
require 'lib/widgets_help.rb'
require 'lib/widgets_markup.rb'
require 'lib/widgets_multi.rb'
require 'lib/widgets_popups.rb'
require 'lib/widgets_prefs.rb'
require 'lib/widgets_samplejusts.rb'
require 'lib/widgets_simple.rb'
require 'lib/widgets_search.rb'

# On windows, win32ole methods allow MS Word and Internet Explorer to be
# invoked to open html and word transforms. Also, in windows, the program
# uses the local user's "Application data" directory when it needs to write
# stuff to disk (e.g. error log, preferences file & stylesheet conversions)  
if Utils::os_mswin?
  require 'win32ole'
    path =  ENV['APPDATA'].to_s + '\AuthorityEditorSettings'
    version = path + '\version\version_' + Domain::PROGRAM_VERSION
    unless File.exist?(version)
      if File.exist?(path)
        Dir.mkdir(path + '\tmp') unless File.exist?(path + '\tmp')
        Dir.mkdir(path + '\version') unless File.exist?(path + '\version')
        FileUtils.cp('data/preferences.xml', path) unless File.exist?(path + '\preferences.xml')
        FileUtils.cp('data/xsl_manifest.xml', path) unless File.exist?(path + '\xsl_manifest.xml')
      else
        Dir.mkdir(path)
        Dir.mkdir(path + '\tmp')
        Dir.mkdir(path + '\version')
        FileUtils.cp('data/preferences.xml', path)
        FileUtils.cp('data/xsl_manifest.xml', path)
      end
      FileUtils.touch(version)
    end 
    APPPATH = path
    TMPPATH = path + '\tmp'
else
    APPPATH = 'data'
    TMPPATH = 'tmp'
end

# Send errors to a log file
$stderr = File.new(APPPATH + '/error_log.txt', 'a')






