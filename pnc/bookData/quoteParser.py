from bs4 import BeautifulSoup

# Input HTML content
html_content = """
<div class="quoteText">
      &ldquo;Time isn’t precious at all, because it is an illusion. What you perceive as precious is not time but the one point that is out of time: the Now. That is precious indeed. The more you are focused on time—past and future—the more you miss the Now, the most precious thing there is.&rdquo;
    <br />
  &#8213;
  <span class="authorOrTitle">
    Eckhart Tolle,
  </span>
    <span id=quote_book_link_6708>
      <a class="authorOrTitle" href="/work/quotes/840520">The Power of Now: A Guide to Spiritual Enlightenment</a>
    </span>
</div>
<div class="quoteText">
      &ldquo;I have lived with several Zen masters -- all of them cats.&rdquo;
    <br />
  &#8213;
  <span class="authorOrTitle">
    Eckhart Tolle,
  </span>
    <span id=quote_book_link_6708>
      <a class="authorOrTitle" href="/work/quotes/840520">The Power of Now: A Guide to Spiritual Enlightenment</a>
    </span>
</div>
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





