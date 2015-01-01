# coding: utf-8
require 'csv'
verb_list = "verbs.csv"
cards = File.open("verbs.txt", "w")
cards_reverse = File.open("verbs_reverse.txt", "w")
names = ["English","1 Present","2 Future", "3 Aorist", "4 Perfect", "5 Perfect Passive", "6 Aorist Passive"]
def strip_macrons(s)
  s.tr("ᾱῑῡ", "αιυ").tr("̄", "")
end
def contract(s)
  s.sub( /[άέό]ω/, "ῶ").sub( /[έό]ο/, "οῦ").sub("άο", "ῶ")
end

entries = CSV.open(verb_list, :headers => true)
entries.each do |e|
  pp = [e['e'],e['1'], e['2'],e['3'],e['4'],e['5'],e['6']]
  (1..6).each do |i|
    listing = pp[i]
    next unless listing && listing.match(/[α-ωΑ-Ω]/ )
    alt_prefs = [1,3,5,2,4]
    alt_index = 0
    alt_prefs.each do |k|
      if i != k && pp[k] && pp[k].match(/[α-ωΑ-Ω]/ )
        alt_index = k
        break
      end
    end
    listings = listing.split(" / ")
    listings.each do |entry|
      prompt_form = strip_macrons(entry)
      prompt_form = contract(prompt_form) if i == 1
      forward = "%s\t%s: %s<br><br>%s (%d)<br><br>%s" % [prompt_form, listing, names[i], pp[alt_index], alt_index, pp[0]]
      cards.puts(forward)
    end
    prompt_form = strip_macrons(pp[alt_index])
    prompt_form = contract(prompt_form) if alt_index == 1
    reverse = "%s<br><br>%s;%s" % [prompt_form, names[i], listing]
    cards_reverse.puts(reverse)
  end
end

cards.close
cards_reverse.close
