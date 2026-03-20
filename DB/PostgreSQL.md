# PostgreSQL

- [PostgreSQL](#postgresql)
  - [current\_date -\> Integer](#current_date---integer)

## current_date -> Integer

``` sql
to_char(current_date, 'YYYYMMDD')::integer
```