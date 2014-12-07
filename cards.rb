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
    entry = pp[i]
    next unless entry && entry.match(/[α-ωΑ-Ω]/ )
    alt_index =
    if i != 1
      1
    elsif pp[3] && pp[3].match(/[α-ωΑ-Ω]/ )
      3
    elsif pp[5] && pp[5].match(/[α-ωΑ-Ω]/ )
      5
    elsif pp[2] && pp[2].match(/[α-ωΑ-Ω]/ )
      2
    else
      0
    end
    prompt_form = strip_macrons(entry)
    prompt_form = contract(prompt_form) if i == 1
    forward = "%s\t%s: %s<br><br>%s (%d)<br><br>%s" % [prompt_form, entry, names[i], pp[alt_index], alt_index, pp[0]]
    cards.puts(forward)
    prompt_form = strip_macrons(pp[alt_index])
    prompt_form = contract(prompt_form) if alt_index == 1
    reverse = "%s<br><br>%s;%s" % [prompt_form, names[i], entry]
    cards_reverse.puts(reverse)
  end
end

cards.close
cards_reverse.close
