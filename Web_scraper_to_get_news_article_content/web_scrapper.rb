require 'nokogiri'
require 'open-uri'
# require 'net/http'

# Requesting for user input i.e url.
puts "Enter your url :"

# storing the url in a variable called url
url = gets.chomp.to_s

# allows us to read from the url line by line and store the items in the variable html_uri
html_uri = URI.open(url)

# parsing the html content which will allow us to query the document with css selectors
html_doc = Nokogiri::HTML(html_uri)

# selecting specific text using tags(selectors in css)
web_page_title = html_doc.css('h1').text
web_page_content = html_doc.css('p').text

# output
puts "                                  "
puts "***********************************"
puts "***********************************"
puts "Title : #{web_page_title}"
puts "                                  "
puts "***********************************"
puts "                                  "
puts "Content : #{ web_page_content}"
