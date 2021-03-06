{% macro unload_to_s3(query, s3_path, file_format) %}
    {% set unload_query %}
        COPY INTO {{ s3_path }} FROM ({{ query }})
        PARTITION BY (concat('year=' || year, '/month=' || month, '/day=' || day, '/hour=' || hour))
        FILE_FORMAT = (format_name = {{ file_format }})
        HEADER = true
    {% endset %}
    {% do run_query(unload_query) %}
{% endmacro %}