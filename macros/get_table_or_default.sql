{% macro get_table_or_default(source_table, default_columns) %}
{% set source_relation = adapter.get_relation(database=source_table.database, schema=source_table.schema, identifier=source_table.name) %}
{% set table_exists=source_relation is not none   %}

{% set query %}
    {% if table_exists %}
    select * from {{ source_table }}
    {% else %}
    select {{ lumenad_utils.fill_null_columns(columns=default_columns) }}
    where false
    {% endif %}
{% endset %}

{{ return(query) }}
{% endmacro %}