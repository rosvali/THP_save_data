require 'open-uri'

class Scrapper

	attr_accessor :emails

	def initialize
		@emails = mairie_christmas
	end

	def get_email(nom)
		nomCommune = nom['href'].delete_prefix "." 
		page2 = Nokogiri::HTML(URI.open("http://annuaire-des-mairies.com#{nomCommune}"))
		email = page2.css('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]').text
	end

	def mairie_christmas
		pages = Nokogiri::HTML(URI.open('http://annuaire-des-mairies.com/val-d-oise.html'))
		temp = pages.css('[@class="lientxt"]')
		tab = temp.map { |nom| { nom.text => get_email(nom)} }
	end

	def save_as_json
		File.open("lib/db/emails.json","w") { |f| f.write(JSON.pretty_generate(@emails)) }
	end

	def save_as_csv
		CSV.open("lib/db/emails.csv", "w") { |csv| @emails.each { |data| csv << [data.keys, data.values]}}
	end

	def perform
		save_as_json
		save_as_csv
	end

end