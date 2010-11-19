#!/usr/bin/env ruby
#
# XML Retention and Disposal Authority Editor
#
# This program is a full implementation of State Records NSW's XML schema
# for retention and disposal authorities.
#
# Author:: Richard Lehane (mailto:richard.lehane@records.nsw.gov.au)
# Copyright:: Copyright (c) State of New South Wales through the
# State Records Authority of New South Wales, 2009
# License:: GNU General Public License
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program (see COPYING). If not, see <http://www.gnu.org/licenses/>.

require File.dirname(__FILE__) + '/environment.rb'

if $0 == __FILE__
  Gtk.init
  prog = MainWindow.new(ARGV).show_all
  Gtk.main
end
