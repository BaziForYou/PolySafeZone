# Features
- Can have zones with different shapes 
- Can whitelist job with minimum rank per zones
- Can combo zones
- Don't use any helper for [PolyZone](https://github.com/mkafrin/PolyZone)
- Standalone it doesn't use any function from anywhere
- Can set job and grade with export if you are not using [es_extended](https://github.com/esx-framework/esx-legacy/)
- Optimize and get low usage (0.01 ~ 0.02 on idle if you don't turn any debug on)
- Clean coding


# Resource preview
[Video](https://youtu.be/8kdjwXO0NHM)

# Requirements
- [PolyZone](https://github.com/mkafrin/PolyZone)
- [es_extended](https://github.com/esx-framework/esx-legacy/) (optional)
- Brain

# Download & Installation

- Download https://github.com/BaziForYou/PolySafeZone/archive/main.zip
- Put it in the `resources` folder 

## Installation	
- Add this in your `server.cfg` in the following order:
```bash
start PolySafeZone
```

## Support
- Please report any issues you have in the GitHub [Issues](https://github.com/BaziForYou/PolySafeZone/issues) 

## How To Add Zone Coords?
- You can use [``/pzcreate poly``](https://github.com/mkafrin/PolyZone/wiki/Using-the-creation-script) and make zone and copy coords from ``polyzone_created_zones.txt``
- Also you can use this [``website``](https://skyrossm.github.io/PolyZoneCreator/index.html) for making zones and copy the coords 


## Exports	
#### Client

| Export                         | Description                               | Parameter(s)  | Return type          |
|----------------------------------|-----------------------------------------------|------------------------|----------------------------|
| InSafeZone                 | Return is in SafeZone or no          | Nothing       | true or false or nil               |
| SafeZoneName         | Return is player SafeZone name  | Nothing       | string                                    |
| CanAttackInSafeZone   | Return player is whitelisted to attack in SafeZone or no           | Nothing       | true or false or nil                |
| SetJobAndGrade               | Set player current job and grade           | job, grade       | Nothing               |
