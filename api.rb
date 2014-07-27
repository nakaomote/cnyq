#!/usr/bin/ruby
# encoding: utf-8

require 'rubygems' if RUBY_VERSION < "1.9"
require 'sinatra/base'
require 'json'
require 'xmlsimple'
require 'time'

$log = File.open("api.log","a")

class MyAPI < Sinatra::Base

    get '/' do
        'Nothing to see here'
    end

    post '/' do
        content_type :json
        body              = request.body.read
        data              = JSON.parse(body)
        missing_parameter = missing_parameter?(data)
        return error_json("Missing required parameter: #{missing_parameter}") if missing_parameter
        unless data["amount"].between?(100,10000)
            return error_json("Amount '#{data["amount"]}' outside the allowed range (100 <-> 10000)")
        end
        card = get_card_details(data["credit_card"])
        unless credit_charge?(card)
            apilog "Card declined: #{card.to_json}"
            return error_json("Card declined")
        end
        apilog "Card accepted: #{card.to_json}"
        return success_json
    end

    def apilog(msg)
        $log.puts "#{Time.now.strftime("%F %T")} #{msg}"
        $log.flush
    end

    def get_card_details(credit_card)
        time = Time.parse(credit_card["expiry"])
        {
            "number"    => credit_card["number"],
            "expire_yy" => time.strftime("%y"),
            "expire_mm" => time.strftime("%m"),
        }
    end

    def credit_charge?(xml)
        require 'httpclient'

        apilog "Query credit card company: #{xml.to_json}"

        output = '<?xml version="2.0" encoding="UTF-8"?>'
        output << "\n"
        output << XmlSimple.xml_out(xml, {
                                            "AttrPrefix" => true,
                                            "RootName"   => "credit_card",
                                       },
                                   )

        client   = HTTPClient.new
        response = client.post "https://aqueous-thicket-7667.herokuapp.com/charges", output

        XmlSimple.xml_in(response.body)["code"][0].to_i == 0
    end

    def error_json(msg)
        {
            "status"  => 406,
            "message" => msg
        }.to_json
    end

    def success_json
        {
            "status"  => 200
        }.to_json
    end

    def missing_parameter?(data)
        main_keys = [
            "amount",
            "credit_card",
        ]
        credit_card_keys = [
            "number",
            "expiry",
        ]
        main_keys.each do |key|
            return key unless data.include?(key)
        end
        credit_card_keys.each do |key|
            return "credit_card -> #{key}" unless data["credit_card"].include?(key)
        end
        return false
    end
end

MyAPI.run!
