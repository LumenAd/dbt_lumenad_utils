{% macro unload_records(model, stage_name, time_field, time_part, time_value) %}
    {% set time_since = "timestampadd(" ~ time_part ~ ", " ~ time_value ~ ", current_timestamp())" %}
    {% set fields = dbt_utils.star(from=model) %}
    {% set query = "SELECT " ~ fields ~ ", " ~ lumenad_utils.unload_partition_keys(time_field) ~ " FROM " ~ model ~ " WHERE " ~ time_field ~ " >= " ~ time_since %}
    {% set s3_path = "@" ~  model.database|lower ~ '.' ~ model.schema|lower ~ '.' ~ stage_name ~ "/" ~ model.database|lower ~ '/' ~ model.schema|lower ~ '/' ~ model.table|lower %}
    {% set file_format = model.database|lower ~ '.' ~ model.schema|lower ~ '.parquet_file_type' %}
    {% do lumenad_utils.unload_to_s3(query, s3_path, file_format) %}
{% endmacro %}
