### Ruby CLI

This is a simple ruby CLI that could be run to fetch temperature details of cities in Spain.

### Running the CLI

Download the ruby file, ensure that a ruby is installed.

## To get temperature of the day, the average minima and maxima of the week
```
 ruby temperature.rb  'eltiempo -all 'Gavà''
```

## To get temperature of the day
```
 ruby temperature.rb  'eltiempo -today 'Gavà''
```

## To get the average minima of the week
```
 ruby temperature.rb  'eltiempo -av_min 'Gavà''
```

## To get the average maxima of the week
```
 ruby temperature.rb  'eltiempo -av_max 'Gavà''
```

## To run the test cases
```
rspec spec/temperature_city_spec.rb
```


### Future implementation
- More Test cases
- Circuit breaking mechanism
- Setup CI
- Include Dockerfile