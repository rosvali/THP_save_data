require 'bundler'
Bundler.require

require_relative "../lib/app/scrapper"
require 'open-uri'

tmp = Scrapper.new

describe "mairie_christmas fonction" do
	it "emails display an array whitout nil" do
			expect(tmp.emails.is_a? Array).to eq true
			expect(tmp.emails.all? { |elem| elem.class == Hash}).to be true
	end
	it "Mairie has a least few city" do 
			expect((tmp.mairie_christmas[0]).key?("ABLEIGES")).to eq true
			expect((tmp.mairie_christmas[1]).key?("AINCOURT")).to eq true
	end
end

describe "save_as_json fonction" do 
	it "save_as_json should write something in emails.json" do
		expect(tmp.save_as_json.is_a? Integer).to eq true
	end
end

describe "save_as_csv fonction" do 
	it "save_as_csv should write something in emails.csv" do 
		expect(tmp.save_as_csv.is_a? Array).to eq true
	end
end