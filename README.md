# Ruby Wrapper for [Stitch Data](https://www.stitchdata.com/)'s Import API

The Stitch Import API is a REST API that allows you to push arbitrary data into
your data warehouse. Once the data enters the Import API, it’ll be processed and
sent through Stitch like data from any other integration.

### Setup

##### α) include the gem

Rails:

```rb
gem 'stitch_data', github: 'theminijohn/mini_stitch'
```

##### β) Authentication

Authentication with the Import API is done with a single API access token placed in the Authorization header of your request and [your client ID](https://www.stitchdata.com/docs/integrations/import-api#client-id), which will be used in the request body.

```rb
# initializers/mini_stitch.rb
MiniStitch.configure do |config|
  config.token = "your-api-token"
  config.client_id = "your-client-id"
end
```

### Usage

I recommend you take a look at the [Stitch Data Import Api Doc](https://www.stitchdata.com/docs/integrations/import-api) to get the gist of what the `upsert`, `validate` & `status` methods do. Yes, this gem has only 3 methods ☀️

!! For the Wrapper to successfully accept and process your data, your call must contain all of the request fields listed below:

- **table_name** | `String`
This field contains the name of the destination table

- **sequence** | `String`
This property tells the Import API the order in which data points in the request body should be considered. See [Defining Sequence](https://www.stitchdata.com/docs/integrations/import-api#defining-the-sequence) for more info. The most straightforward way is to use `Time.now.to_i` to get the current time in posix format.

- **key_names** | `Array` | 🔑
This field defines the *Primary Key* and will contain an array of field names that uniquely identify the row that the record belongs to. *Primary Keys* identify unique rows within a table and ensure that only the most recently updated version of that record appears in your data warehouse.

- **data** | `Array of Hashes`
This field contains the data to be upserted into your data warehouse.

1. #### Status

> The status endpoint can be used to determine if the Import API is operating correctly.

```rb
MiniStitch.status
```

2. #### Validate

> The validate endpoint can be used to validate requests but **will not persist them** to Stitch

```rb
MiniStitch::Api.new(table_name, sequence, [key_names], [data]).validate!
```

3. #### Upsert

> The upsert endpoint is used to **push data** into your data warehouse.

```rb
MiniStitch::Api.new(table_name, sequence, [key_names], [data]).upsert!
```
