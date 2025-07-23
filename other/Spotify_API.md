# Spotify API

- [Spotify API](#spotify-api)
  - [Dashboard](#dashboard)
  - [Token取得](#token取得)

## Dashboard

[https://developer.spotify.com/dashboard](https://developer.spotify.com/dashboard)

## Token取得

``` bash
client_id=
secret=

url -X POST "https://accounts.spotify.com/api/token" \
    -H "Content-Type: application/x-www-form-urlencoded" \
    -d "grant_type=client_credentials&client_id=$client_id&client_secret=$secret"

```