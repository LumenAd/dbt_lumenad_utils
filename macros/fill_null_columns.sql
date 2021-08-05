{% macro fill_null_columns(columns) %}
    {%- for column in columns %}
        null::{{ column.datatype }} as {{ column.name }}
        {%- if not loop.last -%} , {% endif -%}
    {% endfor %}
{% endmacro %}