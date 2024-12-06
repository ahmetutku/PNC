from bs4 import BeautifulSoup

# Input HTML content
html_content = """

"""

# Parse the HTML content using BeautifulSoup
soup = BeautifulSoup(html_content, 'html.parser')

# Extract quotes from the `quoteText` class
quotes = []  # Initialize an empty list

for quote_div in soup.find_all('div', class_='quoteText'):
    # Extract the text content, remove the author and additional text
    quote = quote_div.text.strip()
    quote = quote.split('―')[0].strip()  # Keep only the quote text before the author marker
    quote = quote.replace('\n', '').replace('&ldquo;', '"').replace('&rdquo;', '"')
    quote = quote.replace("“", '"').replace("”", '"')  # Replace curly quotes with straight quotes
    quote = quote.replace("'", "")  # Remove any single quotes inside the quote
    quotes.append(quote)

# Output the array of quotes, ensuring proper structure with double quotes around each string
print('"quotes": [' + ', '.join(f'{quote}' for quote in quotes) + ']')





