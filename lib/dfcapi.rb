# The MIT License
#
# Copyright (c) 2014 Debit Finance Collections Plc (http://debitfinance.co.uk)

# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#

require 'rubygems'
require 'unirest'

module Dfcapi

  @@api_url_checkkey = "https://api.debitfinance.co.uk/checkkey"
  @@api_url_viewdd = "https://api.debitfinance.co.uk/viewdd"
  @@api_url_viewddbreakdown = "https://api.debitfinance.co.uk/viewddbreakdown"
  @@api_url_setupdd = "https://api.debitfinance.co.uk/setupdd"
  @@api_url_updatedd = "https://api.debitfinance.co.uk/updatedd"
  @@api_url_canceldd = "https://api.debitfinance.co.uk/canceldd"

  @@errors = {}
  @@response_code = false
  @@body = false
  @@raw_body = false
  @@headers = {}

  class Dfcapi

    def self.setCheckKeyUrl(checkkey_url)
      @@api_url_checkkey = checkkey_url
    end

    def self.setViewDirectDebitUrl(viewdd_url)
        @@api_url_viewdd = viewdd_url
    end

    def self.setViewDirectDebitBreakdownUrl(viewddbreakdown_url)
        @@api_url_viewddbreakdown = viewddbreakdown_url
    end

    def self.setCreateDirectDebitUrl(setupdd_url)
        @@api_url_setupdd = setupdd_url
    end

    def self.setUpdateDirectDebitUrl(updatedd_url)
        @@api_url_updatedd = updatedd_url
    end

    def self.setCancelDirectDebitUrl(canceldd_url)
        @@api_url_canceldd = canceldd_url
    end

    def self.clearStoredResponse
        @@errors = {}
        @@response_code = false
        @@body = false
        @@raw_body = false
        @@headers = {}
    end

    def self.getErrors
        return @@errors
    end

    def self.getResponseCode
        return @@response_code
    end

    def self.getResponseBody
        return @@body
    end

    def self.getResponseBodyRaw
        return @@raw_body
    end

    def self.getResponseHeaders
        return @@headers
    end

    def self.setStoredResponse(response)
        @@errors = response.body['errors']
        @@response_code = response.code
        @@body = response.body
        @@raw_body = response.raw_body
        @@headers = response.headers
    end

    def self.checkApiKey(api_key, api_secret)
      self.clearStoredResponse

      response = Unirest.get @@api_url_checkkey, auth:{:user=>api_key, :password=>api_secret}

      self.setStoredResponse response

      if(response.code === 200 && response.body['status'] === 'ok')
        return true
      end


      return false

    end

    def self.viewDirectDebit(api_key, api_secret, dfc_reference)
        self.clearStoredResponse

        response = Unirest.get @@api_url_viewdd, auth:{:user=>api_key, :password=>api_secret}, parameters:{ :dfc_reference => dfc_reference }

        self.setStoredResponse response

        if(response.code === 200 && response.body['status'] === 'ok')
          return response.body
        end


        return false
    end

    def self.viewDirectDebitBreakdown(api_key, api_secret, dfc_reference)
        self.clearStoredResponse

        response = Unirest.get @@api_url_viewddbreakdown, auth:{:user=>api_key, :password=>api_secret}, parameters:{ :dfc_reference => dfc_reference }

        self.setStoredResponse response

        if(response.code === 200 && response.body['status'] === 'ok')
          return response.body
        end


        return false
    end


    def self.createDirectDebit(api_key, api_secret, client_reference, reference, title, first_name, last_name, address1, address2, address3, town, county, postcode, amounts, email, account_number, sort_code, start_from, installments, frequency_unit, frequency_type, roll_status, birth_date, mobile_number, phone_number, no_email, service_description, bacs_reference, skip_check)

      self.clearStoredResponse

      response = Unirest.post @@api_url_setupdd,
                              headers: {
                                "Content-Type" => "application/json",
                                "Accept" => "application/json"
                              },
                              parameters: {
                                :authentication => {
                                  :apikey => api_key,
                                  :apisecret => api_secret,
                                  :client_ref => client_reference
                                },
                                :payer => {
                                  :title => title,
                                  :first_name => first_name,
                                  :last_name => last_name,
                                  :birth_date => birth_date
                                },
                                :address => {
                                  :address1 => address1,
                                  :address2 => address2,
                                  :address3 => address3,
                                  :town => town,
                                  :county => county,
                                  :postcode => postcode,
                                  :skip_check => skip_check
                                },
                                :contact => {
                                  :phone => phone_number,
                                  :mobile => mobile_number,
                                  :email => email,
                                  :no_email => no_email
                                },
                                :bank => {
                                  :account_number => account_number,
                                  :sort_code => sort_code
                                },
                                :subscription => {
                                  :reference => reference,
                                  :description => service_description,
                                  :amounts => amounts,
                                  :interval => {
                                    :unit => frequency_unit,
                                    :frequency => frequency_type
                                  },
                                  :start_from => start_from,
                                  :installments => installments,
                                  :bacs_reference => bacs_reference,
                                  :roll_status => roll_status
                                }
                              }.to_json

      self.setStoredResponse response

      if(response.code === 200 && response.body['status'] === 'ok')
        return true
      end

      return false

    end


    def self.updateDirectDebit(api_key, api_secret, dfc_reference, reference, title, first_name, last_name, address1, address2, address3, town, county, postcode, email, account_number, sort_code, birth_date, mobile_number, phone_number, paymentdate, applyfrom_paydate, installmentduedate, installmentamount, latepayment, applyfrom, newamount)
      self.clearStoredResponse

      response = Unirest.post @@api_url_updatedd,
                              headers: {
                                "Content-Type" => "application/json",
                                "Accept" => "application/json"
                              },
                              parameters: {
                                :authentication => {
                                  :apikey => api_key,
                                  :apisecret => api_secret,
                                  :dfc_ref => dfc_reference
                                },
                                :payer => {
                                  :title => title,
                                  :first_name => first_name,
                                  :last_name => last_name,
                                  :birth_date => birth_date
                                },
                                :address => {
                                  :address1 => address1,
                                  :address2 => address2,
                                  :address3 => address3,
                                  :town => town,
                                  :county => county,
                                  :postcode => postcode
                                },
                                :contact => {
                                  :phone => phone_number,
                                  :mobile => mobile_number,
                                  :email => email
                                },
                                :bank => {
                                  :account_number => account_number,
                                  :sort_code => sort_code
                                },
                                :general => {
                                  :yourref => reference,
                                  :paymentdate => paymentdate,
                                  :installmentduedate => installmentduedate,
                                  :installmentamount => installmentamount,
                                  :latepayment => latepayment,
                                  :applyfrom => applyfrom,
                                  :applyfrom_paydate => applyfrom_paydate,
                                  :newamount => newamount
                                }
                              }.to_json

      self.setStoredResponse response

      if(response.code === 200 && response.body['status'] === 'ok')
        return true
      end

      return false

    end


    def self.cancelDirectDebit(api_key, api_secret, dfc_reference, cancel_date)
      self.clearStoredResponse

      response = Unirest.post @@api_url_canceldd,
                              headers: {
                                "Content-Type" => "application/json",
                                "Accept" => "application/json"
                              },
                              parameters: {
                                :authentication => {
                                  :apikey => api_key,
                                  :apisecret => api_secret,
                                  :dfc_ref => dfc_reference
                                },
                                :cancel => {
                                  :apply_from => cancel_date
                                }
                              }.to_json

      self.setStoredResponse response

      if(response.code === 200 && response.body['status'] === 'ok')
        return true
      end

      return false

    end
  end

end
