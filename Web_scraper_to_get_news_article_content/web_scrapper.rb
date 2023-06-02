require 'csv'
require 'nokogiri'
require 'open-uri'

# Function to fetch and parse the HTML content from the given URL
def fetch_url_content(url)
  begin
    # Open the URL and read its content
    html_uri = URI.open(url)

    # Parse the HTML content using Nokogiri
    html_doc = Nokogiri::HTML(html_uri)
    return html_doc
  rescue => e
    # Handle any errors that occur during the process
    puts "Error: #{e.message}"
    return nil
  end
end

# Function to write the page title and content to a CSV file
def write_to_csv(file_path, page_title, page_content)
  CSV.open(file_path, 'w') do |csv|
    csv << ['Title', 'Content'] # Write the headers
    csv << [page_title, page_content] # Write the data
  end

  puts "Output written to #{file_path}"
end

# Function to fix the text content by converting it to proper encoding and handling invalid characters
def fix_text_content(text)
  # Convert the text to UTF-8 encoding with proper replacements
  text.encode('UTF-8', invalid: :replace, undef: :replace, replace: '')
    .gsub(/â|â\b/, "'")
    .gsub(/â|â\b/, "'")
    .gsub(/â¦|â¦\b/, "...")
    .gsub(/â|â\b/, "-")
    .gsub(/â|â|â|â\b/, "\"")
    .gsub(/â|â|â|â\b/, "'")
end


# Requesting user input for the URL
puts "Enter your URL:"
url = gets.chomp.to_s

# Fetch and parse the HTML content from the URL
html_doc = fetch_url_content(url)

if html_doc.nil?
  puts "Failed to fetch and parse the HTML content."
else
  # Extract the page title using CSS selectors
  web_page_title = fix_text_content(html_doc.css('h1').text)

  # Extract the page content using CSS selectors and fix any unwanted characters
  web_page_content = fix_text_content(html_doc.css('p').text)

  # Specify the file path to write the CSV output
  file_path = 'output.csv'

  # Write the page title and content to the CSV file
  write_to_csv(file_path, web_page_title, web_page_content)
end
