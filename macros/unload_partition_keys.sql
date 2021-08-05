{% macro unload_partition_keys(time_field) %}
    {% set keys = [
        "to_varchar(" ~ time_field ~ ", 'YYYY') as year",
        "to_varchar(" ~ time_field ~ ", 'MM') as month",
        "to_varchar(" ~ time_field ~ ", 'DD') as day",
        "to_varchar(" ~ time_field ~ ", 'HH24') as hour"
    ]  | join(', ') %}
    {{ return(keys) }}
{% endmacro %}