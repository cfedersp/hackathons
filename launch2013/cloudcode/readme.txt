Activity Counter Example:
curl -X POST \
  -H "X-Parse-Application-Id: nc3nC6OhDI4M7UHHRaFAn6rNqz3s4FimO9zYbX9D" \
  -H "X-Parse-REST-API-Key: 8rFN92gSIF45t2ShrB1P0ERgVWoOcvafoTqlSVG9" \
  -H "Content-Type: application/json" \
  --data '{"ids":["582175319","548611258","16200251","46303114"]}' \
  https://api.parse.com/1/functions/SummarizeActivityCounts

Who, among my friends, are the cliq users?
curl -X GET -H "Content-Type: application/json" \
 -H "X-Parse-Application-Id: nc3nC6OhDI4M7UHHRaFAn6rNqz3s4FimO9zYbX9D" \
  -H "X-Parse-REST-API-Key: 8rFN92gSIF45t2ShrB1P0ERgVWoOcvafoTqlSVG9" \
  -G \
  --data-urlencode 'where={"fbUserId":{"$in":["582175319","548611258","16200251","46303114"]}}' \
  https://api.parse.com/1/classes/PFUser


Who is down for a particular activity?
curl -X GET -H "Content-Type: application/json" \
 -H "X-Parse-Application-Id: nc3nC6OhDI4M7UHHRaFAn6rNqz3s4FimO9zYbX9D" \
  -H "X-Parse-REST-API-Key: 8rFN92gSIF45t2ShrB1P0ERgVWoOcvafoTqlSVG9" \
  -G \
  --data-urlencode 'where={"downFor":"drink"}' \
  https://api.parse.com/1/classes/PFUser


curl -X GET -H "Content-Type: application/json" \
 -H "X-Parse-Application-Id: nc3nC6OhDI4M7UHHRaFAn6rNqz3s4FimO9zYbX9D" \
  -H "X-Parse-REST-API-Key: 8rFN92gSIF45t2ShrB1P0ERgVWoOcvafoTqlSVG9" \
  -G \
  --data-urlencode 'where={"downFor":"drink","fbUserId":{"$in":["582175319","548611258","16200251","46303114"]}}' \
  https://api.parse.com/1/classes/PFUser
