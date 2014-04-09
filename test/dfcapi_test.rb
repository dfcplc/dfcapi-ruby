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

require_relative '../lib/dfcapi'
require 'test/unit'
require 'shoulda'

module Dfcapi
  class ApiTest < Test::Unit::TestCase

    should "Check API Key" do

      Dfcapi.setCheckKeyUrl('http://httpbin.org/get')

      Dfcapi.checkApiKey('TEST-TEST-TEST-TEST', 'a94a8fe5ccb19ba61c4c0873d391e987982fbbd3')

      assert Dfcapi.getResponseCode() == 200

      headers = Dfcapi.getResponseBody()['headers']
      assert headers['Authorization'] == "Basic VEVTVC1URVNULVRFU1QtVEVTVDphOTRhOGZlNWNjYjE5YmE2MWM0YzA4NzNkMzkxZTk4Nzk4MmZiYmQz"

    end

    should "View Direct Debit" do

        Dfcapi.setViewDirectDebitUrl('http://httpbin.org/get')

        Dfcapi.viewDirectDebit('TEST-TEST-TEST-TEST', 'a94a8fe5ccb19ba61c4c0873d391e987982fbbd3', '000101AA0001')

        assert Dfcapi.getResponseCode() == 200

        headers = Dfcapi.getResponseBody()['headers']
        assert headers['Authorization'] == "Basic VEVTVC1URVNULVRFU1QtVEVTVDphOTRhOGZlNWNjYjE5YmE2MWM0YzA4NzNkMzkxZTk4Nzk4MmZiYmQz"

        assert Dfcapi.getResponseBody()['args']['dfc_reference'] == "000101AA0001"

    end

    should "View Direct Debit Breakdown" do

        Dfcapi.setViewDirectDebitBreakdownUrl('http://httpbin.org/get')

        Dfcapi.viewDirectDebitBreakdown('TEST-TEST-TEST-TEST', 'a94a8fe5ccb19ba61c4c0873d391e987982fbbd3', '000101AA0001')

        assert Dfcapi.getResponseCode() == 200

        headers = Dfcapi.getResponseBody()['headers']
        assert headers['Authorization'] == "Basic VEVTVC1URVNULVRFU1QtVEVTVDphOTRhOGZlNWNjYjE5YmE2MWM0YzA4NzNkMzkxZTk4Nzk4MmZiYmQz"

        assert Dfcapi.getResponseBody()['args']['dfc_reference'] == "000101AA0001"

    end

    should "Setup Direct Debit" do

        Dfcapi.setCreateDirectDebitUrl('http://httpbin.org/post')

        Dfcapi.createDirectDebit('TEST-TEST-TEST-TEST','fee78bd3bf59bfb36238b3f67de0a6ea103de130','0001','ABC00001','Mr','Joe','Bloggs','1 Park Lane','','','London','','E15 2JG',[10,10,10,10,10,10,10,10,10,10,10,10],'joebloggs@email.com','00000000','000000','2015-01-01',12,1,'MONTH','Y','1970-01-01','01234567890','07777777777','Y','Gym Membership','', false)

        assert Dfcapi.getResponseCode() == 200

        assert Dfcapi.getResponseBody()['data'] == '{"authentication":{"apikey":"TEST-TEST-TEST-TEST","apisecret":"fee78bd3bf59bfb36238b3f67de0a6ea103de130","client_ref":"0001"},"payer":{"title":"Mr","first_name":"Joe","last_name":"Bloggs","birth_date":"1970-01-01"},"address":{"address1":"1 Park Lane","address2":"","address3":"","town":"London","county":"","postcode":"E15 2JG","skip_check":false},"contact":{"phone":"07777777777","mobile":"01234567890","email":"joebloggs@email.com","no_email":"Y"},"bank":{"account_number":"00000000","sort_code":"000000"},"subscription":{"reference":"ABC00001","description":"Gym Membership","amounts":[10,10,10,10,10,10,10,10,10,10,10,10],"interval":{"unit":1,"frequency":"MONTH"},"start_from":"2015-01-01","installments":12,"bacs_reference":"","roll_status":"Y"}}'
    end

    should "Update Direct Debit" do

        Dfcapi.setUpdateDirectDebitUrl('http://httpbin.org/post')

        Dfcapi.updateDirectDebit('TEST-TEST-TEST-TEST','fee78bd3bf59bfb36238b3f67de0a6ea103de130','000101AA0001','','','','','','','','','','','','','','','','','15','012015','','','','','')

        assert Dfcapi.getResponseCode() == 200

        assert Dfcapi.getResponseBody()['data'] == '{"authentication":{"apikey":"TEST-TEST-TEST-TEST","apisecret":"fee78bd3bf59bfb36238b3f67de0a6ea103de130","dfc_ref":"000101AA0001"},"payer":{"title":"","first_name":"","last_name":"","birth_date":""},"address":{"address1":"","address2":"","address3":"","town":"","county":"","postcode":""},"contact":{"phone":"","mobile":"","email":""},"bank":{"account_number":"","sort_code":""},"general":{"yourref":"","paymentdate":"15","installmentduedate":"","installmentamount":"","latepayment":"","applyfrom":"","applyfrom_paydate":"012015","newamount":""}}'
    end

    should "Cancel Direct Debit" do

        Dfcapi.setCancelDirectDebitUrl('http://httpbin.org/post')

        Dfcapi.cancelDirectDebit('TEST-TEST-TEST-TEST', 'a94a8fe5ccb19ba61c4c0873d391e987982fbbd3', '000101AA0001', '2015-01-01')

        assert Dfcapi.getResponseCode() == 200

        assert Dfcapi.getResponseBody()['data'] == '{"authentication":{"apikey":"TEST-TEST-TEST-TEST","apisecret":"a94a8fe5ccb19ba61c4c0873d391e987982fbbd3","dfc_ref":"000101AA0001"},"cancel":{"apply_from":"2015-01-01"}}'

    end

  end
end
