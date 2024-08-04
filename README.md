 <a href="https://badge.fury.io/rb/iprog_export_model_to_xlsx"><img src="https://badge.fury.io/rb/iprog_export_model_to_xlsx.svg" alt="Gem Version" height="18"></a>

# Iprog Export Model To Xlsx
Welcome to iprog_export_model_to_xlsx! This gem provides functionality to export ActiveRecord models to XLSX format.

 <img src="https://github.com/iprog21/iprog_export_model_to_xlsx/blob/main/iprog-logo.png" width="150" alt="IPROG TECH" align="right" />

 This gem is provided by [**IPROG TECH**](https://www.iprog.tech/), an information technology company specializing in web development services using Ruby on Rails. IPROG TECH also offers free programming tutorials.

**Providing Good Quality Web Services:**
- Startup
- Maintenance
- Upgrading & Conversion

# Getting Started

## Installation
To install the gem and add it to your application's Gemfile, run on your terminal:

```bash
bundle add iprog_export_model_to_xlsx
```

If you're not using Bundler to manage dependencies, install the gem by running:

```bash
gem install iprog_export_model_to_xlsx
```

## Initialization
To use the gem in your rails project, include it with:

```ruby
# app/models/model.rb
require 'iprog_export_model_to_xlsx'

class Model < ApplicationRecord
 extend IprogExportModelToXlsx

end
```

You can then export your models to XLSX format as shown below.

### Basic Usage
Export without any options:

```bash
# with default filepath
Model.export_to_xlsx 
 Output file: rails_app_folder/models.xlsx

# with custom filepath
Model.export_to_xlsx('public/custom_models.xlsx')
 Output file: rails_app_folder/public/models.xlsx
```

### Sample with Options in a Model Class
You can customize the export by providing options:

```ruby
# adding custom class methods
require 'iprog_export_model_to_xlsx'

class Model < ApplicationRecord
 extend IprogExportModelToXlsx

 def self.export_published_items_to_xlsx filepath = nil

  # Custom condition
  custom_conditions = ->(scope) { scope.where(status: 'published') }

  # Custom column formats
  column_formats = { 'status' => ->(value) { value.upcase } }

  # Custom progress callback
  custom_progress_callback = ->(current, total) { puts "Custom Progress: Exported #{current}/#{total} records" } 

  options = {
   exclude_columns: ['created_at', 'updated_at'],
   limit: 100,
   conditions: custom_conditions,
   column_formats: column_formats,
   sheet_name: "Published Items",
   progress_callback: custom_progress_callback
  }

  # with custom filepath
  export_to_xlsx(filepath, options)

  # OR

  # with default filepath
  export_to_xlsx(filepath, options)
 end
end

# Usage with custom file path
Model.export_published_items_to_xlsx("published_items.xlsx")
 Output: rails_app_folder/published_items.xlsx

# Usage with default file path
Model.export_published_items_to_xlsx
 Output: rails_app_folder/models.xlsx
```
  
### Sample in a Service Class
 Create a service class:

```ruby 
# app/services/model_export_service.rb
class ModelExportService
 attr_reader :model, :exclude_columns, :limit, :conditions, :sheet_name, :column_formats, :progress_callback

 def initialize(model, exclude_columns: [], limit: nil, conditions:  nil, sheet_name: nil, column_formats: {}, progress_callback: nil )
  @model             = model.constantize
  @exclude_columns   = exclude_columns
  @limit             = limit
  @conditions        = conditions
  @sheet_name        = sheet_name
  @column_formats    = column_formats
  @progress_callback = progress_callback
 end

 def export_to_xlsx(file_path = nil)
  options = {
   exclude_columns: exclude_columns,
   limit: limit,
   conditions: conditions,
   sheet_name: sheet_name,
   column_formats: column_formats,
   progress_callback: progress_callback
  }

  model.export_to_xlsx(file_path, options)
 rescue StandardError => e
  raise IprogExportModelToXlsx::Error, "Failed to export to XLSX: #{e.message}"
 end
end
```

```ruby
# Usage
model_export_service = ModelExportService.new("Model",
 excluded_columns: ["created_at", "updated_at"], 
 limit: 100, 
 column_formats:  { 'status' => ->(value) { value.upcase } }, 
 progress_callback: ->(current, total) { puts "Custom Progress: Exported #{current}/#{total} records" }
)

# Usage with custom file path
model_export_service.export_to_xlsx("published_items.xlsx")
 Output: rails_app_folder/published_items.xlsx

# Usage with default file path
model_export_service.export_to_xlsx
 Output: rails_app_folder/models.xlsx
```
 
## Contributing
Bug reports and pull requests are welcome on GitHub at https://github.com/iprog21/iprog_export_model_to_xlsx.

## License
This gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct
This project has adopted the [Contributor Covenant Code of Conduct](./CODE_OF_CONDUCT.md). By participating, you are expected to uphold this code. Please report unacceptable behavior to iprog.tech@gmail.com.
