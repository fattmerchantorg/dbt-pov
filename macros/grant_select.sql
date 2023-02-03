
{% macro grant_select(user) %}
{% set sql %}
    grant usage on schema {{ target.schema }} to "{{ user }}";
    grant select on all tables in schema {{ target.schema }} to "{{ user }}";
    --grant select on all views in schema {{ target.schema }} to {{ user }};
    ALTER DEFAULT PRIVILEGES IN SCHEMA {{ target.schema }} GRANT SELECT ON TABLES TO "{{ user }}";

{% endset %}

{% do run_query(sql) %}
{% do log("Privileges granted", info=True) %}
{% endmacro %}

