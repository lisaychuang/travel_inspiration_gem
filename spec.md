# Specifications for the CLI Assessment

Specs:
- **[x] Have a CLI for interfacing with the application**

My CLI logic is defined in lib/clib.rb file. Once a user installs the gem and executes ```inspire_me``` file, he/she will be prompted with two questions:

1. "Hello! Which travel inspiration will you like to explore for your next trip?"
2. "Here are the top 6 destinations for (theme). Please select a destination from 1 - 6"

User input is then captured, and used to select an inspiration theme and destination.  Finally, more information for the selected country will be displayed.

- **[x] Pull data from an external source**

In my gem, I am scraping data from [Lonely Planet](https://www.lonelyplanet.com) homepage. Scraper logic are defined in three files: lib/themes.rb, lib/destinations.rb, lib/country.rb. 

- **[x] Implement both list and detail views**
There are two layers of list views: Travel inspiration themes, and the 6 destinations per theme.
User can drill down into a specific destination, a "country" and review more details.
