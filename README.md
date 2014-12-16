Flashcard generator for principal parts of classical Greek verbs

To Use:

Replace the file verbs.csv with a CSV of the verbs you want to study. It should have the following column headers:
1,2,3,4,5,6: corresponding principal part
e: Definition in English (or another language)

Other columns will be ignored.

Run the script with Ruby 2.0:
$ ruby cards.rb

Import the generated verbs.txt and verbs_reverse.txt into Anki or other flashcard software.

The sample files contain the verbs from Hansen and Quinn, *Greek: An Intensive Course*, Second Edition, Units 1-17.

Cards from the generated verbs.txt will prompt the user to recognize each principal part of each verb. The front will be shown as the word would appear in a book: macrons will be stripped, and contractions will be performed. The back will show the word with all detail as it appears in the CSV, with its tense name along with another form and the definition.

