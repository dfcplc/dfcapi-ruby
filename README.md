# DFCAPI for PHP [![Build Status](https://api.travis-ci.org/dfcplc/dfcapi-ruby.png)](https://travis-ci.org/dfcplc/dfcapi-ruby)

The DFC API is a Restful API which has been built to facilitate the ability to Setup/Ammend/Cancel & View Direct Debits with Debit Finance Collections Plc

## Installing

Requirements: **Ruby >= 2.0**

To utilize the DFC API Client Library, install the `dfcapi` gem:

```
gem install dfcapi
```

After installing the gem package you can now begin to simplifying requests by requiring `dfcapi`:

```ruby
require 'dfcapi'
```

## Checking API Credentials

In order to validate your API Credentials against our API, call the `checkApiKey` method:

```ruby
dfcapi_check = Dfcapi.checkApiKey('TEST-TEST-TEST-TEST', 'a94a8fe5ccb19ba61c4c0873d391e987982fbbd3')

dfcapi_check # API Credential Check Response (true or false)
```

## View Direct Debit

In order to view a Direct Debit setup with DFC, we use the `viewDd` method:

```ruby
dfcapi_view = Dfcapi.viewDd('TEST-TEST-TEST-TEST', 'a94a8fe5ccb19ba61c4c0873d391e987982fbbd3', '000101AA0001')

dfcapi_view # Direct Debit View Response (Object or false if failed)
```

## View Direct Debit Breakdown

In order to view a Direct Debit's Payment Breakdown setup with DFC, we use the `viewDdBreakdown` method:

```ruby
dfcapi_view = Dfcapi.viewDdBreakdown('TEST-TEST-TEST-TEST', 'a94a8fe5ccb19ba61c4c0873d391e987982fbbd3', '000101AA0001')

dfcapi_view # Direct Debit View Response (Array or false if failed)
```

<hr>
### Thanks
Thanks go out to:
* [thefosk](https://github.com/thefosk) @ [mashape.com](https://mashape.com) - Unirest Restful Library
