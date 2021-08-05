{% macro unload_records(model, stage_name, time_field, time_part, time_value) %}
    {% set time_since = "dateadd(" ~ time_part ~ ", " ~ time_value ~ ", " ~ time_field ~ ")" %}
    {% set fields = dbt_utils.star(from=model) %}
    {% set query = "SELECT " ~ fields ~ ", " ~ lumenad_utils.unload_partition_keys(time_field) ~ " FROM " ~ model ~ " WHERE " ~ time_field ~ " >= " ~ time_since %}
    {% set s3_path = "@" ~ stage_name ~ "/" ~ model.database ~ '/' ~ model.schema ~ '/' ~ model.table %}
    {% do lumenad_utils.unload_to_s3(query, s3_path) %}
{% endmacro %}
